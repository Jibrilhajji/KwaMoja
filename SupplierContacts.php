<?php

include('includes/session.php');

$Title = _('Supplier Contacts');
/* Manual links before header.php */
$ViewTopic = 'AccountsPayable';
$BookMark = 'SupplierContact';
include('includes/header.php');

if (isset($_GET['SupplierID'])) {
	$SupplierID = stripslashes($_GET['SupplierID']);
} elseif (isset($_POST['SupplierID'])) {
	$SupplierID = stripslashes($_POST['SupplierID']);
}

echo '<div class="toplink">
		<a href="' . $RootPath . '/SelectSupplier.php">' . _('Back to Suppliers') . '</a>
	</div>';

echo '<p class="page_title_text" ><img src="' . $RootPath . '/css/' . $_SESSION['Theme'] . '/images/transactions.png" title="' . _('Supplier Allocations') . '" alt="" />' . ' ' . $Title . '</p>';

if (!isset($SupplierID)) {
	echo '<p /><p />';
	prnMsg(_('This page must be called with the supplier code of the supplier for whom you wish to edit the contacts') . '<br />' . _('When the page is called from within the system this will always be the case') . '<br />' . _('Select a supplier first, then select the link to add/edit/delete contacts'), 'info');
	include('includes/footer.php');
	exit;
}

if (isset($_GET['SelectedContact'])) {
	$SelectedContact = $_GET['SelectedContact'];
} elseif (isset($_POST['SelectedContact'])) {
	$SelectedContact = $_POST['SelectedContact'];
}


if (isset($_POST['submit'])) {

	//initialise no input errors assumed initially before we test
	$InputError = 0;

	/* actions to take once the user has clicked the submit button
	ie the page has called itself with some user input */

	//first off validate inputs sensible

	if (mb_strlen($_POST['Contact']) == 0) {
		$InputError = 1;
		prnMsg(_('The contact name must be at least one character long'), 'error');
		echo '<br />';
	}
	if (mb_strlen($_POST['Email'])) {
		if (!IsEmailAddress($_POST['Email'])) {
			$InputError = 1;
			prnMsg(_('The email address entered does not appear to be a valid email address'), 'error');
			echo '<br />';
		}
	}
	if (isset($SelectedContact) and $InputError != 1) {

		/*SelectedContact could also exist if submit had not been clicked this code would not run in this case 'cos submit is false of course see the delete code below*/

		$SQL = "UPDATE suppliercontacts SET position='" . $_POST['Position'] . "',
											tel='" . $_POST['Tel'] . "',
											fax='" . $_POST['Fax'] . "',
											email='" . $_POST['Email'] . "',
											mobile = '" . $_POST['Mobile'] . "'
				WHERE contact='" . $SelectedContact . "'
				AND supplierid='" . DB_escape_string($SupplierID) . "'";

		$Msg = _('The supplier contact information has been updated');

	} elseif ($InputError != 1) {

		/*Selected contact is null cos no item selected on first time round so must be adding a	record must be submitting new entries in the new supplier  contacts form */

		$SQL = "INSERT INTO suppliercontacts (supplierid,
											contact,
											position,
											tel,
											fax,
											email,
											mobile)
				VALUES ('" . DB_escape_string($SupplierID) . "',
					'" . $_POST['Contact'] . "',
					'" . $_POST['Position'] . "',
					'" . $_POST['Tel'] . "',
					'" . $_POST['Fax'] . "',
					'" . $_POST['Email'] . "',
					'" . $_POST['Mobile'] . "')";
		$Msg = _('The new supplier contact has been added to the database');
	}
	//run the SQL from either of the above possibilites
	if ($InputError != 1) {
		$ErrMsg = _('The supplier contact could not be inserted or updated because');
		$DbgMsg = _('The SQL that was used but failed was');

		$Result = DB_query($SQL, $ErrMsg, $DbgMsg);

		prnMsg($Msg, 'success');

		unset($SelectedContact);
		unset($_POST['Contact']);
		unset($_POST['Position']);
		unset($_POST['Tel']);
		unset($_POST['Fax']);
		unset($_POST['Email']);
		unset($_POST['Mobile']);
	}
} elseif (isset($_GET['delete'])) {

	$SQL = "DELETE FROM suppliercontacts
			WHERE contact='" . $SelectedContact . "'
			AND supplierid = '" . $SupplierID . "'";

	$ErrMsg = _('The supplier contact could not be deleted because');
	$DbgMsg = _('The SQL that was used but failed was');

	$Result = DB_query($SQL, $ErrMsg, $DbgMsg);

	echo '<br />' . _('Supplier contact has been deleted') . '<p />';

}


