<?php

include('includes/session.inc');

if (isset($_POST['ShowReport'])) {

	$SQL = "SELECT grnno,
					purchorderdetails.orderno,
					grns.supplierid,
					suppliers.suppname,
					grns.itemcode,
					grns.itemdescription,
					qtyrecd,
					quantityinv,
					grns.stdcostunit,
					actprice,
					unitprice,
					suppliers.currcode,
					currencies.rate,
					currencies.decimalplaces as currdecimalplaces,
					stockmaster.decimalplaces as itemdecimalplaces
				FROM grns
				INNER JOIN purchorderdetails
					ON grns.podetailitem = purchorderdetails.podetailitem
				INNER JOIN suppliers
					ON grns.supplierid=suppliers.supplierid
				INNER JOIN currencies
					ON suppliers.currcode=currencies.currabrev
				LEFT JOIN stockmaster
					ON grns.itemcode=stockmaster.stockid
				WHERE qtyrecd-quantityinv>0
					AND grns.supplierid >='" . $_POST['FromCriteria'] . "'
					AND grns.supplierid <='" . $_POST['ToCriteria'] . "'
				ORDER BY supplierid,
					grnno";

	$GRNsResult = DB_query($SQL, '', '', false, false);

	if (DB_error_no() != 0) {
		$Title = _('Outstanding GRN Valuation') . ' - ' . _('Problem Report');
		include('includes/header.inc');
		prnMsg(_('The outstanding GRNs valuation details could not be retrieved by the SQL because') . ' - ' . DB_error_msg(), 'error');
		echo '<br /><a href="' . $RootPath . '/index.php">' . _('Back to the menu') . '</a>';
		include('includes/footer.inc');
		exit;
	}
	if (DB_num_rows($GRNsResult) == 0) {
		$Title = _('Outstanding GRN Valuation') . ' - ' . _('Problem Report');
		include('includes/header.inc');
		prnMsg(_('No outstanding GRNs valuation details retrieved'), 'warn');
		echo '<br /><a href="' . $RootPath . '/index.php">' . _('Back to the menu') . '</a>';
		include('includes/footer.inc');
		exit;
	}

	$Title = _('Outstanding GRNs Report');
	include('includes/header.inc');

	echo '<p class="page_title_text noPrint"  align="center">
			<img src="' . $RootPath . '/css/' . $Theme . '/images/inventory.png" title="' . _('Goods Received but not invoiced Yet') . '" alt="" />' . _('Goods Received but not invoiced Yet') . '
		</p>';

	echo '<div class="page_help_text noPrint">' . _('Shows the list of goods received not yet invoiced, both in supplier currency and home currency. When run for all suppliers, the total in home curency should match the GL Account for Goods received not invoiced.') . '</div>';

	echo '<table class="selection">
			<thead>
				<tr>
					<th colspan="14">
						<b>' . _('Outstanding GRN report') . '</b>
						<img src="' . $RootPath . '/css/' . $Theme . '/images/printer.png" class="PrintIcon noPrint" title="' . _('Print') . '" alt="' . _('Print') . '" onclick="window.print();" />
					</th>
				</tr>
				<tr>
					<th>' . _('Supplier') . '</th>
					<th>' . _('Supplier Name') . '</th>
					<th>' . _('PO#') . '</th>
					<th>' . _('Item Code') . '</th>
					<th>' . _('Qty Received') . '</th>
					<th>' . _('Qty Invoiced') . '</th>
					<th>' . _('Qty Pending') . '</th>
					<th colspan="2">' . _('Unit Price') . '</th>
					<th colspan="2">' . _('Line Total') . '</th>
					<th colspan="2">' . _('Line Total') . '</th>
				</tr>
			</thead>';
	$k = 0; //row colour counter
	$TotalHomeCurrency = 0;
	while ($GRNs = DB_fetch_array($GRNsResult)) {
		if ($k == 1) {
			echo '<tr class="EvenTableRows">';
			$k = 0;
		} else {
			echo '<tr class="OddTableRows">';
			$k = 1;
		}
		$QtyPending = $GRNs['qtyrecd'] - $GRNs['quantityinv'];
		$TotalHomeCurrency = $TotalHomeCurrency + ($QtyPending * $GRNs['stdcostunit']);
		echo '<td>' . $GRNs['supplierid'] . '</td>
				<td>' . $GRNs['suppname'] . '</td>
				<td class="number">' . $GRNs['orderno'] . '</td>
				<td>' . $GRNs['itemcode'] . '</td>
				<td class="number">' . locale_number_format($GRNs['qtyrecd'], $GRNs['itemdecimalplaces']) . '</td>
				<td class="number">' . locale_number_format($GRNs['quantityinv'], $GRNs['itemdecimalplaces']) . '</td>
				<td class="number">' . locale_number_format($QtyPending, $GRNs['itemdecimalplaces']) . '</td>
				<td class="number">' . locale_number_format($GRNs['unitprice'], $GRNs['currdecimalplaces']) . '</td>
				<td>' . $GRNs['currcode'] . '</td>
				<td class="number">' . locale_number_format(($QtyPending * $GRNs['unitprice']), $GRNs['currdecimalplaces']) . '</td>
				<td>' . $GRNs['currcode'] . '</td>
				<td class="number">' . locale_number_format(($GRNs['qtyrecd'] - $GRNs['quantityinv']) * $GRNs['stdcostunit'], $_SESSION['CompanyRecord']['decimalplaces']) . '</td>
				<td>' . $_SESSION['CompanyRecord']['currencydefault'] . '</td>
			</tr>';

	}
	echo '<tr>
			<td colspan="10"></td>
			<td>' . _('Total') . ':</td>
			<td class="number">' . locale_number_format($TotalHomeCurrency, $_SESSION['CompanyRecord']['decimalplaces']) . '</td>
			<td>' . $_SESSION['CompanyRecord']['currencydefault'] . '</td>
		</tr>';

	echo '</table>';

	include('includes/footer.inc');

} else {

	$SQL = "SELECT min(supplierid) AS fromcriteria,
					max(supplierid) AS tocriteria
				FROM suppliers";
	$Result = DB_query($SQL);
	$MyRow = DB_fetch_array($Result);

	$Title = _('Outstanding GRNs Report');
	include('includes/header.inc');

	echo '<p class="page_title_text noPrint"  align="center">
			<img src="' . $RootPath . '/css/' . $Theme . '/images/inventory.png" title="' . $Title . '" alt="" />' . $Title . '
		</p>';

	echo '<div class="page_help_text noPrint">' . _('Shows the list of goods received not yet invoiced, both in supplier currency and home currency. When run for all suppliers the total in home curency should match the GL Account for Goods received not invoiced.') . '</div>';

	echo '<form onSubmit="return VerifyForm(this);" action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '" method="post" class="noPrint">';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';

	echo '<table class="selection">
			<tr>
				<td>' . _('From Supplier Code') . ':</td>
				<td><input type="text" name="FromCriteria" autofocus="autofocus" required="required" minlength="1" maxlength="20" value="' . $MyRow['fromcriteria'] . '" /></td>
			</tr>
			<tr>
				<td>' . _('To Supplier Code') . ':</td>
				<td><input type="text" name="ToCriteria" required="required" minlength="1" maxlength="20" value="' . $MyRow['tocriteria'] . '" /></td>
			</tr>
		</table>
		<div class="centre">
			<input type="submit" name="ShowReport" value="' . _('Display') . '" />
		</div>
		</form>';

	include('includes/footer.inc');

}

?>