<?php

include('includes/session.inc');
$Title = _('Orders Invoiced Report');

$InputError = 0;

if (isset($_POST['FromDate']) and !is_date($_POST['FromDate'])) {
	$Msg = _('The date from must be specified in the format') . ' ' . $DefaultDateFormat;
	$InputError = 1;
	unset($_POST['FromDate']);
}
if (isset($_POST['ToDate']) and !is_date($_POST['ToDate'])) {
	$Msg = _('The date to must be specified in the format') . ' ' . $DefaultDateFormat;
	$InputError = 1;
	unset($_POST['ToDate']);
}
if (isset($_POST['FromDate']) and isset($_POST['ToDate']) and Date1GreaterThanDate2($_POST['FromDate'], $_POST['ToDate'])) {
	$Msg = _('The date to must be after the date from');
	$InputError = 1;
	unset($_POST['ToDate']);
	unset($_POST['FromoDate']);
}

if (!isset($_POST['FromDate']) or !isset($_POST['ToDate']) or $InputError == 1) {
	include('includes/header.inc');
	if ($InputError == 1) {
		prnMsg($Msg, 'error');
	}

	echo '<p class="page_title_text" ><img src="' . $RootPath . '/css/' . $_SESSION['Theme'] . '/images/transactions.png" title="' . $Title . '" alt="" />' . ' ' . _('Orders Invoiced Report') . '</p>';

	echo '<form method="post" action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '">';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
	echo '<table class="selection">
			<tr>
				<td>' . _('Enter the date from which orders are to be listed') . ':</td>
				<td><input type="text" class="date" alt="' . $_SESSION['DefaultDateFormat'] . '" name="FromDate" autofocus="autofocus" required="required" maxlength="10" size="10" value="' . Date($_SESSION['DefaultDateFormat'], Mktime(0, 0, 0, Date('m'), Date('d') - 1, Date('y'))) . '" /></td>
			</tr>';
	echo '<tr>
			<td>' . _('Enter the date to which orders are to be listed') . ':</td>
			<td><input type="text" class="date" alt="' . $_SESSION['DefaultDateFormat'] . '" name="ToDate" required="required" maxlength="10" size="10" value="' . Date($_SESSION['DefaultDateFormat']) . '" /></td></tr>';
	echo '<tr>
			<td>' . _('Inventory Category') . '</td>
			<td>';

	$SQL = "SELECT categorydescription, categoryid FROM stockcategory WHERE stocktype<>'D' AND stocktype<>'L'";
	$Result = DB_query($SQL);


	echo '<select required="required" name="CategoryID">
			<option selected="selected" value="All">' . _('Over All Categories') . '</option>';

	while ($MyRow = DB_fetch_array($Result)) {
		echo '<option value="' . $MyRow['categoryid'] . '">' . $MyRow['categorydescription'] . '</option>';
	}
	echo '</select></td></tr>';

	echo '<tr>
			<td>' . _('Inventory Location') . ':</td>
			<td><select required+"required" name="Location">';
	$SQL = "SELECT locations.loccode,
					locationname
				FROM locations
				INNER JOIN locationusers
					ON locationusers.loccode=locations.loccode
					AND locationusers.userid='" .  $_SESSION['UserID'] . "'
					AND locationusers.canview=1";
	echo '<option selected="selected" value="All">' . _('All Locations') . '</option>';

	$Result = DB_query($SQL);
	while ($MyRow = DB_fetch_array($Result)) {
		echo '<option value="' . $MyRow['loccode'] . '">' . $MyRow['locationname'] . '</option>';
	}
	echo '</select></td></tr>';

	echo '</table>
			<div class="centre">
				<input type="submit" name="Go" value="' . _('Create PDF') . '" />
			</div>';
	echo '</form>';

	include('includes/footer.inc');
	exit;
} else {
	include('includes/PDFStarter.php');
	$PDF->addInfo('Title', _('Orders Invoiced Report'));
	$PDF->addInfo('Subject', _('Orders from') . ' ' . $_POST['FromDate'] . ' ' . _('to') . ' ' . $_POST['ToDate']);
	$line_height = 12;
	$PageNumber = 1;
	$TotalDiffs = 0;
}

