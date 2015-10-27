<?php

include('includes/session.inc');
$Title = _('Maintenance Of Petty Cash Tabs');
/* Manual links before header.inc */
$ViewTopic = 'PettyCash';
$BookMark = 'PCTabSetup';
include('includes/header.inc');

echo '<p class="page_title_text" ><img src="' . $RootPath . '/css/' . $_SESSION['Theme'] . '/images/money_add.png" title="' . _('Payment Entry') . '" alt="" />' . ' ' . $Title . '</p>';

if (isset($_POST['SelectedTab'])) {
	$SelectedTab = mb_strtoupper($_POST['SelectedTab']);
} elseif (isset($_GET['SelectedTab'])) {
	$SelectedTab = mb_strtoupper($_GET['SelectedTab']);
}

if (isset($_POST['Cancel'])) {
	unset($SelectedTab);
	unset($_POST['TabCode']);
	unset($_POST['SelectUser']);
	unset($_POST['SelectTabs']);
	unset($_POST['SelectCurrency']);
	unset($_POST['TabLimit']);
	unset($_POST['SelectAssigner']);
	unset($_POST['SelectAuthoriser']);
	unset($_POST['SelectAuthoriserExpenses']);
	unset($_POST['GLAccountCash']);
	unset($_POST['GLAccountPcashTab']);
}


if (isset($Errors)) {
	unset($Errors);
}

$Errors = array();

