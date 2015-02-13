<?php

/* $Id$ */

include ('includes/session.inc');
$Title = _('UTILITY PAGE Change A Stock Category');// Screen identificator.
$ViewTopic = 'SpecialUtilities'; // Filename's id in ManualContents.php's TOC.
$BookMark = 'Z_ChangeStockCategory'; // Anchor's id in the manual's html document
include ('includes/header.inc');

echo '<p class="page_title_text">
		<img alt="" src="' . $RootPath . '/css/' . $Theme . '/images/inventory.png" title="' . _('Change A Stock Category Code') . '" /> ' . _('Change A Stock Category Code') . '
	</p>';// Page title.

include ('includes/SQL_CommonFunctions.inc');

if (isset($_POST['ProcessStockChange'])) {
	$_POST['NewStockCategory'] = mb_strtoupper($_POST['NewStockCategory']);

	/*First check the stock code exists */
	$Result = DB_query("SELECT categoryid FROM stockcategory WHERE categoryid='" . $_POST['OldStockCategory'] . "'");

	if (DB_num_rows($Result) == 0) {
		prnMsg(_('The stock Category') . ': ' . $_POST['OldStockCategory'] . ' ' . _('does not currently exist as a stock category in the system'), 'error');
		include ('includes/footer.inc');
		exit;
	}

	if (ContainsIllegalCharacters($_POST['NewStockCategory'])) {
		prnMsg(_('The new stock category to change the old code to contains illegal characters - no changes will be made'), 'error');
		include ('includes/footer.inc');
		exit;
	}

	if ($_POST['NewStockCategory'] == '') {
		prnMsg(_('The new stock category to change the old code to must be entered as well'), 'error');
		include ('includes/footer.inc');
		exit;
	}

	/*Now check that the new code doesn't already exist */
	$Result = DB_query("SELECT categoryid FROM stockcategory WHERE categoryid='" . $_POST['NewStockCategory'] . "'");

	if (DB_num_rows($Result) != 0) {
		echo '<br /><br />';
		prnMsg(_('The replacement stock category') . ': ' . $_POST['NewStockCategory'] . ' ' . _('already exists as a stock category in the system') . ' - ' . _('a unique stock category must be entered for the new stock category'), 'error');
		include ('includes/footer.inc');
		exit;
	}
	$Result = DB_Txn_Begin();
	echo '<br />' . _('Adding the new stock Category record');
	$SQL = "INSERT INTO stockcategory (categoryid,
						categorydescription,
						defaulttaxcatid,
						stocktype,
						stockact,
						adjglact,
						issueglact,
						purchpricevaract,
						materialuseagevarac,
						wipact)
					SELECT '" . $_POST['NewStockCategory'] . "',
							categorydescription,
							defaulttaxcatid,
							stocktype,
							stockact,
							adjglact,
							issueglact,
							purchpricevaract,
							materialuseagevarac,
							wipact
						FROM stockcategory
						WHERE categoryid='" . $_POST['OldStockCategory'] . "'";
	$DbgMsg = _('The SQL statement that failed was');
	$ErrMsg = _('The SQL to insert the new stock category record failed');
	$Result = DB_query($SQL, $ErrMsg, $DbgMsg, true);
	echo ' ... ' . _('completed');
	echo '<br />' . _('Changing stock properties');
	$SQL = "UPDATE stockcatproperties SET categoryid='" . $_POST['NewStockCategory'] . "' WHERE categoryid='" . $_POST['OldStockCategory'] . "'";
	$ErrMsg = _('The SQL to update stock properties records failed');
	$Result = DB_query($SQL, $ErrMsg, $DbgMsg, true);
	echo ' ... ' . _('completed');
	echo '<br />' . _('Changing stock master records');
	$SQL = "UPDATE stockmaster SET categoryid='" . $_POST['NewStockCategory'] . "' WHERE categoryid='" . $_POST['OldStockCategory'] . "'";
	$ErrMsg = _('The SQL to update stock master transaction records failed');
	$Result = DB_query($SQL, $ErrMsg, $DbgMsg, true);
	echo ' ... ' . _('completed');
	echo '<br />' . _('Changing sales analysis records');
	$SQL = "UPDATE salesanalysis SET stkcategory='" . $_POST['NewStockCategory'] . "' WHERE stkcategory='" . $_POST['OldStockCategory'] . "'";
	$ErrMsg = _('The SQL to update Sales Analysis records failed');
	$Result = DB_query($SQL, $ErrMsg, $DbgMsg, true);
	echo ' ... ' . _('completed');

	echo '<br />' . _('Changing internal stock category roles records');
	$SQL = "UPDATE internalstockcatrole SET categoryid='" . $_POST['NewStockCategory'] . "' WHERE categoryid='" . $_POST['OldStockCategory'] . "'";
	$ErrMsg = _('The SQL to update internal stock category role records failed');
	$Result = DB_query($SQL, $ErrMsg, $DbgMsg);
	echo ' ... ' . _('completed');

	$SQL = 'SET FOREIGN_KEY_CHECKS=1';
	$Result = DB_query($SQL, $ErrMsg, $DbgMsg, true);
	$Result = DB_Txn_Commit();
	echo '<br />' . _('Deleting the old stock category record');
	$SQL = "DELETE FROM stockcategory WHERE categoryid='" . $_POST['OldStockCategory'] . "'";
	$ErrMsg = _('The SQL to delete the old stock category record failed');
	$Result = DB_query($SQL, $ErrMsg, $DbgMsg, true);
	echo ' ... ' . _('completed');
	echo '<p>' . _('Stock Category') . ': ' . $_POST['OldStockCategory'] . ' ' . _('was successfully changed to') . ' : ' . $_POST['NewStockCategory'];
}

echo '<form onSubmit="return VerifyForm(this);" action="' . htmlspecialchars($_SERVER['PHP_SELF'],ENT_QUOTES,'UTF-8') . '" method="post" class="noPrint">';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
echo '<table>
		<tr>
			<td>' . _('Existing Inventory Category Code') . ':</td>
			<td><input type="text" name="OldStockCategory" size="7" maxlength="6" /></td>
		</tr>
		<tr>
			<td>' . _('New Inventory Category Code') . ':</td>
			<td><input type="text" name="NewStockCategory" size="7" maxlength="6" /></td>
		</tr>
	</table>
	<div class="centre">
		<input type="submit" name="ProcessStockChange" value="' . _('Process') . '" />
	</div>
	</form>';
include ('includes/footer.inc');
?>