if ($_POST['CategoryID'] == 'All' and $_POST['Location'] == 'All') {
	$SQL = "SELECT salesorders.orderno,
					salesorders.debtorno,
					salesorders.branchcode,
					salesorders.customerref,
					salesorders.orddate,
					salesorders.fromstkloc,
					salesorders.printedpackingslip,
					salesorders.datepackingslipprinted,
					salesorderdetails.stkcode,
					stockmaster.description,
					stockmaster.units,
					stockmaster.decimalplaces,
					debtorsmaster.name,
					custbranch.brname,
					locations.locationname,
					SUM(salesorderdetails.quantity) AS totqty,
					SUM(salesorderdetails.qtyinvoiced) AS totqtyinvoiced
				FROM salesorders
				INNER JOIN salesorderdetails
					ON salesorders.orderno = salesorderdetails.orderno
				INNER JOIN stockmaster
					ON salesorderdetails.stkcode = stockmaster.stockid
				INNER JOIN debtorsmaster
					ON salesorders.debtorno=debtorsmaster.debtorno
				INNER JOIN custbranch
					ON custbranch.debtorno=salesorders.debtorno
					AND custbranch.branchcode=salesorders.branchcode
				INNER JOIN locations
					ON salesorders.fromstkloc=locations.loccode
				INNER JOIN locationusers
					ON locationusers.loccode=locations.loccode
					AND locationusers.userid='" .  $_SESSION['UserID'] . "'
					AND locationusers.canview=1
				WHERE orddate >='" . FormatDateForSQL($_POST['FromDate']) . "'
					AND orddate <='" . FormatDateForSQL($_POST['ToDate']) . "'";

} elseif ($_POST['CategoryID'] != 'All' and $_POST['Location'] == 'All') {
	$SQL = "SELECT salesorders.orderno,
					salesorders.debtorno,
					salesorders.branchcode,
					salesorders.customerref,
					salesorders.orddate,
					salesorders.fromstkloc,
					salesorders.printedpackingslip,
					salesorders.datepackingslipprinted,
					salesorderdetails.stkcode,
					stockmaster.description,
					stockmaster.units,
					stockmaster.decimalplaces,
					debtorsmaster.name,
					custbranch.brname,
					locations.locationname,
					SUM(salesorderdetails.quantity) AS totqty,
					SUM(salesorderdetails.qtyinvoiced) AS totqtyinvoiced
				FROM salesorders
				INNER JOIN salesorderdetails
					ON salesorders.orderno = salesorderdetails.orderno
				INNER JOIN stockmaster
					ON salesorderdetails.stkcode = stockmaster.stockid
				INNER JOIN debtorsmaster
					ON salesorders.debtorno=debtorsmaster.debtorno
				INNER JOIN custbranch
					ON custbranch.debtorno=salesorders.debtorno
					AND custbranch.branchcode=salesorders.branchcode
				INNER JOIN locations
					ON salesorders.fromstkloc=locations.loccode
				INNER JOIN locationusers
					ON locationusers.loccode=locations.loccode
					AND locationusers.userid='" .  $_SESSION['UserID'] . "'
					AND locationusers.canview=1
				WHERE stockmaster.categoryid ='" . $_POST['CategoryID'] . "'
					AND orddate >='" . FormatDateForSQL($_POST['FromDate']) . "'
					AND orddate <='" . FormatDateForSQL($_POST['ToDate']) . "'";

} elseif ($_POST['CategoryID'] == 'All' and $_POST['Location'] != 'All') {
	$SQL = "SELECT salesorders.orderno,
					salesorders.debtorno,
					salesorders.branchcode,
					salesorders.customerref,
					salesorders.orddate,
					salesorders.fromstkloc,
					salesorders.printedpackingslip,
					salesorders.datepackingslipprinted,
					salesorderdetails.stkcode,
					stockmaster.description,
					stockmaster.units,
					stockmaster.decimalplaces,
					debtorsmaster.name,
					custbranch.brname,
					locations.locationname,
					SUM(salesorderdetails.quantity) AS totqty,
					SUM(salesorderdetails.qtyinvoiced) AS totqtyinvoiced
				FROM salesorders
				INNER JOIN salesorderdetails
					ON salesorders.orderno = salesorderdetails.orderno
				INNER JOIN stockmaster
					ON salesorderdetails.stkcode = stockmaster.stockid
				INNER JOIN debtorsmaster
					ON salesorders.debtorno=debtorsmaster.debtorno
				INNER JOIN custbranch
					ON custbranch.debtorno=salesorders.debtorno
					AND custbranch.branchcode=salesorders.branchcode
				INNER JOIN locations
					ON salesorders.fromstkloc=locations.loccode
				INNER JOIN locationusers
					ON locationusers.loccode=locations.loccode
					AND locationusers.userid='" .  $_SESSION['UserID'] . "'
					AND locationusers.canview=1
				WHERE salesorders.fromstkloc ='" . $_POST['Location'] . "'
					AND orddate >='" . FormatDateForSQL($_POST['FromDate']) . "'
					AND orddate <='" . FormatDateForSQL($_POST['ToDate']) . "'";

} elseif ($_POST['CategoryID'] != 'All' and $_POST['location'] != 'All') {

	$SQL = "SELECT salesorders.orderno,
					salesorders.debtorno,
					salesorders.branchcode,
					salesorders.customerref,
					salesorders.orddate,
					salesorders.fromstkloc,
					salesorderdetails.stkcode,
					stockmaster.description,
					stockmaster.units,
					stockmaster.decimalplaces,
					debtorsmaster.name,
					custbranch.brname,
					locations.locationname,
					SUM(salesorderdetails.quantity) AS totqty,
					SUM(salesorderdetails.qtyinvoiced) AS totqtyinvoiced
				FROM salesorders
				INNER JOIN salesorderdetails
					ON salesorders.orderno = salesorderdetails.orderno
				INNER JOIN stockmaster
					ON salesorderdetails.stkcode = stockmaster.stockid
				INNER JOIN debtorsmaster
					ON salesorders.debtorno=debtorsmaster.debtorno
				INNER JOIN custbranch
					ON custbranch.debtorno=salesorders.debtorno
					AND custbranch.branchcode=salesorders.branchcode
				INNER JOIN locations
					ON salesorders.fromstkloc=locations.loccode
				INNER JOIN locationusers
					ON locationusers.loccode=locations.loccode
					AND locationusers.userid='" .  $_SESSION['UserID'] . "'
					AND locationusers.canview=1
				WHERE stockmaster.categoryid ='" . $_POST['CategoryID'] . "'
					AND salesorders.fromstkloc ='" . $_POST['Location'] . "'
					AND orddate >='" . FormatDateForSQL($_POST['FromDate']) . "'
					AND orddate <='" . FormatDateForSQL($_POST['ToDate']) . "'";
}

