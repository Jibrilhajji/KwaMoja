<?php

include('includes/session.inc');

$Title = _('Purchase Order Authorisation Maintenance');
include('includes/header.inc');

echo '<p class="page_title_text" ><img src="' . $RootPath . '/css/' . $_SESSION['Theme'] . '/images/group_add.png" title="' . _('Search') . '" alt="" />' . ' ' . $Title . '</p>';


/*Note: If CanCreate==0 then this means the user can create orders
 *	 Also if OffHold==0 then the user can release purchase invocies
 *	 This logic confused me a bit to start with
 */


if (isset($_POST['Submit'])) {
	if (isset($_POST['CanCreate']) and $_POST['CanCreate'] == 'on') {
		$CanCreate = 0;
	} else {
		$CanCreate = 1;
	}
	if (isset($_POST['OffHold']) and $_POST['OffHold'] == 'on') {
		$OffHold = 0;
	} else {
		$OffHold = 1;
	}
	if ($_POST['AuthLevel'] == '') {
		$_POST['AuthLevel'] = 0;
	}
	$SQL = "SELECT COUNT(*)
		FROM purchorderauth
		WHERE userid='" . $_POST['UserID'] . "'
		AND currabrev='" . $_POST['CurrCode'] . "'";
	$Result = DB_query($SQL);
	$MyRow = DB_fetch_array($Result);
	if ($MyRow[0] == 0) {
		$SQL = "INSERT INTO purchorderauth ( userid,
						currabrev,
						cancreate,
						offhold,
						authlevel)
					VALUES( '" . $_POST['UserID'] . "',
						'" . $_POST['CurrCode'] . "',
						'" . $CanCreate . "',
						'" . $OffHold . "',
						'" . filter_number_format($_POST['AuthLevel']) . "')";
		$ErrMsg = _('The authentication details cannot be inserted because');
		$Result = DB_query($SQL, $ErrMsg);
	} else {
		prnMsg(_('There already exists an entry for this user/currency combination'), 'error');
		echo '<br />';
	}
}

if (isset($_POST['Update'])) {
	if (isset($_POST['CanCreate']) and $_POST['CanCreate'] == 'on') {
		$CanCreate = 0;
	} else {
		$CanCreate = 1;
	}
	if (isset($_POST['OffHold']) and $_POST['OffHold'] == 'on') {
		$OffHold = 0;
	} else {
		$OffHold = 1;
	}
	$SQL = "UPDATE purchorderauth SET
			cancreate='" . $CanCreate . "',
			offhold='" . $OffHold . "',
			authlevel='" . filter_number_format($_POST['AuthLevel']) . "'
			WHERE userid='" . $_POST['UserID'] . "'
			AND currabrev='" . $_POST['CurrCode'] . "'";

	$ErrMsg = _('The authentication details cannot be updated because');
	$Result = DB_query($SQL, $ErrMsg);
}

if (isset($_GET['Delete'])) {
	$SQL = "DELETE FROM purchorderauth
		WHERE userid='" . $_GET['UserID'] . "'
		AND currabrev='" . $_GET['Currency'] . "'";

	$ErrMsg = _('The authentication details cannot be deleted because');
	$Result = DB_query($SQL, $ErrMsg);
}

if (isset($_GET['Edit'])) {
	$SQL = "SELECT cancreate,
				offhold,
				authlevel
			FROM purchorderauth
			WHERE userid='" . $_GET['UserID'] . "'
			AND currabrev='" . $_GET['Currency'] . "'";
	$ErrMsg = _('The authentication details cannot be retrieved because');
	$Result = DB_query($SQL, $ErrMsg);
	$MyRow = DB_fetch_array($Result);
	$UserID = $_GET['UserID'];
	$Currency = $_GET['Currency'];
	$CanCreate = $MyRow['CanCreate'];
	$OffHold = $MyRow['offhold'];
	$AuthLevel = $MyRow['authlevel'];
}

$SQL = "SELECT purchorderauth.userid,
			www_users.realname,
			currencies.currabrev,
			currencies.currency,
			currencies.decimalplaces,
			purchorderauth.cancreate,
			purchorderauth.offhold,
			purchorderauth.authlevel
	FROM purchorderauth INNER JOIN www_users
		ON purchorderauth.userid=www_users.userid
	INNER JOIN currencies
		ON purchorderauth.currabrev=currencies.currabrev";

$ErrMsg = _('The authentication details cannot be retrieved because');
$Result = DB_query($SQL, $ErrMsg);

echo '<table class="selection">
	 <tr>
		<th>' . _('User ID') . '</th>
		<th>' . _('User Name') . '</th>
		<th>' . _('Currency') . '</th>
		<th>' . _('Create Order') . '</th>
		<th>' . _('Can Release') . '<br />' . _('Invoices') . '</th>
		<th>' . _('Authority Level') . '</th>
	</tr>';