if (!isset($SelectedContact)) {
	$SQL = "SELECT suppliers.suppname,
					contact,
					position,
					tel,
					suppliercontacts.fax,
					suppliercontacts.email
				FROM suppliercontacts,
					suppliers
				WHERE suppliercontacts.supplierid=suppliers.supplierid
				AND suppliercontacts.supplierid = '" . DB_escape_string($SupplierID) . "'";

	$Result = DB_query($SQL);

	if (DB_num_rows($Result) > 0) {

		$MyRow = DB_fetch_array($Result);

		echo '<table class="selection">
				<thead>
					<tr>
						<th colspan="7"><h3>' . _('Contacts Defined for') . ' - ' . $MyRow['suppname'] . '</h3></th>
					</tr>
					<tr>
						<th class="SortedColumn">' . _('Name') . '</th>
						<th class="SortedColumn">' . _('Position') . '</th>
						<th>' . _('Phone No') . '</th>
						<th>' . _('Fax No') . '</th>
						<th>' . _('Email') . '</th>
					</tr>
				</thead>';
		echo '<tbody>';
		do {
			printf('<tr><td>%s</td>
					<td>%s</td>
					<td>%s</td>
					<td>%s</td>
					<td><a href="mailto:%s">%s</a></td>
					<td><a href="%s&amp;SupplierID=%s&amp;SelectedContact=%s">' . _('Edit') . '</a></td>
					<td><a href="%s&amp;SupplierID=%s&amp;SelectedContact=%s&amp;delete=yes" onclick="return MakeConfirm(\'' . _('Are you sure you wish to delete this contact?') . '\', \'Confirm Delete\', this);">' . _('Delete') . '</a></td></tr>', $MyRow['contact'], $MyRow['position'], $MyRow['tel'], $MyRow['fax'], $MyRow['email'], $MyRow['email'], htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '?', urlencode($SupplierID), $MyRow['contact'], htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '?', urlencode($SupplierID), $MyRow['contact']);
		} while ($MyRow = DB_fetch_array($Result));
		echo '</tbody>
			</table>';
	} else {
		prnMsg(_('There are no contacts defined for this supplier'), 'info');
	}
	//END WHILE LIST LOOP
}

//end of ifs and buts!


if (isset($SelectedContact)) {
	echo '<div class="centre">
			<a href="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '?SupplierID=' . $SupplierID . '">' . _('Show all the supplier contacts for') . ' ' . $SupplierID . '</a>
		 </div>';
}

if (!isset($_GET['delete'])) {

	echo '<form method="post" action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '">';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';

	if (isset($SelectedContact)) {
		//editing an existing contact

		$SQL = "SELECT contact,
						position,
						tel,
						fax,
						mobile,
						email
					FROM suppliercontacts
					WHERE contact='" . $SelectedContact . "'
					AND supplierid='" . DB_escape_string($SupplierID) . "'";

		$Result = DB_query($SQL);
		$MyRow = DB_fetch_array($Result);

		$_POST['Contact'] = $MyRow['contact'];
		$_POST['Position'] = $MyRow['position'];
		$_POST['Tel'] = $MyRow['tel'];
		$_POST['Fax'] = $MyRow['fax'];
		$_POST['Email'] = $MyRow['email'];
		$_POST['Mobile'] = $MyRow['mobile'];
		echo '<input type="hidden" name="SelectedContact" value="' . $_POST['Contact'] . '" />';
		echo '<input type="hidden" name="Contact" value="' . $_POST['Contact'] . '" />';
		echo '<table>
				<tr>
					<td>' . _('Contact') . ':</td>
					<td>' . $_POST['Contact'] . '</td>
				</tr>';

	} else { //end of if $SelectedContact only do the else when a new record is being entered
		if (!isset($_POST['Contact'])) {
			$_POST['Contact'] = '';
		}
		echo '<table class="selection">
				<tr>
					<td>' . _('Contact Name') . ':</td>
					<td><input type="text" name="Contact" size="41" required="required" maxlength="40" value="' . $_POST['Contact'] . '" /></td>
				</tr>';
	}
	if (!isset($_POST['Position'])) {
		$_POST['Position'] = '';
	}
	if (!isset($_POST['Tel'])) {
		$_POST['Tel'] = '';
	}
	if (!isset($_POST['Fax'])) {
		$_POST['Fax'] = '';
	}
	if (!isset($_POST['Mobile'])) {
		$_POST['Mobile'] = '';
	}
	if (!isset($_POST['Email'])) {
		$_POST['Email'] = '';
	}

	echo '<tr>
			<td><input type="hidden" name="SupplierID" value="' . stripslashes($SupplierID) . '" />
			' . _('Position') . ':</td>
			<td><input type="text" name="Position" size="31" maxlength="30" value="' . $_POST['Position'] . '" /></td>
		</tr>
		<tr>
			<td>' . _('Telephone No') . ':</td>
			<td><input type="tel" name="Tel" size="31" maxlength="30" value="' . $_POST['Tel'] . '" /></td>
		</tr>
		<tr>
			<td>' . _('Facsimile No') . ':</td>
			<td><input type="tel" name="Fax" size="31" maxlength="30" value="' . $_POST['Fax'] . '" /></td>
		</tr>
		<tr>
			<td>' . _('Mobile No') . ':</td>
			<td><input type="tel" name="Mobile" size="31" maxlength="30" value="' . $_POST['Mobile'] . '" /></td>
		</tr>
		<tr>
			<td><a href="Mailto:' . $_POST['Email'] . '">' . _('Email') . ':</a></td>
			<td><input type="email" name="Email" size="51" maxlength="50" value="' . $_POST['Email'] . '" /></td>
		</tr>
		</table>
		<br />';

	echo '<div class="centre">
			<input type="submit" name="submit" value="' . _('Enter Information') . '" />
		</div>
		</form>';

} //end if record deleted no point displaying form to add record

include('includes/footer.php');
?>