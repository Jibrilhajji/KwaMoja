<?php

/* Form Designer notes:
 * - All measurements are in PostScript points (72 points = 25,4 mm).
 * - All coordinates are measured from the lower left corner of the sheet to
 * the top left corner of the field.
 */

/*	General attributes for elements:
- x (X coordinate),
- y (Y coordinate),
- Width,
- Height,
- FontSize,
- Alignment,
- Show (to show or not an element).
*/

// RCHACON: To Do: standardize the name of the parameters x, y, width, height, font-size, alignment and radius inside the xml files.
// RCHACON: Question: The use or not of <label for="KeyId">KeyCaption</label> <input id="KeyId" name="KeyName" type="..." value="KeyValue"> for usability ?

/* BEGIN: Start common code division. */

include('includes/session.inc');
$Title = _('Form Designer');
include('includes/header.inc');
/* END: Start common code division. */

/* BEGIN: FUNCTIONS DIVISION. */

/* Function to input the X coordinate from the left side of the sheet to the
left side of the field in points (72 points = 25,4 mm). */
function InputX($KeyName, $KeyValue) {
	echo '<td class="number">' . _('x') . ' = ' . '</td><td><input class="number" maxlength="4" name="' . $KeyName . 'x" size="4" title="' . _('Distance from the left side of the sheet to the left side of the element in points') . '" type="number" value="' . $KeyValue . '" /></td>';
}

/* Function to input the Y coordinate from the lower side of the sheet to the
top side of the field in points (72 points = 25,4 mm). */
function InputY($KeyName, $KeyValue) {
	echo '<td class="number">' . _('y') . ' = ' . '</td><td><input class="number" maxlength="4" name="' . $KeyName . 'y" size="4" title="' . _('Distance from the lower side of the sheet to the top side of the element in points') . '" type="number" value="' . $KeyValue . '" /></td>';
}

/* Function to input the the width of the field in points (72 points = 25,4 mm).*/
function InputWidth($KeyName, $KeyValue) {
	echo '<td class="number">' . _('Width') . ' = ' . '</td><td><input class="number" maxlength="4" name="' . $KeyName . 'Length" size="4" title="' . _('Width of the element in points') . '" type="number" value="' . $KeyValue . '" /></td>';
	// Requires to standardize xml files from "Length" to "Width" before changing the html name.
}

/* Function to input the the height of the field in points (72 points = 25,4 mm).*/
function InputHeight($KeyName, $KeyValue) {
	echo '<td class="number">' . _('Height') . ' = ' . '</td><td><input class="number" maxlength="4" name="' . $KeyName . 'height" size="4" title="' . _('Height of the element in points') . '" type="number" value="' . $KeyValue . '" /></td>';
	// Requires to standardize xml files from "height" to "Height" before changing the html name.
}

/* Function to select a text alignment. */
function SelectAlignment($KeyName, $KeyValue) {
	$Alignments = array(); // Possible alignments
	$Alignments['left']['Caption'] = _('Left');
	$Alignments['left']['Title'] = _('Text lines are rendered flush left');
	$Alignments['centre']['Caption'] = _('Centre');
	$Alignments['centre']['Title'] = _('Text lines are centred');
	$Alignments['right']['Caption'] = _('Right');
	$Alignments['right']['Title'] = _('Text lines are rendered flush right');
	$Alignments['full']['Caption'] = _('Justify');
	$Alignments['full']['Title'] = _('Text lines are justified to both margins');
	echo '<td>' . _('Alignment') . ' = </td><td><select name="' . $KeyName . 'Alignment">';
	foreach ($Alignments as $AlignmentValue => $AlignmentOption) {
		echo '<option';
		if ($AlignmentValue == $KeyValue) {
			echo ' selected="selected"';
		}
		echo ' title="' . $AlignmentOption['Title'] . '" value="' . $AlignmentValue . '">' . $AlignmentOption['Caption'] . '</option>';
	}
	echo '</select></td>';
}
/* Function to select a text font size. */
function SelectFontSize($KeyName, $KeyValue) {
	return array(
		6,
		8,
		9,
		10,
		11,
		12,
		13,
		14,
		15,
		16,
		18,
		20,
		22,
		24
	); //Possible font sizes
	echo '<td>' . _('Font Size') . ' = </td><td><select name="' . $KeyName . 'FontSize">';
	foreach ($FontSizes as $FontSize) {
		echo '<option';
		if ($FontSize == $KeyValue) {
			echo ' selected="selected"';
		}
		echo ' title="' . _('Font size in points') . '" value="' . $FontSize . '">' . $FontSize . '</option>';
	}
	echo '</select></td>';
}
// Function to select to show or not an element.
function SelectShowElement($KeyName, $KeyValue) {
	$Shows = array(); // Possible alignments
	$Shows['No']['Caption'] = _('No');
	$Shows['No']['Title'] = _('Does not display this element');
	$Shows['Yes']['Caption'] = _('Yes');
	$Shows['Yes']['Title'] = _('Displays this element');
	echo '<td>' . _('Show') . ' = </td><td><select name="' . $KeyName . 'Show">';
	foreach ($Shows as $ShowValue => $ShowOption) {
		echo '<option';
		if ($ShowValue == $KeyValue) {
			echo ' selected="selected"';
		}
		echo ' title="' . $ShowOption['Title'] . '" value="' . $ShowValue . '">' . $ShowOption['Caption'] . '</option>';
	}
	echo '</select></td>';
}
/* END: FUNCTIONS DIVISION. */

