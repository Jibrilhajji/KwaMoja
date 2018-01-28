<?php

/* Defines the various centres of work within a manufacturing company. Also the overhead and labour rates applicable to the work centre and its standard capacity */

include('includes/session.php');
$Title = _('Work Centres');
$ViewTopic = 'Manufacturing';
$BookMark = 'WorkCentres';
include('includes/header.php');

if (isset($_POST['SelectedWC'])) {
	$SelectedWC = $_POST['SelectedWC'];
} elseif (isset($_GET['SelectedWC'])) {
	$SelectedWC = $_GET['SelectedWC'];
}

if (isset($_POST['submit'])) {

	//initialise no input errors assumed initially before we test
	$InputError = 0;

	/* actions to take once the user has clicked the submit button
	ie the page has called itself with some user input */

	//first off validate inputs sensible

	if (mb_strlen($_POST['Code']) < 2) {
		$InputError = 1;
		prnMsg(_('The Work Centre code must be at least 2 characters long'), 'error');
	}
	if (mb_strlen($_POST['Description']) < 3) {
		$InputError = 1;
		prnMsg(_('The Work Centre description must be at least 3 characters long'), 'error');
	}
	if (mb_strstr($_POST['Code'], ' ') or ContainsIllegalCharacters($_POST['Code'])) {
		$InputError = 1;
		prnMsg(_('The work centre code cannot contain any of the following characters') . " - ' &amp; + \" \\ " . _('or a space'), 'error');
	}

	if (isset($SelectedWC) and $InputError != 1) {

		/*SelectedWC could also exist if submit had not been clicked this code
		would not run in this case cos submit is false of course  see the
		delete code below*/

		$SQL = "UPDATE workcentres SET location = '" . $_POST['Location'] . "',
						description = '" . $_POST['Description'] . "',
						overheadrecoveryact ='" . $_POST['OverheadRecoveryAct'] . "',
						overheadperhour = '" . $_POST['OverheadPerHour'] . "'
				WHERE code = '" . $SelectedWC . "'";
		$Msg = _('The work centre record has been updated');
	} elseif ($InputError != 1) {

		/*Selected work centre is null cos no item selected on first time round so must be adding a	record must be submitting new entries in the new work centre form */

		$SQL = "INSERT INTO workcentres (code,
										location,
										description,
										overheadrecoveryact,
										overheadperhour)
					VALUES ('" . $_POST['Code'] . "',
						'" . $_POST['Location'] . "',
						'" . $_POST['Description'] . "',
						'" . $_POST['OverheadRecoveryAct'] . "',
						'" . $_POST['OverheadPerHour'] . "'
						)";
		$Msg = _('The new work centre has been added to the database');
	}
	//run the SQL from either of the above possibilites

	if ($InputError != 1) {
		$Result = DB_query($SQL, _('The update/addition of the work centre failed because'));
		prnMsg($Msg, 'success');
		unset($_POST['Location']);
		unset($_POST['Description']);
		unset($_POST['Code']);
		unset($_POST['OverheadRecoveryAct']);
		unset($_POST['OverheadPerHour']);
		unset($SelectedWC);
	}

} elseif (isset($_GET['delete'])) {
	//the link to delete a selected record was clicked instead of the submit button

	// PREVENT DELETES IF DEPENDENT RECORDS IN 'BOM'

	$SQL = "SELECT COUNT(*) FROM bom WHERE bom.workcentreadded='" . $SelectedWC . "'";
	$Result = DB_query($SQL);
	$MyRow = DB_fetch_row($Result);
	if ($MyRow[0] > 0) {
		prnMsg(_('Cannot delete this work centre because bills of material have been created requiring components to be added at this work center') . '<br />' . _('There are') . ' ' . $MyRow[0] . ' ' . _('BOM items referring to this work centre code'), 'warn');
	} else {
		$SQL = "SELECT COUNT(*) FROM contractbom WHERE contractbom.workcentreadded='" . $SelectedWC . "'";
		$Result = DB_query($SQL);
		$MyRow = DB_fetch_row($Result);
		if ($MyRow[0] > 0) {
			prnMsg(_('Cannot delete this work centre because contract bills of material have been created having components added at this work center') . '<br />' . _('There are') . ' ' . $MyRow[0] . ' ' . _('Contract BOM items referring to this work centre code'), 'warn');
		} else {
			$SQL = "DELETE FROM workcentres WHERE code='" . $SelectedWC . "'";
			$Result = DB_query($SQL);
			prnMsg(_('The selected work centre record has been deleted'), 'succes');
		} // end of Contract BOM test
	} // end of BOM test
	unset($SelectedWC);
}