if (isset($_POST['Submit'])) {

	//initialise no input errors assumed initially before we test
	$InputError = 0;

	/* actions to take once the user has clicked the submit button
	ie the page has called itself with some user input */

	//first off validate inputs sensible
	$i = 1;

	if ($_POST['TabCode'] == '' or $_POST['TabCode'] == ' ' or $_POST['TabCode'] == '  ') {
		$InputError = 1;
		prnMsg('<br />' . _('The Tab code cannot be an empty string or spaces'), 'error');
		$Errors[$i] = 'TabCode';
		++$i;
	} elseif (mb_strlen($_POST['TabCode']) > 20) {
		$InputError = 1;
		echo prnMsg(_('The Tab code must be twenty characters or less long'), 'error');
		$Errors[$i] = 'TabCode';
		++$i;
	} elseif (($_POST['SelectUser']) == '') {
		$InputError = 1;
		echo prnMsg(_('You must select a User for this tab'), 'error');
		$Errors[$i] = 'UserName';
		++$i;
	} elseif (($_POST['SelectTabs']) == '') {
		$InputError = 1;
		echo prnMsg(_('You must select a type of tab from the list'), 'error');
		$Errors[$i] = 'TabType';
		++$i;
	} elseif (($_POST['SelectAssigner']) == '') {
		$InputError = 1;
		echo prnMsg(_('You must select a User to assign cash to this tab'), 'error');
		$Errors[$i] = 'AssignerName';
		++$i;
	} elseif (($_POST['SelectAuthoriser']) == '') {
		$InputError = 1;
		echo prnMsg(_('You must select a User to authorise this tab'), 'error');
		$Errors[$i] = 'AuthoriserName';
		++$i;
	} elseif (($_POST['GLAccountCash']) == '') {
		$InputError = 1;
		echo prnMsg(_('You must select a General ledger code for the cash to be assigned from'), 'error');
		$Errors[$i] = 'GLCash';
		++$i;
	} elseif (($_POST['GLAccountPcashTab']) == '') {
		$InputError = 1;
		echo prnMsg(_('You must select a General ledger code for this petty cash tab'), 'error');
		$Errors[$i] = 'GLTab';
		++$i;
	}

	if (isset($SelectedTab) and $InputError != 1) {

		$SQL = "UPDATE pctabs SET usercode = '" . $_POST['SelectUser'] . "',
									typetabcode = '" . $_POST['SelectTabs'] . "',
									currency = '" . $_POST['SelectCurrency'] . "',
									tablimit = '" . filter_number_format($_POST['TabLimit']) . "',
									assigner = '" . $_POST['SelectAssigner'] . "',
									authorizer = '" . $_POST['SelectAuthoriser'] . "',
									authorizerexpenses = '" . $_POST['SelectAuthoriserExpenses'] . "',
									glaccountassignment = '" . $_POST['GLAccountCash'] . "',
									glaccountpcash = '" . $_POST['GLAccountPcashTab'] . "'
				WHERE tabcode = '" . $SelectedTab . "'";

		$Msg = _('The Petty Cash Tab') . ' ' . $SelectedTab . ' ' . _('has been updated');
	} elseif ($InputError != 1) {

		// First check the type is not being duplicated

		$checkSql = "SELECT count(*)
					 FROM pctabs
					 WHERE tabcode = '" . $_POST['TabCode'] . "'";

		$CheckResult = DB_query($checkSql);
		$CheckRow = DB_fetch_row($CheckResult);

		if ($CheckRow[0] > 0) {
			$InputError = 1;
			prnMsg(_('The Tab ') . ' ' . $_POST['TabCode'] . ' ' . _(' already exists'), 'error');
		} else {

			// Add new record on submit

			$SQL = "INSERT INTO pctabs	(tabcode,
							 			 usercode,
										 typetabcode,
										 currency,
										 tablimit,
										 assigner,
										 authorizer,
										 glaccountassignment,
										 glaccountpcash)
								VALUES ('" . $_POST['TabCode'] . "',
									'" . $_POST['SelectUser'] . "',
									'" . $_POST['SelectTabs'] . "',
									'" . $_POST['SelectCurrency'] . "',
									'" . filter_number_format($_POST['TabLimit']) . "',
									'" . $_POST['SelectAssigner'] . "',
									'" . $_POST['SelectAuthoriser'] . "',
									'" . $_POST['GLAccountCash'] . "',
									'" . $_POST['GLAccountPcashTab'] . "')";

			$Msg = _('The Petty Cash Tab') . ' ' . $_POST['TabCode'] . ' ' . _('has been created');

		}
	}

	if ($InputError != 1) {
		//run the SQL from either of the above possibilites
		$Result = DB_query($SQL);
		prnMsg($Msg, 'success');
		unset($SelectedTab);
		unset($_POST['SelectUser']);
		unset($_POST['TabCode']);
		unset($_POST['SelectTabs']);
		unset($_POST['SelectCurrency']);
		unset($_POST['TabLimit']);
		unset($_POST['SelectAssigner']);
		unset($_POST['SelectAuthoriser']);
		unset($_POST['GLAccountCash']);
		unset($_POST['GLAccountPcashTab']);
	}

} elseif (isset($_GET['delete'])) {

	$SQL = "DELETE FROM pctabs WHERE tabcode='" . $SelectedTab . "'";
	$ErrMsg = _('The Tab record could not be deleted because');
	$Result = DB_query($SQL, $ErrMsg);
	prnMsg(_('The Petty Cash Tab') . ' ' . $SelectedTab . ' ' . _('has been deleted'), 'success');
	unset($SelectedTab);
	unset($_GET['delete']);
}