while ($MyRow = DB_fetch_array($Result)) {
	if ($MyRow['cancreate'] == 0) {
		$DisplayCanCreate = _('Yes');
	} else {
		$DisplayCanCreate = _('No');
	}
	if ($MyRow['offhold'] == 0) {
		$DisplayOffHold = _('Yes');
	} else {
		$DisplayOffHold = _('No');
	}
	echo '<tr>
			<td>' . $MyRow['userid'] . '</td>
			<td>' . $MyRow['realname'] . '</td>
			<td>' . $MyRow['currency'] . '</td>
			<td>' . $DisplayCanCreate . '</td>
			<td>' . $DisplayOffHold . '</td>
			<td class="number">' . locale_number_format($MyRow['authlevel'], $MyRow['decimalplaces']) . '</td>
			<td><a href="' . $RootPath . '/PO_AuthorisationLevels.php?Edit=Yes&amp;UserID=' . $MyRow['userid'] . '&amp;Currency=' . $MyRow['currabrev'] . '">' . _('Edit') . '</a></td>
			<td><a href="' . $RootPath . '/PO_AuthorisationLevels.php?Delete=Yes&amp;UserID=' . $MyRow['userid'] . '&amp;Currency=' . $MyRow['currabrev'] . '" onclick="return MakeConfirm(\'' . _('Are you sure you wish to delete this authorisation level?') . '\', \'Confirm Delete\', this);">' . _('Delete') . '</a></td>
		</tr>';
}

echo '</table>';

if (!isset($_GET['Edit'])) {
	$UserID = $_SESSION['UserID'];
	$Currency = $_SESSION['CompanyRecord']['currencydefault'];
	$CanCreate = 0;
	$OffHold = 0;
	$AuthLevel = 0;
}

echo '<form action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '" method="post" id="form1">';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
echo '<table class="selection">';

if (isset($_GET['Edit'])) {
	echo '<tr><td>' . _('User ID') . '</td><td>' . $_GET['UserID'] . '</td></tr>';
	echo '<input type="hidden" name="UserID" value="' . $_GET['UserID'] . '" />';
} else {
	echo '<tr>
			<td>' . _('User ID') . '</td>
			<td><select required="required" name="UserID">';
	$usersql = "SELECT userid FROM www_users";
	$userresult = DB_query($usersql);
	while ($MyRow = DB_fetch_array($userresult)) {
		if ($MyRow['userid'] == $UserID) {
			echo '<option selected="selected" value="' . $MyRow['userid'] . '">' . $MyRow['userid'] . '</option>';
		} else {
			echo '<option value="' . $MyRow['userid'] . '">' . $MyRow['userid'] . '</option>';
		}
	}
	echo '</select></td></tr>';
}

if (isset($_GET['Edit'])) {
	$SQL = "SELECT cancreate,
				offhold,
				authlevel,
				currency,
				decimalplaces
			FROM purchorderauth INNER JOIN currencies
			ON purchorderauth.currabrev=currencies.currabrev
			WHERE userid='" . $_GET['UserID'] . "'
			AND purchorderauth.currabrev='" . $_GET['Currency'] . "'";
	$ErrMsg = _('The authentication details cannot be retrieved because');
	$Result = DB_query($SQL, $ErrMsg);
	$MyRow = DB_fetch_array($Result);
	$UserID = $_GET['UserID'];
	$Currency = $_GET['Currency'];
	$CanCreate = $MyRow['cancreate'];
	$OffHold = $MyRow['offhold'];
	$AuthLevel = $MyRow['authlevel'];
	$CurrDecimalPlaces = $MyRow['decimalplaces'];

	echo '<tr>
			<td>' . _('Currency') . '</td>
			<td>' . $MyRow['currency'] . '</td>
		</tr>';
	echo '<input type="hidden" name="CurrCode" value="' . $Currency . '" />';
} else {
	echo '<tr>
			<td>' . _('Currency') . '</td>
			<td><select required="required" name="CurrCode">';
	$currencysql = "SELECT currabrev,
							currency,
							decimalplaces
						FROM currencies";
	$currencyresult = DB_query($currencysql);
	while ($MyRow = DB_fetch_array($currencyresult)) {
		if ($_SESSION['CompanyRecord']['currencydefault'] == $MyRow['currabrev']) {
			$CurrDecimalPlaces = $MyRow['decimalplaces'];
		}
		if ($MyRow['currabrev'] == $Currency) {
			echo '<option selected="selected" value="' . $MyRow['currabrev'] . '">' . $MyRow['currency'] . '</option>';
		} else {
			echo '<option value="' . $MyRow['currabrev'] . '">' . $MyRow['currency'] . '</option>';
		}
	}
	echo '</select></td></tr>';
}

echo '<tr>
		<td>' . _('User can create orders') . '</td>';
if ($CanCreate == 1) {
	echo '<td><input type="checkbox" name="CanCreate" /></td>
		</tr>';
} else {
	echo '<td><input type="checkbox" checked="checked" name="CanCreate" /></td>
		</tr>';
}

echo '<tr>
		<td>' . _('User can release invoices') . '</td>';
if ($OffHold == 1) {
	echo '<td><input type="checkbox" name="OffHold" /></td>
		</tr>';
} else {
	echo '<td><input type="checkbox" checked="checked" name="OffHold" /></td>
		</tr>';
}

echo '<tr>
		<td>' . _('User can authorise orders up to') . ':</td>';
echo '<td><input type="text" name="AuthLevel" required="required" maxlength="11" size="11" class="integer" value="' . locale_number_format($AuthLevel, $CurrDecimalPlaces) . '" /></td>
	</tr>
	</table>';

if (isset($_GET['Edit'])) {
	echo '<div class="centre">
				<input type="submit" name="Update" value="' . _('Update Information') . '" />
			</div>';
} else {
	echo '<div class="centre">
			<input type="submit" name="Submit" value="' . _('Enter Information') . '" />
		</div>';
}
echo '</form>';
include('includes/footer.inc');
?>