<?php

/*Script to change a supplier code wherever it appears*/

include('includes/session.php');
$Title = _('UTILITY PAGE To Changes A Supplier Code In All Tables');// Screen identificator.
$ViewTopic = 'SpecialUtilities'; // Filename's id in ManualContents.php's TOC.
$BookMark = 'Z_ChangeSupplierCode'; // Anchor's id in the manual's html document
include('includes/header.php');
echo '<p class="page_title_text">
		<img alt="" src="' . $RootPath . '/css/' . $_SESSION['Theme'] . '/images/supplier.png" title="' . _('Change A Supplier Code') . '" /> ' . _('Change A Supplier Code') . '
	</p>';// Page title.

if (isset($_POST['ProcessSupplierChange'])) {
	ProcessSupplier($_POST['OldSupplierNo'], $_POST['NewSupplierNo']);
}

echo '<form action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '" method="post">';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';

echo '<table>
		<tr>
			<td>' . _('Existing Supplier Code') . ':</td>
			<td><input type="text" name="OldSupplierNo" size="20" maxlength="20" /></td>
		</tr>
		<tr>
			<td> ' . _('New Supplier Code') . ':</td>
			<td><input type="text" name="NewSupplierNo" size="20" maxlength="20" /></td>
		</tr>
	</table>
	<div class="centre">
		<input type="submit" name="ProcessSupplierChange" value="' . _('Process') . '" />
	<div>
</form>';

include('includes/footer.php');
exit();


function ProcessSupplier($oldCode, $newCode) {
	$TableKey = array(
		'grns' => 'supplierid',
		'offers' => 'supplierid',
		'purchdata' => 'supplierno',
		'purchorders' => 'supplierno',
		'shipments' => 'supplierid',
		'suppliercontacts' => 'supplierid',
		'supptrans' => 'supplierno',
		'www_users' => 'supplierid'
	);

	// First check the Supplier code exists
	if (!checkSupplierExist($oldCode)) {
		prnMsg('<br /><br />' . _('The Supplier code') . ': ' . $oldCode . ' ' . _('does not currently exist as a supplier code in the system'), 'error');
		return;
	}
	$newCode = trim($newCode);
	if (checkNewCode($newCode)) {
		// Now check that the new code doesn't already exist
		if (checkSupplierExist($newCode)) {
			prnMsg(_('The replacement supplier code') . ': ' . $newCode . ' ' . _('already exists as a supplier code in the system') . ' - ' . _('a unique supplier code must be entered for the new code'), 'error');
			return;
		}
	} else {
		return;
	}

	$Result = DB_Txn_Begin();

	prnMsg(_('Inserting the new supplier record'), 'info');
	$SQL = "INSERT INTO suppliers (`supplierid`,
		`suppname`,  `address1`, `address2`, `address3`,
		`address4`,  `address5`,  `address6`, `supptype`, `lat`, `lng`,
		`currcode`,  `suppliersince`, `paymentterms`, `lastpaid`,
		`lastpaiddate`, `bankact`, `bankref`, `bankpartics`,
		`remittance`, `taxgroupid`, `factorcompanyid`, `taxref`,
		`phn`, `port`, `email`, `fax`, `telephone`)
	SELECT '" . $newCode . "',
		`suppname`,  `address1`, `address2`, `address3`,
		`address4`,  `address5`,  `address6`, `supptype`, `lat`, `lng`,
		`currcode`,  `suppliersince`, `paymentterms`, `lastpaid`,
		`lastpaiddate`, `bankact`, `bankref`, `bankpartics`,
		`remittance`, `taxgroupid`, `factorcompanyid`, `taxref`,
		`phn`, `port`, `email`, `fax`, `telephone`
		FROM suppliers WHERE supplierid='" . $oldCode . "'";

	$DbgMsg = _('The SQL that failed was');
	$ErrMsg = _('The SQL to insert the new suppliers master record failed') . ', ' . _('the SQL statement was');
	$Result = DB_query($SQL, $ErrMsg, $DbgMsg, true);

	foreach ($TableKey as $Table => $Key) {
		prnMsg(_('Changing') . ' ' . $Table . ' ' . _('records'), 'info');
		$SQL = "UPDATE " . $Table . " SET $Key='" . $newCode . "' WHERE $Key='" . $oldCode . "'";
		$ErrMsg = _('The SQL to update') . ' ' . $Table . ' ' . _('records failed');
		$Result = DB_query($SQL, $ErrMsg, $DbgMsg, true);
	}

	prnMsg(_('Deleting the supplier code from the suppliers master table'), 'info');
	$SQL = "DELETE FROM suppliers WHERE supplierid='" . $oldCode . "'";

	$ErrMsg = _('The SQL to delete the old supplier record failed');
	$Result = DB_query($SQL, $ErrMsg, $DbgMsg, true);

	$Result = DB_Txn_Commit();
}

function checkSupplierExist($codeSupplier) {
	$Result = DB_query("SELECT supplierid FROM suppliers WHERE supplierid='" . $codeSupplier . "'");
	if (DB_num_rows($Result) == 0) {
		return false;
	}
	return true;
}

function checkNewCode($code) {
	$tmp = str_replace(' ', '', $code);
	if ($tmp != $code) {
		prnMsg('<br /><br />' . _('The New supplier code') . ': ' . $code . ' ' . _('must be not empty nor with spaces'), 'error');
		return false;
	}
	return true;
}
?>