if (!isset($SelectedTab)) {

	/* It could still be the second time the page has been run and a record has been selected for modification - SelectedTab will exist because it was sent with the new call. If its the first time the page has been displayed with no parameters
	then none of the above are true and the list of sales types will be displayed with
	links to delete or edit each. These will call the same page again and allow update/input
	or deletion of the records*/

	$SQL = "SELECT tabcode,
					usercode,
					typetabdescription,
					currabrev,
					tablimit,
					assigner,
					authorizer,
					authorizerexpenses,
					glaccountassignment,
					glaccountpcash,
					currencies.decimalplaces,
					chartmaster1.accountname AS glactassigntname,
					chartmaster2.accountname AS glactpcashname
				FROM pctabs INNER JOIN currencies
				ON pctabs.currency=currencies.currabrev
				INNER JOIN pctypetabs
				ON pctabs.typetabcode=pctypetabs.typetabcode
				INNER JOIN chartmaster AS chartmaster1 ON
				pctabs.glaccountassignment = chartmaster1.accountcode
				INNER JOIN chartmaster AS chartmaster2 ON
				pctabs.glaccountpcash = chartmaster2.accountcode
				ORDER BY tabcode";
	$Result = DB_query($SQL);
	if (DB_num_rows($Result) > 0) {
		echo '<br /><table class="selection">';
		echo '<tr>
				<th>' . _('Tab Code') . '</th>
				<th>' . _('User Name') . '</th>
				<th>' . _('Type Of Tab') . '</th>
				<th>' . _('Currency') . '</th>
				<th>' . _('Limit') . '</th>
				<th>' . _('Assigner') . '</th>
				<th>' . _('Authoriser - Payment') . '</th>
				<th>' . _('Authoriser - Expenses') . '</th>
				<th>' . _('GL Account For Cash Assignment') . '</th>
				<th>' . _('GL Account Petty Cash Tab') . '</th>
			</tr>';

		$k = 0; //row colour counter

		while ($MyRow = DB_fetch_array($Result)) {
			if ($k == 1) {
				echo '<tr class="EvenTableRows">';
				$k = 0;
			} else {
				echo '<tr class="OddTableRows">';
				$k = 1;
			}

			printf('<td>%s</td>
					<td>%s</td>
					<td>%s</td>
					<td>%s</td>
					<td class="number">%s</td>
					<td>%s</td>
					<td>%s</td>
					<td>%s</td>
					<td>%s</td>
					<td>%s</td>
					<td><a href="%sSelectedTab=%s">' . _('Edit') . '</a></td>
					<td><a href="%sSelectedTab=%s&amp;delete=yes" onclick=\' return MakeConfirm("' . _('Are you sure you wish to delete this tab code?') . '", \'Confirm Delete\', this);\'>' . _('Delete') . '</a></td>
					</tr>', $MyRow['tabcode'], $MyRow['usercode'], $MyRow['typetabdescription'], $MyRow['currabrev'], locale_number_format($MyRow['tablimit'], $MyRow['decimalplaces']), $MyRow['assigner'], $MyRow['authorizer'],  $MyRow['authorizerexpenses'], $MyRow['glaccountassignment'] . ' - ' . $MyRow['glactassigntname'], $MyRow['glaccountpcash'] . ' - ' . $MyRow['glactpcashname'], htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '?', $MyRow['tabcode'], htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '?', $MyRow['tabcode']);
		}
		//END WHILE LIST LOOP
		echo '</table>';
	} //if there are tabs to show
}

//end of ifs and buts!
if (isset($SelectedTab)) {

	echo '<br /><div class="centre"><a href="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '">' . _('Show All Tabs Defined') . '</a></div>';
}
if (!isset($_GET['delete'])) {

	echo '<form method="post" action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '">';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '<br />'; //Main table

	if (isset($SelectedTab) and $SelectedTab != '') {

		$SQL = "SELECT * FROM pctabs
				WHERE tabcode='" . $SelectedTab . "'";

		$Result = DB_query($SQL);
		$MyRow = DB_fetch_array($Result);

		$_POST['TabCode'] = $MyRow['tabcode'];
		$_POST['SelectUser'] = $MyRow['usercode'];
		$_POST['SelectTabs'] = $MyRow['typetabcode'];
		$_POST['SelectCurrency'] = $MyRow['currency'];
		$_POST['TabLimit'] = locale_number_format($MyRow['tablimit']);
		$_POST['SelectAssigner'] = $MyRow['assigner'];
		$_POST['SelectAuthoriser'] = $MyRow['authorizer'];
		$_POST['SelectAuthoriserExpenses'] = $MyRow['authorizerexpenses'];
		$_POST['GLAccountCash'] = $MyRow['glaccountassignment'];
		$_POST['GLAccountPcashTab'] = $MyRow['glaccountpcash'];


		echo '<input type="hidden" name="SelectedTab" value="' . $SelectedTab . '" />';
		echo '<input type="hidden" name="TabCode" value="' . $_POST['TabCode'] . '" />';
		echo '<table class="selection">
				<tr>
					<td>' . _('Tab Code') . ':</td>
					<td>' . $_POST['TabCode'] . '</td>
				</tr>';
	} else {
		// This is a new type so the user may volunteer a type code
		echo '<table class="selection">
				<tr>
					<td>' . _('Tab Code') . ':</td>
					<td><input type="text" required="required" maxlength="20" name="TabCode" /></td>
				</tr>';

	}

	if (!isset($_POST['typetabdescription'])) {
		$_POST['typetabdescription'] = '';
	}

	echo '<tr>
			<td>' . _('User Name') . ':</td>
			<td><select required="required" name="SelectUser">';

	$SQL = "SELECT userid,
					realname
			FROM www_users ORDER BY userid";

	$Result = DB_query($SQL);

	while ($MyRow = DB_fetch_array($Result)) {
		if (isset($_POST['SelectUser']) and $MyRow['userid'] == $_POST['SelectUser']) {
			echo '<option selected="selected" value="';
		} else {
			echo '<option value="';
		}
		echo $MyRow['userid'] . '">' . $MyRow['userid'] . ' - ' . $MyRow['realname'] . '</option>';

	} //end while loop get user

	echo '</select></td></tr>';
	DB_free_result($Result);

	echo '<tr>
			<td>' . _('Type Of Tab') . ':</td>
			<td><select required="required" name="SelectTabs">';

	$SQL = "SELECT typetabcode,
					typetabdescription
			FROM pctypetabs
			ORDER BY typetabcode";

	$Result = DB_query($SQL);

	while ($MyRow = DB_fetch_array($Result)) {
		if (isset($_POST['SelectTabs']) and $MyRow['typetabcode'] == $_POST['SelectTabs']) {
			echo '<option selected="selected" value="';
		} else {
			echo '<option value="';
		}
		echo $MyRow['typetabcode'] . '">' . $MyRow['typetabcode'] . ' - ' . $MyRow['typetabdescription'] . '</option>';

	} //end while loop get type of tab

	echo '</select></td></tr>';
	DB_free_result($Result);

	echo '<tr>
			<td>' . _('Currency') . ':</td>
			<td><select required="required" name="SelectCurrency">';

	$SQL = "SELECT currency, currabrev FROM currencies";

	$Result = DB_query($SQL);

	while ($MyRow = DB_fetch_array($Result)) {
		if (isset($_POST['SelectCurrency']) and $MyRow['currabrev'] == $_POST['SelectCurrency']) {
			echo '<option selected="selected" value="';
		} else {
			echo '<option value="';
		}
		echo $MyRow['currabrev'] . '">' . $MyRow['currency'] . '</option>';

	} //end while loop get type of tab

	echo '</select></td></tr>';
	DB_free_result($Result);

	if (!isset($_POST['TabLimit'])) {
		$_POST['TabLimit'] = 0;
	}

	echo '<tr>
			<td>' . _('Limit Of Tab') . ':</td>
			<td>
				<input type="text" class="number" name="TabLimit" size="12" required="required" maxlength="11" value="' . $_POST['TabLimit'] . '" />
			</td>
		</tr>';

	echo '<tr>
			<td>' . _('Assigner') . ':</td>
			<td><select required="required" name="SelectAssigner">';

	$SQL = "SELECT userid,
					realname
			FROM www_users
			ORDER BY userid";

	$Result = DB_query($SQL);

	while ($MyRow = DB_fetch_array($Result)) {
		if (isset($_POST['SelectAssigner']) and $MyRow['userid'] == $_POST['SelectAssigner']) {
			echo '<option selected="selected" value="';
		} else {
			echo '<option value="';
		}
		echo $MyRow['userid'] . '">' . $MyRow['userid'] . ' - ' . $MyRow['realname'] . '</option>';

	} //end while loop get assigner

	echo '</select></td></tr>';
	DB_free_result($Result);

	echo '<tr>
			<td>' . _('Authoriser - Payment') . ':</td>
			<td><select required="required" name="SelectAuthoriser">';

	$SQL = "SELECT userid,
					realname
			FROM www_users
			ORDER BY userid";

	$Result = DB_query($SQL);

	while ($MyRow = DB_fetch_array($Result)) {
		if (isset($_POST['SelectAuthoriser']) and $MyRow['userid'] == $_POST['SelectAuthoriser']) {
			echo '<option selected="selected" value="';
		} else {
			echo '<option value="';
		}
		echo $MyRow['userid'] . '">' . $MyRow['userid'] . ' - ' . $MyRow['realname'] . '</option>';

	} //end while loop get authoriser

	echo '</select></td></tr>';

	echo '<tr>
			<td>' . _('Authoriser - Expenses') . ':</td>
			<td><select required="required" name="SelectAuthoriserExpenses">';

	$SQL = "SELECT userid,
					realname
			FROM www_users
			ORDER BY userid";

	$Result = DB_query($SQL);

	while ($MyRow = DB_fetch_array($Result)) {
		if (isset($_POST['SelectAuthoriserExpenses']) and $MyRow['userid'] == $_POST['SelectAuthoriserExpenses']) {
			echo '<option selected="selected" value="';
		} else {
			echo '<option value="';
		}
		echo $MyRow['userid'] . '">' . $MyRow['userid'] . ' - ' . $MyRow['realname'] . '</option>';

	} //end while loop get authoriser

	echo '</select></td></tr>';
	DB_free_result($Result);

	echo '<tr>
			<td>' . _('GL Account Cash Assignment') . ':</td>
			<td><select required="required" name="GLAccountCash">';

	$SQL = "SELECT chartmaster.accountcode,
					chartmaster.accountname
			FROM chartmaster INNER JOIN bankaccounts
			ON chartmaster.accountcode = bankaccounts.accountcode
			ORDER BY chartmaster.accountcode";

	$Result = DB_query($SQL);

	while ($MyRow = DB_fetch_array($Result)) {
		if (isset($_POST['GLAccountCash']) and $MyRow['accountcode'] == $_POST['GLAccountCash']) {
			echo '<option selected="selected" value="';
		} else {
			echo '<option value="';
		}
		echo $MyRow['accountcode'] . '">' . $MyRow['accountcode'] . ' - ' . htmlspecialchars($MyRow['accountname'], ENT_QUOTES, 'UTF-8', false) . '</option>';

	} //end while loop

	echo '</select></td></tr>';
	DB_free_result($Result);

	echo '<tr>
			<td>' . _('GL Account Petty Cash Tab') . ':</td>
			<td><select required="required" name="GLAccountPcashTab">';

	$SQL = "SELECT accountcode, accountname
			FROM chartmaster
			ORDER BY accountcode";

	$Result = DB_query($SQL);

	while ($MyRow = DB_fetch_array($Result)) {
		if (isset($_POST['GLAccountPcashTab']) and $MyRow['accountcode'] == $_POST['GLAccountPcashTab']) {
			echo '<option selected="selected" value="';
		} else {
			echo '<option value="';
		}
		echo $MyRow['accountcode'] . '">' . $MyRow['accountcode'] . ' - ' . htmlspecialchars($MyRow['accountname'], ENT_QUOTES, 'UTF-8', false) . '</option>';

	} //end while loop

	echo '</select></td></tr>';
	echo '</table>'; // close main table
	DB_free_result($Result);

	echo '<br /><div class="centre">
		<input type="submit" name="Submit" value="' . _('Accept') . '" />
		<input type="submit" name="Cancel" value="' . _('Cancel') . '" /></div>';

	echo '</form>';

} // end if user wish to delete

include('includes/footer.inc');
?>