/* BEGIN: PROCEDURE DIVISION. */

/* If the user has chosen to either preview the form, or
 * save it then we first have to get the POST values into a
 * simplexml object and then save the file as either a
 * temporary file, or into the main code
 */
if (isset($_POST['preview']) or isset($_POST['save'])) {
	/*First create a simple xml object from the main file */
	$FormDesign = simplexml_load_file($PathPrefix . 'companies/' . $_SESSION['DatabaseName'] . '/FormDesigns/' . $_POST['FormName']);
	$FormDesign['name'] = $_POST['formname'];
	if (mb_substr($_POST['PaperSize'], -8) == 'Portrait') {
		$_POST['PaperSize'] = mb_substr($_POST['PaperSize'], 0, mb_strlen($_POST['PaperSize']) - 9);
	}
	$FormDesign->PaperSize = $_POST['PaperSize'];
	$FormDesign->LineHeight = $_POST['LineHeight'];
	/*Iterate through the object filling in the values from
	 * the POST variables */
	foreach ($FormDesign as $Key) {
		foreach ($Key as $SubKey => $Value) {
			if ($Key['type'] == 'ElementArray') {
				foreach ($Value as $SubSubKey => $subvalue) {
					$Value->$SubSubKey = $_POST[$Value['id'] . $SubSubKey];
				}
			} else {
				$Key->$SubKey = $_POST[$Key['id'] . $SubKey];
			}
		}
	}
	/* If we are just previewing the form then
	 * save it to the temporary directory and call the
	 * PDF creating script */
	if (isset($_POST['preview'])) {
		$FormDesign->asXML(sys_get_temp_dir() . '/' . $_POST['FormName']);
		switch ($_POST['FormName']) {
			case 'PurchaseOrder.xml':
				echo '<meta http-equiv="Refresh" content="0; url=' . $RootPath . '/PO_PDFPurchOrder.php?OrderNo=Preview">';
				break;
			case 'GoodsReceived.xml':
				echo '<meta http-equiv="Refresh" content="0; url=' . $RootPath . '/PDFGrn.php?GRNNo=Preview&PONo=1">';
				break;
			case 'PickingList.xml':
				echo '<meta http-equiv="Refresh" content="0; url=' . $RootPath . '/PDFPickingList.php?TransNo=Preview">';
				break;
			case 'QALabel.xml':
				echo '<meta http-equiv="Refresh" content="0; url=' . $RootPath . '/PDFQALabel.php?GRNNo=Preview&PONo=1">';
				break;
			case 'WOPaperwork.xml':
				echo '<meta http-equiv="Refresh" content="0; url=' . $RootPath . '/PDFWOPrint.php?WO=Preview">';
				break;
			case 'FGLabel.xml':
				echo '<meta http-equiv="Refresh" content="0; url=' . $RootPath . '/PDFFGLabel.php?WO=Preview">';
				break;
			case 'ShippingLabel.xml':
				echo '<meta http-equiv="Refresh" content="0; url=' . $RootPath . '/PDFShipLabel.php?ORD=Preview">';
				break;
		}
	} else {
		/* otherwise check that the web server has write premissions on the companies
		 * directory and save the xml file to the correct directory */
		if (is_writable($PathPrefix . 'companies/' . $_SESSION['DatabaseName'] . '/FormDesigns/' . $_POST['FormName'])) {
			$FormDesign->asXML($PathPrefix . 'companies/' . $_SESSION['DatabaseName'] . '/FormDesigns/' . $_POST['FormName']);
		} else {
			prnMsg(_('The web server does not have write permissions on the file ') . '<br />' . $PathPrefix . 'companies/' . $_SESSION['DatabaseName'] . '/FormDesigns/' . $_POST['FormName'] . '<br />' . _('Your changes cannot be saved') . '<br />' . _('See your system administrator to correct this problem'), 'error');
		}
	}
}
/* If no form has been selected to edit, then offer a
 * drop down list of possible forms */