if (!isset($SelectedWC)) {

	/* It could still be the second time the page has been run and a record has been selected for modification - SelectedWC will exist because it was sent with the new call. If its the first time the page has been displayed with no parameters
	then none of the above are true and the list of work centres will be displayed with
	links to delete or edit each. These will call the same page again and allow update/input
	or deletion of the records*/
	echo '<p class="page_title_text" >
			<img src="' . $RootPath . '/css/' . $_SESSION['Theme'] . '/images/maintenance.png" title="' . _('Search') . '" alt="" />' . ' ' . $Title . '
		</p>';

	$SQL = "SELECT workcentres.code,
					workcentres.description,
					locations.locationname,
					workcentres.overheadrecoveryact,
					chartmaster.accountname,
					workcentres.overheadperhour
				FROM workcentres
				INNER JOIN locations
					ON workcentres.location = locations.loccode
				INNER JOIN chartmaster
					ON workcentres.overheadrecoveryact=chartmaster.accountcode
				INNER JOIN locationusers
					ON locationusers.loccode=locations.loccode
					AND locationusers.userid='" .  $_SESSION['UserID'] . "'
					AND locationusers.canview=1
				WHERE chartmaster.language='" . $_SESSION['ChartLanguage'] . "'";
	$Result = DB_query($SQL);
	echo '<table>
			<thead>
				<tr>
					<th class="SortedColumn">', _('WC Code'), '</th>
					<th class="SortedColumn">', _('Description'), '</th>
					<th class="SortedColumn">', _('Location'), '</th>
					<th>', _('Overhead GL Account'), '</th>
					<th>', _('Overhead Per Hour'), '</th>
				</tr>
			</thead>';
	echo '<tbody>';
	while ($MyRow = DB_fetch_array($Result)) {

		printf('<tr>
					<td>%s</td>
					<td>%s</td>
					<td>%s</td>
					<td>%s</td>
					<td class="number">%s</td>
					<td><a href="%s&amp;SelectedWC=%s">' . _('Edit') . '</a></td>
					<td><a href="%s&amp;SelectedWC=%s&amp;delete=yes" onclick="return MakeConfirm(\'' . _('Are you sure you wish to delete this work centre?') . '\', \'Confirm Delete\', this);">' . _('Delete') . '</a></td>
				</tr>', $MyRow['code'], $MyRow['description'], $MyRow['locationname'], $MyRow['overheadrecoveryact'] . ' - ' . $MyRow['accountname'], $MyRow['overheadperhour'], htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '?', $MyRow['code'], htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '?', $MyRow['code']);
	}
	echo '</tbody>';
	//END WHILE LIST LOOP
	echo '</table>';
}

//end of ifs and buts!

if (isset($SelectedWC)) {
	echo '<p class="page_title_text" ><img src="' . $RootPath . '/css/' . $_SESSION['Theme'] . '/images/maintenance.png" title="' . _('Search') . '" alt="" />' . ' ' . $Title . '</p>';
	echo '<div class="centre"><a href="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '">' . _('Show all Work Centres') . '</a></div>';
}

echo '<form method="post" action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '">';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';

if (isset($SelectedWC)) {
	//editing an existing work centre

	$SQL = "SELECT code,
					location,
					description,
					overheadrecoveryact,
					overheadperhour
			FROM workcentres
			INNER JOIN locationusers
				ON locationusers.loccode=workcentres.location
				AND locationusers.userid='" .  $_SESSION['UserID'] . "'
				AND locationusers.canupd=1
			WHERE code='" . $SelectedWC . "'";

	$Result = DB_query($SQL);
	$MyRow = DB_fetch_array($Result);

	$_POST['Code'] = $MyRow['code'];
	$_POST['Location'] = $MyRow['location'];
	$_POST['Description'] = $MyRow['description'];
	$_POST['OverheadRecoveryAct'] = $MyRow['overheadrecoveryact'];
	$_POST['OverheadPerHour'] = $MyRow['overheadperhour'];

	echo '<input type="hidden" name="SelectedWC" value="' . $SelectedWC . '" />
		<input type="hidden" name="Code" value="' . $_POST['Code'] . '" />
		<table>
			<tr>
				<td>' . _('Work Centre Code') . ':</td>
				<td>' . $_POST['Code'] . '</td>
			</tr>';

} else { //end of if $SelectedWC only do the else when a new record is being entered
	if (!isset($_POST['Code'])) {
		$_POST['Code'] = '';
	}
	echo '<table>
			<tr>
				<td>' . _('Work Centre Code') . ':</td>
				<td><input type="text" class="AlphaNumeric" name="Code" size="6" autofocus="autofocus" required="required" maxlength="5" value="' . $_POST['Code'] . '" /></td>
			</tr>';
}

$SQL = "SELECT locationname,
				locations.loccode
			FROM locations
			INNER JOIN locationusers
				ON locationusers.loccode=locations.loccode
				AND locationusers.userid='" .  $_SESSION['UserID'] . "'
				AND locationusers.canupd=1";
$Result = DB_query($SQL);

if (!isset($_POST['Description'])) {
	$_POST['Description'] = '';
}
echo '<tr>
		<td>' . _('Work Centre Description') . ':</td>
		<td><input type="text" name="Description" size="21" required="required" maxlength="20" value="' . $_POST['Description'] . '" /></td>
	</tr>
	<tr><td>' . _('Location') . ':</td>
		<td><select required="required" name="Location">';

while ($MyRow = DB_fetch_array($Result)) {
	if (isset($_POST['Location']) and $MyRow['loccode'] == $_POST['Location']) {
		echo '<option selected="selected" value="';
	} else {
		echo '<option value="';
	}
	echo $MyRow['loccode'] . '">' . $MyRow['locationname'] . '</option>';

} //end while loop

DB_free_result($Result);


echo '</select></td>
	</tr>
	<tr>
		<td>' . _('Overhead Recovery GL Account') . ':</td>
		<td><select required="required" name="OverheadRecoveryAct">';

//SQL to poulate account selection boxes
$SQL = "SELECT accountcode,
				accountname
		FROM chartmaster
		INNER JOIN accountgroups
			ON chartmaster.groupcode=accountgroups.groupcode
			AND chartmaster.language=accountgroups.language
		WHERE accountgroups.pandl=1
			AND chartmaster.language='" . $_SESSION['ChartLanguage'] . "'
		ORDER BY accountcode";

$Result = DB_query($SQL);

while ($MyRow = DB_fetch_array($Result)) {
	if (isset($_POST['OverheadRecoveryAct']) and $MyRow['accountcode'] == $_POST['OverheadRecoveryAct']) {
		echo '<option selected="selected" value="' . $MyRow['accountcode'] . '">' . htmlspecialchars($MyRow['accountcode'] . ' - ' . $MyRow['accountname'], ENT_QUOTES, 'UTF-8', false) . '</option>';
	} else {
		echo '<option value="' . $MyRow['accountcode'] . '">' . htmlspecialchars($MyRow['accountcode'] . ' - ' . $MyRow['accountname'], ENT_QUOTES, 'UTF-8', false) . '</option>';
	}
} //end while loop
DB_free_result($Result);

if (!isset($_POST['OverheadPerHour'])) {
	$_POST['OverheadPerHour'] = 0;
}

echo '</select></td></tr>';
echo '<tr>
		<td>' . _('Overhead Per Hour') . ':</td>
		<td><input type="text" class="number" name="OverheadPerHour" size="6" required="required" maxlength="6" value="' . $_POST['OverheadPerHour'] . '" />';

echo '</td>
	</tr>
	</table>';

echo '<div class="centre">
		<input type="submit" name="submit" value="' . _('Enter Information') . '" />
	</div>';

echo '</form>';
include('includes/footer.php');
?>