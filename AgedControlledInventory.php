<?php

include('includes/session.inc');
$PricesSecurity = 1000; //don't show pricing info unless security token 1000 available to user
$Today =  time();
$Title = _('Aged Controlled Inventory') . ' ' ._('as-of') .' ' . Date(($_SESSION['DefaultDateFormat']), $Today );
include('includes/header.inc');

echo '<p class="page_title_text">
		<img src="' . $RootPath . '/css/' . $_SESSION['Theme'] . '/images/inventory.png" title="' . _('Inventory') . '" alt="" /><b>' . $Title . '</b>
	</p>';

$SQL = "SELECT stockserialitems.stockid,
				stockmaster.description,
				stockserialitems.serialno,
				stockserialitems.quantity,
				stockmoves.trandate,
				stockcosts.materialcost+stockcosts.labourcost+stockcosts.overheadcost AS cost,
				createdate,
				decimalplaces
			FROM stockserialitems
			LEFT JOIN stockserialmoves
				ON stockserialitems.serialno=stockserialmoves.serialno
			LEFT JOIN stockmoves
				ON stockserialmoves.stockmoveno=stockmoves.stkmoveno
			INNER JOIN stockmaster
				ON stockmaster.stockid = stockserialitems.stockid
			LEFT JOIN stockcosts
				ON stockcosts.stockid=stockmaster.stockid
				AND stockcosts.succeeded=0
			INNER JOIN locationusers
				ON locationusers.loccode=stockserialitems.loccode
				AND locationusers.userid='" . $_SESSION['UserID'] . "'
				AND locationusers.canview=1
			WHERE quantity > 0
			ORDER BY createdate, quantity";
$ErrMsg = _('The stock held could not be retrieved because');
$LocStockResult = DB_query($SQL, $ErrMsg);
$NumRows = DB_num_rows($LocStockResult);

$j = 1;
$TotalQty = 0;
$TotalVal = 0;
$k = 0; //row colour counter
echo '<table>
		<thead>
			<tr>
				<th class="SortedColumn">' . _('Stock') . '</th>
				<th class="SortedColumn">' . _('Description') . '</th>
				<th class="SortedColumn">' . _('Batch') . '</th>
				<th class="SortedColumn">' . _('Quantity Remaining') . '</th>
				<th class="SortedColumn">' . _('Inventory Value') . '</th>
				<th class="SortedColumn">' . _('Date') . '</th>
				<th class="SortedColumn">' . _('Days Old') . '</th>
			</tr>
		</thead>';

echo '<tbody>';
while ($LocQtyRow = DB_fetch_array($LocStockResult)) {

	if ($k == 1) {
		echo '<tr class="OddTableRows">';
		$k = 0;
	} else {
		echo '<tr class="EvenTableRows">';
		$k = 1;
	}
	$DaysOld = floor(($Today - strtotime($LocQtyRow['createdate'])) / (60 * 60 * 24));
	$TotalQty += $LocQtyRow['quantity'];
	$DispVal = '-----------';
	if (in_array($PricesSecurity, $_SESSION['AllowedPageSecurityTokens']) OR !isset($PricesSecurity)) {
		$DispVal = locale_number_format(($LocQtyRow['quantity'] * $LocQtyRow['cost']), $LocQtyRow['decimalplaces']);
		$TotalVal += ($LocQtyRow['quantity'] * $LocQtyRow['cost']);
	}
	printf('<td>%s</td>
			<td>%s</td>
			<td>%s</td>
			<td class="number">%s</td>
			<td class="number">%s</td>
			<td>%s</td>
			<td class="number">%s</td>
		</tr>',
			mb_strtoupper($LocQtyRow['stockid']),
			$LocQtyRow['description'],
			$LocQtyRow['serialno'],
			locale_number_format($LocQtyRow['quantity'], $LocQtyRow['decimalplaces']),
			$DispVal,
			ConvertSQLDate($LocQtyRow['createdate']),
			$DaysOld
		);


} //while
echo '</tbody>';
if ($k == 1) {
	echo '<tfoot><tr class="OddTableRows">';
	$k = 0;
} else {
	echo '<tfoot><tr class="EvenTableRows">';
	$k = 1;
}
echo '<td colspan="3"><b>' . _('Total') . '</b></td>
		<td class="number"><b>' . locale_number_format($TotalQty, 2) . '</td>
		<td class="number"><b>' . locale_number_format($TotalVal, 2) . '</td>
		<td colspan="2"></td>
	</tr>
</tfoot>';
echo '</table>';

include('includes/footer.inc');
?>