if (empty($_POST['FormName'])) {
	echo '<p class="page_title_text" ><img src="' . $RootPath . '/css/' . $_SESSION['Theme'] . '/images/maintenance.png" title="' . _('Search') . '" alt="" />' . ' ' . $Title . '</p><br />';
	echo '<form method="post" id="ChooseForm" action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '">';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '<table><tr>';
	echo '<td>' . _('Select the form to edit') . '</td><td><select name="FormName">';
	/* Iterate throght the appropriate companies FormDesigns/ directory
	 * and extract the form name from each of the xml files found */
	if ($Handle = opendir($PathPrefix . 'companies/' . $_SESSION['DatabaseName'] . '/FormDesigns/')) {
		while (false !== ($File = readdir($Handle))) {
			if ($File[0] != '.') {
				$FormDesign = simplexml_load_file($PathPrefix . 'companies/' . $_SESSION['DatabaseName'] . '/FormDesigns/' . $File);
				echo '<option value="' . $File . '">' . _($FormDesign['name']->__toString()) . '</option>';
			}
		}
		closedir($Handle);
	}
	echo '</select></td></tr></table>';
	echo '<div class="centre"><input tabindex="6" type="submit" name="submit" value="' . _('Edit Form Layout') . '" /></div>';
	echo '</form>';
	include('includes/footer.inc');
	exit;
} // End of if (empty($_POST['FormName']))
/* If we are not previewing the form then load up the simplexml
 * object from the main xml file */
if (empty($_POST['preview'])) {
	$FormDesign = simplexml_load_file($PathPrefix . 'companies/' . $_SESSION['DatabaseName'] . '/FormDesigns/' . $_POST['FormName']);
}
echo '<p class="page_title_text" ><img src="' . $RootPath . '/css/' . $_SESSION['Theme'] . '/images/reports.png" title="' . _('Form Design') . '" alt="" />' . ' ' . _('Form Design') . '<br />' . $FormDesign['name']->__toString() . '</p>';
echo '<div class="page_help_text">' . _('Enter the changes that you want in the form layout below.') . '<br /> ' . _('All measurements are in PostScript points (72 points = 25,4 mm).') . '<br /> ' . _('All coordinates are measured from the lower left corner of the sheet to the top left corner of the field.') . '</div><br />';

$Papers = array(
	'A4_Landscape',
	'A4_Portrait',
	'A6_Landscape',
	'A5_Landscape',
	'A5_Portrait',
	'A3_Landscape',
	'A3_Portrait',
	'Letter_Portrait',
	'Letter_Landscape',
	'Legal_Portrait',
	'Legal_Landscape'
); // Possible paper sizes/orientations
echo '<form method="post" id="Form" action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '">';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
echo '<input name="FormName" type="hidden" value="' . $_POST['FormName'] . '" />';
echo '<table width="95%" border="1">'; //Start of outer table
echo '<tr>
		<th style="width:33%">' . _('Form Name') . '<input type="text" name="formname" value="' . $FormDesign['name'] . '" /></th>';
