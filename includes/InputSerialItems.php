<?php

/* Input Serial Items - used for inputing serial numbers or batch/roll/bundle
 * referencesfor controlled items - used in:
 * - ConfirmDispatchControlledInvoice.php
 * - GoodsReceivedControlled.php
 * - StockAdjustments.php
 * - StockTransfers.php
 * - CreditItemsControlled.php
 */

//bring up perishable variable here otherwise we cannot get it in Add_SerialItems.php
$SQL = "SELECT perishable,
				decimalplaces
			FROM stockmaster
			WHERE stockid='" . $StockId . "'";
$Result = DB_query($SQL);
$MyRow = DB_fetch_array($Result);
$Perishable = $MyRow['perishable'];
$DecimalPlaces = $MyRow['decimalplaces'];

include('includes/Add_SerialItems.php');

/*Setup the Data Entry Types */
if (isset($_GET['LineNo'])) {
	$LineNo = $_GET['LineNo'];
} elseif (isset($_POST['LineNo'])) {
	$LineNo = $_POST['LineNo'];
} else {
	$LineNo = 0;
}
/*
Entry Types:
Keyed Mode: 'Qty' Rows of Input Fields. Upto X shown per page (100 max)
Barcode Mode: Part Keyed, part not. 1st, 'Qty' of barcodes entered. Then extra data as/if
necessary
FileUpload Mode: File Uploaded must fulfill item requirements when parsed... no form based data
entry. 1-upload, 2-parse&validate, 3-bad>1 good>4, 4-import.
switch the type we are updating from, w/ some rules...
Qty < X   - Default to keyed
X < Qty < Y - Default to barcode
Y < Qty - Default to upload

possibly override setting elsewhere.
*/
if (!isset($RecvQty)) {
	$RecvQty = 0;
}
if (!isset($_POST['EntryType']) or trim($_POST['EntryType']) == '') {
	if ($RecvQty <= 50) {
		$_POST['EntryType'] = 'KEYED';
	} //elseif ($RecvQty <= 50) { $EntryType = "BARCODE"; }
	else {
		$_POST['EntryType'] = 'FILE';
	}
}

$invalid_imports = 0;
$valid = true;

echo '<form method="post" class="noPrint" action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '?identifier=' . $Identifier . '" enctype="multipart/form-data" >';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />
		<input type="hidden" name="LineNo" value="' . $LineNo . '" />
		<input type="hidden" name="StockID" value="' . $StockId . '" />';

if (isset($_GET['CreditInvoice']) or isset($_POST['CreditInvoice'])) {
	$CreditInvoice = '&amp;CreditInvoice=Yes';
	echo '<input type="hidden" name="CreditInvoice" value="Yes" />';
} else {
	$CreditInvoice = '';
}

echo '<table class="selection">
		<tr>
			<td><input type="radio" name="EntryType" onclick="submit();" ';
if ($_POST['EntryType'] == 'KEYED') {
	echo ' checked="checked" ';
}
echo 'value="KEYED" />' . _('Keyed Entry') . '</td>';

if ($LineItem->Serialised == 1) {
	echo '<td><input type="radio" name="EntryType" onclick="submit();" ';
	if ($_POST['EntryType'] == 'SEQUENCE') {
		echo ' checked="checked" ';
	}
	echo ' value="SEQUENCE" />' . _('Sequential') . '</td>';
}

echo '<td valign="bottom"><input type="radio" id="FileEntry" name="EntryType" onclick="submit();" ';

if ($_POST['EntryType'] == 'FILE') {
	echo ' checked="checked" ';
}
echo ' value="FILE" />' . _('File Upload') . '&nbsp; <input type="file" name="ImportFile" onclick="document.getElementById(\'FileEntry\').checked=true;" /></td>
	</tr>
	<tr>
		<td colspan="3">
		<div class="centre">
			<input type="submit" value="' . _('Set Entry Type') . ':" />
		</div>
		</td>
	</tr>
	</table>
	</form>';

global $TableHeader;
/* Link to clear the list and start from scratch */
$EditLink = '<div class="centre">
				<a class="FontSize" href="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '?identifier=' . $Identifier . '&amp;EditControlled=true&amp;StockID=' . $LineItem->StockID . '&amp;LineNo=' . $LineNo . $CreditInvoice . '">' . _('Edit') . '</a> | ';
$RemoveLink = '<a class="FontSize" href="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '?identifier=' . $Identifier . '&amp;DELETEALL=YES&amp;StockID=' . $LineItem->StockID . '&amp;LineNo=' . $LineNo . $CreditInvoice . '">' . _('Remove All') . '</a>
			</div>';

if ($LineItem->Serialised == 1) {
	if ($Perishable == 0) {
		$TableHeader .= '<tr>
							<th>' . _('Serial No') . '</th>
						</tr>';
	} else {
		$TableHeader .= '<tr>
							<th>' . _('Serial No') . '</th>
							<th>' . _('Expiry Date') . '<th>
						</tr>';
	}
} else if ($LineItem->Serialised == 0 and $Perishable == 1) {
	$TableHeader = '<tr>
						<th>' . _('Batch/Roll/Bundle') . ' #</th>
						<th>' . _('Quantity') . '</th>
						<th>' . _('Expiry Date') . '</th>
					</tr>';
} else {
	$TableHeader = '<tr>
						<th>' . _('Batch/Roll/Bundle') . ' #</th>
						<th>' . _('Quantity') . '</th>
					</tr>';
}

echo $EditLink . $RemoveLink;
if ($_POST['EntryType'] == 'FILE') {
	include('includes/InputSerialItemsFile.php');
} elseif ($_POST['EntryType'] == 'SEQUENCE') {
	include('includes/InputSerialItemsSequential.php');
} else {
	/*KEYED or BARCODE */
	include('includes/InputSerialItemsKeyed.php');
}
?>