if ($_SESSION['SalesmanLogin'] != '') {
	$SQL .= " AND salesorders.salesperson='" . $_SESSION['SalesmanLogin'] . "'";
}

$SQL .= " GROUP BY salesorders.orderno,
					salesorders.debtorno,
					salesorders.branchcode,
					salesorders.customerref,
					salesorders.orddate,
					salesorders.fromstkloc,
					salesorderdetails.stkcode,
					stockmaster.description,
					stockmaster.units,
					stockmaster.decimalplaces
			ORDER BY salesorders.orderno";

$Result = DB_query($SQL, '', '', false, false); //dont trap errors here

if (DB_error_no() != 0) {
	include('includes/header.inc');
	prnMsg(_('An error occurred getting the orders details'), '', _('Database Error'));
	if ($Debug == 1) {
		prnMsg(_('The SQL used to get the orders that failed was') . '<br />' . $SQL, '', _('Database Error'));
	}
	include('includes/footer.inc');
	exit;
} elseif (DB_num_rows($Result) == 0) {
	include('includes/header.inc');
	prnMsg(_('There were no orders found in the database within the period from') . ' ' . $_POST['FromDate'] . ' ' . _('to') . ' ' . $_POST['ToDate'] . '. ' . _('Please try again selecting a different date range'), 'warn');
	if ($Debug == 1) {
		prnMsg(_('The SQL that returned no rows was') . '<br />' . $SQL, '', _('Database Error'));
	}
	include('includes/footer.inc');
	exit;
}

include('includes/PDFOrdersInvoicedPageHeader.inc');

$OrderNo = 0;
/*initialise */
$AccumTotalInv = 0;
$AccumOrderTotal = 0;