/* Select the paper size/orientation */
echo '<th style="width:33%">' . _('Paper Size') . '<select name="PaperSize">';
foreach ($Papers as $Paper) {
	if (mb_substr($Paper, -8) == 'Portrait') {
		$PaperValue = mb_substr($Paper, 0, mb_strlen($Paper) - 9);
	} else {
		$PaperValue = $Paper;
	}
	if ($PaperValue == $FormDesign->PaperSize) {
		echo '<option selected="selected" value="' . $PaperValue . '">' . $Paper . '</option>';
	} else {
		echo '<option value="' . $PaperValue . '">' . $Paper . '</option>';
	}
}
echo '</select></th>';
/* and the standard line height for the form */
echo '<th style="width:33%">' . _('Line Height') . '<input type="text" class="number" name="LineHeight" size="3" maxlength="3" value="' . $FormDesign->LineHeight . '" /></th></tr><tr>';
$Counter = 1; // Count how many sub tables are in the row
foreach ($FormDesign as $Key) {
	switch ($Key['type']) {
		case 'image':
			InputX($Key['id'], $Key->x);
			InputY($Key['id'], $Key->y);
			echo '<td colspan="1" valign="top">
					<table width="100%" border="1">
						<tr>
							<th colspan="4">' . _($Key['name']->__toString()) . '</th>
						</tr>
						<tr>';
			echo '</tr><tr>'; // New table row.
			echo '<td class="number">' . _('Width') . ' = ' . '</td><td><input type="text" class="number" name="' . $Key['id'] . 'width" size="4" maxlength="4" value="' . $Key->width . '" /></td>';
			// InputWidth($Key['id'], $Key->width);// Requires to standardize xml files from "width" to "Width"
			InputHeight($Key['id'], $Key->height); // Requires to standardize xml files from "height" to "Height"
			echo '</tr>
				</table>
			</td>';
			$Counter = $Counter + 1;
			break;
		case 'SimpleText':
			echo '<td colspan="1" valign="top">
					<table width="100%" border="1">
						<tr>
							<th colspan="6">' . _($Key['name']->__toString()) . '</th>
						</tr>
						<tr>';
			InputX($Key['id'], $Key->x);
			InputY($Key['id'], $Key->y);
			SelectFontSize($Key['id'], $Key->FontSize);
			echo '</tr>';
			echo '</table></td>';
			$Counter = $Counter + 1;
			break;
		case 'MultiLineText':
			echo '<td colspan="1" valign="top">
					<table width="100%" border="1">
						<tr>
							<th colspan="8">' . _($Key['name']->__toString()) . '</th>
						</tr>
					<tr>';
			InputX($Key['id'], $Key->x);
			InputY($Key['id'], $Key->y);
			InputWidth($Key['id'], $Key->Length);
			SelectFontSize($Key['id'], $Key->FontSize);
			echo '</tr>';
			echo '</table></td>';
			$Counter = $Counter + 1;
			break;
		case 'ElementArray':
			echo '<td colspan="1" valign="top">
					<table width="100%" border="1">
						<tr>
							<th colspan="7">' . _($Key['name']->__toString()) . '</th>
						</tr>' . "\n";
			foreach ($Key as $SubKey) {
				echo '<tr>';
				if ($SubKey['type'] == 'SimpleText') {
					echo '<td>' . _($SubKey['name']) . '</td>';
					InputX($SubKey['id'], $SubKey->x);
					InputY($SubKey['id'], $SubKey->y);
					SelectFontSize($SubKey['id'], $SubKey->FontSize);
				} elseif ($SubKey['type'] == 'MultiLineText') { // This element (9 td) overflows the table size (7 td).
					echo '<td>' . _($SubKey['name']) . '</td>';
					InputX($SubKey['id'], $SubKey->x);
					InputY($SubKey['id'], $SubKey->y);
					InputWidth($SubKey['id'], $SubKey->Length);
					SelectFontSize($SubKey['id'], $SubKey->FontSize);
				} else {
					if ($SubKey['type'] == 'DataText') {
						echo '<td>' . _($SubKey['name']) . '</td>';
						InputX($SubKey['id'], $SubKey->x);
						InputWidth($SubKey['id'], $SubKey->Length);
						SelectFontSize($SubKey['id'], $SubKey->FontSize);
					} elseif ($SubKey['type'] == 'StartLine') {
						echo '<td colspan="3">' . _($SubKey['name']) . ' = ' . '</td><td><input type="text" class="number" name="StartLine" size="4" maxlength="4" value="' . $Key->y . '" /></td>';
					}
				}
				echo '</tr>';
			}
			echo '</table></td>';
			$Counter = $Counter + 1;
			break;
		case 'CurvedRectangle':
			echo '<td colspan="1" valign="top">
					<table width="100%" border="1">
						<tr>
							<th colspan="6">' . _($Key['name']->__toString()) . '</th>
						</tr>
						<tr>';
			InputX($Key['id'], $Key->x);
			InputY($Key['id'], $Key->y);
			echo '<td class="number">' . _('Width') . ' = ' . '</td>
				<td><input type="text" class="number" name="' . $Key['id'] . 'width" size="4" maxlength="4" value="' . $Key->width . '" /></td>';
			//			InputWidth($Key['id'], $Key->width);// Requires to standardize xml files from "width" to "Width"
			echo '</tr><tr>'; // New table row.
			InputHeight($Key['id'], $Key->height); // Requires to standardize xml files from "height" to "Height"
			echo '<td class="number">' . _('Radius') . ' = ' . '</td>
					<td><input class="number" maxlength="4" name="' . $Key['id'] . 'radius" size="4" title="' . _('Radius of the rounded corners') . '" type="number" value="' . $Key->radius . '" /></td>'; // Requires to standardize xml files from "radius" to "Radius" before changing the html name.

			/* RCHACON: Attributes to add:
			+				Show: To turn on/off the use of this rectangle.
			+			echo '</tr><tr>'; // New table row.
			+				Corners: Numbers of the corners to be rounded: 1, 2, 3, 4 or any combination (1=top left, 2=top right, 3=bottom right, 4=bottom left).
			+				Style: (draw/fill): D (default), F, FD or DF.
			+				Fill: Filling color.
			+*/
			echo '</tr>
				</table>
			</td>';
			$Counter = $Counter + 1;
			break;
		case 'Rectangle': // This case is probably included in CurvedRectangle
			echo '<td colspan="1" valign="top">
					<table width="100%" border="1">
						<tr>
							<th colspan="8">' . _($Key['name']) . '</th>
						</tr>
						<tr>';
			InputX($Key['id'], $Key->x);
			InputY($Key['id'], $Key->y);
			echo '</tr><tr>'; // New table row.
			echo '<td class="number">' . _('Width') . ' = ' . '</td><td><input type="text" class="number" name="' . $Key['id'] . 'width" size="4" maxlength="4" value="' . $Key->width . '" /></td>';
			//			InputWidth($Key['id'], $Key->width);// Requires to standardize xml files from "width" to "Width"
			InputHeight($Key['id'], $Key->height); // Requires to standardize xml files from "height" to "Height"
			echo '</tr>
				</table>
			</td>';
			$Counter = $Counter + 1;
			break;
		case 'Line':
			echo '<td colspan="1" valign="top">
					<table width="100%" border="1">
						<tr>
							<th colspan="6">' . _($Key['name']->__toString()) . '</th>
						</tr>
						<tr>
							<td class="number">' . _('Start x co-ordinate') . ' = ' . '</td>
							<td><input type="text" class="number" name="' . $Key['id'] . 'startx" size="4" maxlength="4" value="' . $Key->startx . '" /></td>
							<td class="number">' . _('Start y co-ordinate') . ' = ' . '</td>
							<td><input type="text" class="number" name="' . $Key['id'] . 'starty" size="4" maxlength="4" value="' . $Key->starty . '" /></td>
						</tr>
						<tr>
							<td class="number">' . _('End x co-ordinate') . ' = ' . '</td>
							<td><input type="text" class="number" name="' . $Key['id'] . 'endx" size="4" maxlength="4" value="' . $Key->endx . '" /></td>
							<td class="number">' . _('End y co-ordinate') . ' = ' . '</td>
							<td><input type="text" class="number" name="' . $Key['id'] . 'endy" size="4" maxlength="4" value="' . $Key->endy . '" /></td>
						</tr>
					</table>
				</td>';
			$Counter = $Counter + 1;
			break;
	}
	if ($Counter == 4) { // If the row is full start a new one
		$Counter = 1;
		echo '</tr><tr>';
	}
}
echo '</tr></table>'; //End of outer table
echo '<div class="centre">
		<input tabindex="6" type="submit" name="preview" value="' . _('Preview the Form Layout') . '" />
		<input tabindex="7" type="submit" name="save" value="' . _('Save the Form Layout') . '" />
	</div>';
/*echo '<br /><div class="centre"><input tabindex="8" type="submit" name="return" value="' . _('Return') . '" /></div>';*/
echo '</form>';
/* END: PROCEDURE DIVISION. */

/* BEGIN: Final common code division. */
include('includes/footer.inc');
/* END: Final common code division. */
?>