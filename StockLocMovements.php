<?php

include('includes/session.inc');

$Title = _('All Stock Movements By Location');

include('includes/header.inc');

echo '<form onSubmit="return VerifyForm(this);" action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '" method="post" class="noPrint">';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';

echo '<p class="page_title_text noPrint" ><img src="' . $RootPath . '/css/' . $Theme . '/images/magnifier.png" title="' . _('Search') . '" alt="" />' . ' ' . $Title . '</p>';

echo '<table class="selection">
	 <tr>
		 <td>  ' . _('From Stock Location') . ':<select required="required" minlength="1" name="StockLocation"> ';

if ($_SESSION['RestrictLocations'] == 0) {
	$sql = "SELECT locationname,
					loccode
				FROM locations";
	echo '<option selected="selected" value="All">' . _('All Locations') . '</option>';
	if (!isset($_POST['StockLocation'])) {
		$_POST['StockLocation'] = 'All';
	}
} else {
	$sql = "SELECT locationname,
					loccode
				FROM locations
				INNER JOIN www_users
					ON locations.loccode=www_users.defaultlocation
				WHERE www_users.userid='" . $_SESSION['UserID'] . "'";
	if (!isset($_POST['StockLocation'])) {
		$_POST['StockLocation'] = $_SESSION['UserStockLocation'];
	}
}

$resultStkLocs = DB_query($sql);
while ($myrow = DB_fetch_array($resultStkLocs)) {
	if (isset($_POST['StockLocation']) and $_POST['StockLocation'] != 'All') {
		if ($myrow['loccode'] == $_POST['StockLocation']) {
			echo '<option selected="selected" value="' . $myrow['loccode'] . '">' . $myrow['locationname'] . '</option>';
		} else {
			echo '<option value="' . $myrow['loccode'] . '">' . $myrow['locationname'] . '</option>';
		}
	} else {
		echo '<option value="' . $myrow['loccode'] . '">' . $myrow['locationname'] . '</option>';
	}
}

echo '</select>';

if (!isset($_POST['BeforeDate']) or !Is_Date($_POST['BeforeDate'])) {
	$_POST['BeforeDate'] = Date($_SESSION['DefaultDateFormat']);
}
if (!isset($_POST['AfterDate']) or !Is_Date($_POST['AfterDate'])) {
	$_POST['AfterDate'] = Date($_SESSION['DefaultDateFormat'], Mktime(0, 0, 0, Date('m') - 1, Date('d'), Date('y')));
}
echo ' ' . _('Show Movements before') . ': <input type="text" class="date" alt="' . $_SESSION['DefaultDateFormat'] . '" name="BeforeDate" size="12" required="required" minlength="1" maxlength="12" value="' . $_POST['BeforeDate'] . '" />';
echo ' ' . _('But after') . ': <input type="text" class="date" alt="' . $_SESSION['DefaultDateFormat'] . '" name="AfterDate" size="12" required="required" minlength="1" maxlength="12" value="' . $_POST['AfterDate'] . '" />';
echo '</td>
	 </tr>
	 </table>';
echo '<div class="centre">
		   <input type="submit" name="ShowMoves" value="' . _('Show Stock Movements') . '" />
	 </div>';

if ($_POST['StockLocation'] == 'All') {
	$_POST['StockLocation'] = '%%';
}

$SQLBeforeDate = FormatDateForSQL($_POST['BeforeDate']);
$SQLAfterDate = FormatDateForSQL($_POST['AfterDate']);

$sql = "SELECT stockmoves.stockid,
				systypes.typename,
				stockmoves.type,
				stockmoves.transno,
				stockmoves.trandate,
				stockmoves.debtorno,
				stockmoves.branchcode,
				stockmoves.qty,
				stockmoves.reference,
				stockmoves.price,
				stockmoves.discountpercent,
				stockmoves.newqoh,
				stockmaster.decimalplaces
			FROM stockmoves
			INNER JOIN systypes ON stockmoves.type=systypes.typeid
			INNER JOIN stockmaster ON stockmoves.stockid=stockmaster.stockid
			WHERE  stockmoves.loccode " . LIKE . " '" . $_POST['StockLocation'] . "'
			AND stockmoves.trandate >= '" . $SQLAfterDate . "'
			AND stockmoves.trandate <= '" . $SQLBeforeDate . "'
			AND hidemovt=0
			ORDER BY stkmoveno DESC";
$ErrMsg = _('The stock movements for the selected criteria could not be retrieved because');
$MovtsResult = DB_query($sql, $ErrMsg);

echo '<table cellpadding="5" cellspacing="4 "class="selection">
		<tr>
			<th>' . _('Item Code') . '</th>
			<th>' . _('Type') . '</th>
			<th>' . _('Trans No') . '</th>
			<th>' . _('Date') . '</th>
			<th>' . _('Customer') . '</th>
			<th>' . _('Quantity') . '</th>
			<th>' . _('Reference') . '</th>
			<th>' . _('Price') . '</th>
			<th>' . _('Discount') . '</th>
			<th>' . _('Quantity on Hand') . '</th>
		</tr>';

$k = 0; //row colour counter

while ($myrow = DB_fetch_array($MovtsResult)) {

	if ($k == 1) {
		echo '<tr class="OddTableRows">';
		$k = 0;
	} else {
		echo '<tr class="EvenTableRows">';
		$k = 1;
	}

	$DisplayTranDate = ConvertSQLDate($myrow['trandate']);


	printf('<td><a target="_blank" href="' . $RootPath . '/StockStatus.php?StockID=%s">%s</a></td>
				<td>%s</td>
				<td>%s</td>
				<td>%s</td>
				<td>%s</td>
				<td class="number">%s</td>
				<td>%s</td>
				<td class="number">%s</td>
				<td class="number">%s</td>
				<td class="number">%s</td>
				</tr>', mb_strtoupper($myrow['stockid']), mb_strtoupper($myrow['stockid']), $myrow['typename'], $myrow['transno'], $DisplayTranDate, $myrow['debtorno'], locale_number_format($myrow['qty'], $myrow['decimalplaces']), $myrow['reference'], locale_number_format($myrow['price'], $_SESSION['CompanyRecord']['decimalplaces']), locale_number_format($myrow['discountpercent'] * 100, 2), locale_number_format($myrow['newqoh'], $myrow['decimalplaces']));
}
//end of while loop

echo '</table>';
echo '</form>';

include('includes/footer.inc');

?>