while ($MyRow = DB_fetch_array($Result)) {

	if ($OrderNo != $MyRow['orderno']) {
		if ($AccumOrderTotal != 0) {
			$LeftOvers = $PDF->addTextWrap($Left_Margin + 250, $YPos, 120, $FontSize, _('Total Invoiced for order') . ' ' . $OrderNo, 'left');
			$LeftOvers = $PDF->addTextWrap($Left_Margin + 360, $YPos, 80, $FontSize, locale_number_format($AccumOrderTotal, $_SESSION['CompanyRecord']['decimalplaces']), 'right');
			$YPos -= ($line_height);
			$AccumOrderTotal = 0;
		}

		$PDF->line($XPos, $YPos, $Page_Width - $Right_Margin, $YPos);

		$YPos -= $line_height;
		/*Set up headings */
		/*draw a line */

		$LeftOvers = $PDF->addTextWrap($Left_Margin + 2, $YPos, 40, $FontSize, _('Order'), 'left');
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 40, $YPos, 150, $FontSize, _('Customer'), 'left');
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 190, $YPos, 110, $FontSize, _('Branch'), 'left');
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 300, $YPos, 60, $FontSize, _('Customer Ref'), 'left');
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 360, $YPos, 60, $FontSize, _('Ord Date'), 'left');
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 420, $YPos, 80, $FontSize, _('Location'), 'left');

		$YPos -= $line_height;

		/*draw a line */
		$PDF->line($XPos, $YPos, $Page_Width - $Right_Margin, $YPos);
		$PDF->line($XPos, $YPos - $line_height * 2, $XPos, $YPos + $line_height * 2);
		$PDF->line($Page_Width - $Right_Margin, $YPos - $line_height * 2, $Page_Width - $Right_Margin, $YPos + $line_height * 2);

		$YPos -= ($line_height);
		if ($YPos - (2 * $line_height) < $Bottom_Margin) {
			/*Then set up a new page */
			$PageNumber++;
			include('includes/PDFOrdersInvoicedPageHeader.inc');
		}
		/*end of new page header  */
	}

	if ($MyRow['orderno'] != $OrderNo or $NewPage) {

		$LeftOvers = $PDF->addTextWrap($Left_Margin + 2, $YPos, 40, $FontSize, $MyRow['orderno'], 'left');
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 40, $YPos, 150, $FontSize, html_entity_decode($MyRow['name']), 'left');
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 190, $YPos, 110, $FontSize, $MyRow['brname'], 'left');

		$LeftOvers = $PDF->addTextWrap($Left_Margin + 300, $YPos, 60, $FontSize, $MyRow['customerref'], 'left');
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 360, $YPos, 60, $FontSize, ConvertSQLDate($MyRow['orddate']), 'left');
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 420, $YPos, 80, $FontSize, $MyRow['locationname'], 'left');

		if (isset($PackingSlipPrinted)) {
			$LeftOvers = $PDF->addTextWrap($Left_Margin + 400, $YPos, 100, $FontSize, $PackingSlipPrinted, 'left');
		}

		$YPos -= ($line_height);
		$PDF->line($XPos, $YPos, $Page_Width - $Right_Margin, $YPos);
		$YPos -= ($line_height);

	}
	$OrderNo = $MyRow['orderno'];
	/*Set up the headings for the order */
	$LeftOvers = $PDF->addTextWrap($Left_Margin, $YPos, 60, $FontSize, _('Code'), 'left');
	$LeftOvers = $PDF->addTextWrap($Left_Margin + 60, $YPos, 120, $FontSize, _('Description'), 'left');
	$LeftOvers = $PDF->addTextWrap($Left_Margin + 180, $YPos, 60, $FontSize, _('Ordered'), 'right');
	$LeftOvers = $PDF->addTextWrap($Left_Margin + 240, $YPos, 60, $FontSize, _('Invoiced'), 'right');
	$LeftOvers = $PDF->addTextWrap($Left_Margin + 320, $YPos, 60, $FontSize, _('Outstanding'), 'left');
	$YPos -= ($line_height);
	$NewPage = false;

	$LeftOvers = $PDF->addTextWrap($Left_Margin, $YPos, 60, $FontSize, $MyRow['stkcode'], 'left');
	$LeftOvers = $PDF->addTextWrap($Left_Margin + 60, $YPos, 120, $FontSize, $MyRow['description'], 'left');
	$LeftOvers = $PDF->addTextWrap($Left_Margin + 180, $YPos, 60, $FontSize, locale_number_format($MyRow['totqty'], $MyRow['decimalplaces']), 'right');
	$LeftOvers = $PDF->addTextWrap($Left_Margin + 240, $YPos, 60, $FontSize, locale_number_format($MyRow['totqtyinvoiced'], $MyRow['decimalplaces']), 'right');

	if ($MyRow['totqty'] > $MyRow['totqtyinvoiced']) {
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 320, $YPos, 60, $FontSize, locale_number_format($MyRow['totqty'] - $MyRow['totqtyinvoiced'], $MyRow['decimalplaces']), 'right');
	} else {
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 320, $YPos, 60, $FontSize, _('Complete'), 'left');
	}

	$YPos -= ($line_height);
	if ($YPos - (2 * $line_height) < $Bottom_Margin) {
		/*Then set up a new page */
		$PageNumber++;
		include('includes/PDFOrdersInvoicedPageHeader.inc');
	}
	/*end of new page header  */


	/*OK now get the invoices where the item was charged */
	$SQL = "SELECT debtortrans.order_,
					systypes.typename,
					debtortrans.transno,
			 		stockmoves.price *(1-stockmoves.discountpercent) AS netprice,
					-stockmoves.qty AS quantity
				FROM debtortrans INNER JOIN stockmoves
					ON debtortrans.type = stockmoves.type
					AND debtortrans.transno=stockmoves.transno
					INNER JOIN systypes ON debtortrans.type=systypes.typeid
				WHERE debtortrans.order_ ='" . $OrderNo . "'
				AND stockmoves.stockid ='" . $MyRow['stkcode'] . "'";

	$InvoicesResult = DB_query($SQL);
	if (DB_num_rows($InvoicesResult) > 0) {
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 150, $YPos, 90, $FontSize, _('Transaction Number'), 'center');
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 240, $YPos, 60, $FontSize, _('Quantity'), 'center');
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 300, $YPos, 60, $FontSize, _('Price'), 'center');
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 380, $YPos, 60, $FontSize, _('Total'), 'centre');
		$YPos -= ($line_height);
	}

	while ($InvRow = DB_fetch_array($InvoicesResult)) {

		$ValueInvoiced = $InvRow['netprice'] * $InvRow['quantity'];

		$LeftOvers = $PDF->addTextWrap($Left_Margin + 150, $YPos, 90, $FontSize, $InvRow['typename'] . ' ' . $InvRow['transno'], 'left');
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 240, $YPos, 60, $FontSize, locale_number_format($InvRow['quantity'], $MyRow['decimalplaces']), 'right');
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 300, $YPos, 60, $FontSize, locale_number_format($InvRow['netprice'], $_SESSION['CompanyRecord']['decimalplaces']), 'right');
		$LeftOvers = $PDF->addTextWrap($Left_Margin + 360, $YPos, 80, $FontSize, locale_number_format($ValueInvoiced, $_SESSION['CompanyRecord']['decimalplaces']), 'right');

		$YPos -= ($line_height);

		if ($YPos - (2 * $line_height) < $Bottom_Margin) {
			/*Then set up a new page */
			$PageNumber++;
			include('includes/PDFOrdersInvoicedPageHeader.inc');
		}
		/*end of new page header  */
		$AccumOrderTotal += $ValueInvoiced;
		$AccumTotalInv += $ValueInvoiced;
	}


	$YPos -= ($line_height);
	if ($YPos - (2 * $line_height) < $Bottom_Margin) {
		/*Then set up a new page */
		$PageNumber++;
		include('includes/PDFOrdersInvoicedPageHeader.inc');
	}
	/*end of new page header  */
}
/* end of while there are invoiced orders to print */

$YPos -= ($line_height);
$LeftOvers = $PDF->addTextWrap($Left_Margin + 260, $YPos, 100, $FontSize, _('GRAND TOTAL INVOICED'), 'right');
$LeftOvers = $PDF->addTextWrap($Left_Margin + 360, $YPos, 80, $FontSize, locale_number_format($AccumTotalInv, $_SESSION['CompanyRecord']['decimalplaces']), 'right');
$YPos -= ($line_height);

$PDF->OutputD($_SESSION['DatabaseName'] . '_OrdersInvoiced_' . date('Y-m-d') . '.pdf');
$PDF->__destruct();
?>