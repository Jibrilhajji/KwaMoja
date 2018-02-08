<?php
/* MRPPlannedPurchaseOrders.php - Report of purchase parts that MRP has determined should have
 * purchase orders created for them
*/

include ('includes/session.php');

if (!DB_table_exists('mrprequirements')) {
	$Title = _('MRP error');
	include ('includes/header.php');
	echo '<br />';
	prnMsg(_('The MRP calculation must be run before you can run this report') . '<br />' . _('To run the MRP calculation click') . ' ' . '<a href=' . $RootPath . '/MRP.php>' . _('here') . '</a>', 'error');
	include ('includes/footer.php');
	exit;
}
if (isset($_POST['PrintPDF'])) {

	include ('includes/PDFStarter.php');
	$PDF->addInfo('Title', _('MRP Planned Purchase Orders Report'));
	$PDF->addInfo('Subject', _('MRP Planned Purchase Orders'));
	$FontSize = 9;
	$PageNumber = 1;
	$line_height = 12;

	$Xpos = $Left_Margin + 1;
	$WhereDate = ' ';
	$ReportDate = ' ';
	if (is_date($_POST['cutoffdate'])) {
		$FormatDate = FormatDateForSQL($_POST['cutoffdate']);
		$WhereDate = " AND duedate <= '" . $FormatDate . "' ";
		$ReportDate = ' ' . _('Through') . ' ' . $_POST['cutoffdate'];
	}

	if ($_POST['Consolidation'] == 'None') {
		$SQL = "SELECT mrpplannedorders.*,
					   stockmaster.stockid,
					   stockmaster.description,
					   stockmaster.mbflag,
					   stockmaster.decimalplaces,
					   stockmaster.actualcost,
					   (stockcosts.materialcost + stockcosts.labourcost + stockcosts.overheadcost ) as computedcost
				FROM mrpplannedorders
				INNER JOIN stockmaster
					ON mrpplannedorders.part = stockmaster.stockid
				LEFT JOIN stockcosts
					ON stockmaster.stockid=stockcosts.stockid
					AND stockcosts.succeeded=0
				WHERE stockmaster.mbflag = 'M' " . $WhereDate . "
				 AND stockmaster.mbflag IN ('B','P')
				ORDER BY mrpplannedorders.part,mrpplannedorders.duedate";
	} elseif ($_POST['Consolidation'] == 'Weekly') {
		$SQL = "SELECT mrpplannedorders.part,
					   SUM(mrpplannedorders.supplyquantity) as supplyquantity,
					   TRUNCATE(((TO_DAYS(duedate) - TO_DAYS(CURRENT_DATE)) / 7),0) AS weekindex,
					   MIN(mrpplannedorders.duedate) as duedate,
					   MIN(mrpplannedorders.mrpdate) as mrpdate,
					   COUNT(*) AS consolidatedcount,
					   stockmaster.stockid,
					   stockmaster.description,
					   stockmaster.mbflag,
					   stockmaster.decimalplaces,
					   stockmaster.actualcost,
					   (stockcosts.materialcost + stockcosts.labourcost + stockcosts.overheadcost ) as computedcost
				FROM mrpplannedorders
				INNER JOIN stockmaster
					ON mrpplannedorders.part = stockmaster.stockid
				LEFT JOIN stockcosts
					ON stockmaster.stockid=stockcosts.stockid
					AND stockcosts.succeeded=0
				WHERE stockmaster.mbflag = 'M' " . $WhereDate . "
				GROUP BY mrpplannedorders.part,
						 weekindex,
						 stockmaster.stockid,
						 stockmaster.description,
						 stockmaster.mbflag,
						 stockmaster.decimalplaces,
						 stockmaster.actualcost,
					   stockcosts.materialcost,
					   stockcosts.labourcost,
					   stockcosts.overheadcost,
					   computedcost
				ORDER BY mrpplannedorders.part,weekindex";
	} else { // This else consolidates by month
		$SQL = "SELECT mrpplannedorders.part,
					   SUM(mrpplannedorders.supplyquantity) as supplyquantity,
					   EXTRACT(YEAR_MONTH from duedate) AS yearmonth,
					   MIN(mrpplannedorders.duedate) as duedate,
					   MIN(mrpplannedorders.mrpdate) as mrpdate,
					   COUNT(*) AS consolidatedcount,
					   stockmaster.stockid,
					   stockmaster.description,
					   stockmaster.mbflag,
					   stockmaster.decimalplaces,
					   stockmaster.actualcost,
					   (stockcosts.materialcost + stockcosts.labourcost + stockcosts.overheadcost ) as computedcost
				FROM mrpplannedorders
				INNER JOIN stockmaster
					ON mrpplannedorders.part = stockmaster.stockid
				LEFT JOIN stockcosts
					ON stockmaster.stockid=stockcosts.stockid
					AND stockcosts.succeeded=0
				WHERE stockmaster.mbflag = 'M' " . $WhereDate . "
				GROUP BY mrpplannedorders.part,
						 yearmonth,
						 stockmaster.stockid,
						 stockmaster.description,
						 stockmaster.mbflag,
						 stockmaster.decimalplaces,
						 stockmaster.actualcost,
					   stockcosts.materialcost,
					   stockcosts.labourcost,
					   stockcosts.overheadcost,
					   computedcost
				ORDER BY mrpplannedorders.part,yearmonth ";
	}
	$Result = DB_query($SQL, '', '', false, true);

	if (DB_error_no() != 0) {
		$Title = _('MRP Planned Purchase Orders') . ' - ' . _('Problem Report');
		include ('includes/header.php');
		prnMsg(_('The MRP planned purchase orders could not be retrieved by the SQL because') . ' ' . DB_error_msg(), 'error');
		echo '<br /><a href="' . $RootPath . '/index.php">' . _('Back to the menu') . '</a>';
		if ($Debug == 1) {
			echo '<br />' . $SQL;
		}
		include ('includes/footer.php');
		exit;
	}
	if (DB_num_rows($Result) == 0) { //then there is nothing to print
		$Title = _('Print MRP Planned Purchase Orders Error');
		include ('includes/header.php');
		prnMsg(_('There were no items with planned purchase orders'), 'info');
		echo '<br /><a href="' . $RootPath . '/index.php">' . _('Back to the menu') . '</a>';
		include ('includes/footer.php');
		exit;
	}

	PrintHeader($PDF, $YPos, $PageNumber, $Page_Height, $Top_Margin, $Left_Margin, $Page_Width, $Right_Margin, $_POST['Consolidation'], $ReportDate);

	$Total_Shortage = 0;
	$Partctr = 0;
	$fill = false;
	$PDF->SetFillColor(224, 235, 255); // Defines color to make alternating lines highlighted
	$FontSize = 8;
	$HoldPart = ' ';
	$HoldDescription = ' ';
	$HoldMBFlag = ' ';
	$HoldCost = ' ';
	$HoldDecimalPlaces = 0;
	$TotalPartQty = 0;
	$TotalPartCost = 0;
	$TotalExtCost = 0;

	while ($MyRow = DB_fetch_array($Result)) {
		$YPos-= $line_height;

		// Print information on part break
		if ($Partctr > 0 and $HoldPart != $MyRow['part']) {
			$PDF->addTextWrap(50, $YPos, 130, $FontSize, $HoldDescription, '', 0, $fill);
			$PDF->addTextWrap(180, $YPos, 50, $FontSize, _('Unit Cost') . ': ', 'center', 0, $fill);
			$PDF->addTextWrap(220, $YPos, 40, $FontSize, locale_number_format($HoldCost, $_SESSION['CompanyRecord']['decimalplaces']), 'right', 0, $fill);
			$PDF->addTextWrap(260, $YPos, 50, $FontSize, locale_number_format($TotalPartQty, $HoldDecimalPlaces), 'right', 0, $fill);
			$PDF->addTextWrap(310, $YPos, 60, $FontSize, locale_number_format($TotalPartCost, $_SESSION['CompanyRecord']['decimalplaces']), 'right', 0, $fill);
			$PDF->addTextWrap(370, $YPos, 30, $FontSize, _('M/B') . ': ', 'right', 0, $fill);
			$PDF->addTextWrap(400, $YPos, 15, $FontSize, $HoldMBFlag, 'right', 0, $fill);
			// Get and print supplier info for part
			list($LastDate, $LastSupplier, $PreferredSupplier) = GetPartInfo($HoldPart);
			$Displaydate = $LastDate;
			if (!is_date($LastDate)) {
				$Displaydate = ' ';
			}
			$YPos-= $line_height;
			$PDF->addTextWrap(50, $YPos, 80, $FontSize, _('Last Purchase Date') . ': ', 'left', 0, $fill);
			$PDF->addTextWrap(130, $YPos, 60, $FontSize, $Displaydate, 'left', 0, $fill);
			$PDF->addTextWrap(190, $YPos, 60, $FontSize, _('Supplier') . ': ', 'left', 0, $fill);
			$PDF->addTextWrap(250, $YPos, 60, $FontSize, $LastSupplier, 'left', 0, $fill);
			$PDF->addTextWrap(310, $YPos, 120, $FontSize, _('Preferred Supplier') . ': ', 'left', 0, $fill);
			$PDF->addTextWrap(430, $YPos, 60, $FontSize, $PreferredSupplier, 'left', 0, $fill);
			$TotalPartCost = 0;
			$TotalPartQty = 0;
			$YPos-= (2 * $line_height);

			// Use to alternate between lines with transparent and painted background
			if ($_POST['Fill'] == 'yes') {
				$fill = !$fill;
			}
		}

		// Parameters for addTextWrap are defined in /includes/class.pdf.php
		// 1) X position 2) Y position 3) Width
		// 4) Height 5) Text 6) Alignment 7) Border 8) Fill - True to use SetFillColor
		// and False to set to transparent
		$FormatedSupDueDate = ConvertSQLDate($MyRow['duedate']);
		$FormatedSupMRPDate = ConvertSQLDate($MyRow['mrpdate']);
		$extcost = $MyRow['supplyquantity'] * $MyRow['computedcost'];
		$PDF->addTextWrap($Left_Margin, $YPos, 110, $FontSize, $MyRow['part'], '', 0, $fill);
		$PDF->addTextWrap(150, $YPos, 50, $FontSize, $FormatedSupDueDate, 'right', 0, $fill);
		$PDF->addTextWrap(200, $YPos, 60, $FontSize, $FormatedSupMRPDate, 'right', 0, $fill);
		$PDF->addTextWrap(260, $YPos, 50, $FontSize, locale_number_format($MyRow['supplyquantity'], $MyRow['decimalplaces']), 'right', 0, $fill);
		$PDF->addTextWrap(310, $YPos, 60, $FontSize, locale_number_format($extcost, $_SESSION['CompanyRecord']['decimalplaces']), 'right', 0, $fill);
		if ($_POST['Consolidation'] == 'None') {
			$PDF->addTextWrap(370, $YPos, 80, $FontSize, $MyRow['ordertype'], 'right', 0, $fill);
			$PDF->addTextWrap(450, $YPos, 80, $FontSize, $MyRow['orderno'], 'right', 0, $fill);
		} else {
			$PDF->addTextWrap(370, $YPos, 100, $FontSize, $MyRow['consolidatedcount'], 'right', 0, $fill);
		}
		$HoldDescription = $MyRow['description'];
		$HoldPart = $MyRow['part'];
		$HoldMBFlag = $MyRow['mbflag'];
		$HoldCost = $MyRow['computedcost'];
		$HoldDecimalPlaces = $MyRow['decimalplaces'];
		$TotalPartCost+= $extcost;
		$TotalPartQty+= $MyRow['supplyquantity'];

		$TotalExtCost+= $extcost;
		$Partctr++;

		if ($YPos < $Bottom_Margin + $line_height) {
			PrintHeader($PDF, $YPos, $PageNumber, $Page_Height, $Top_Margin, $Left_Margin, $Page_Width, $Right_Margin, $_POST['Consolidation'], $ReportDate);
		}

	}
	/*end while loop */
	// Print summary information for last part
	$YPos-= $line_height;
	$PDF->addTextWrap(50, $YPos, 130, $FontSize, $HoldDescription, '', 0, $fill);
	$PDF->addTextWrap(180, $YPos, 50, $FontSize, _('Unit Cost') . ': ', 'center', 0, $fill);
	$PDF->addTextWrap(220, $YPos, 40, $FontSize, locale_number_format($HoldCost, $_SESSION['CompanyRecord']['decimalplaces']), 'right', 0, $fill);
	$PDF->addTextWrap(260, $YPos, 50, $FontSize, locale_number_format($TotalPartQty, $HoldDecimalPlaces), 'right', 0, $fill);
	$PDF->addTextWrap(310, $YPos, 60, $FontSize, locale_number_format($TotalPartCost, $_SESSION['CompanyRecord']['decimalplaces']), 'right', 0, $fill);
	$PDF->addTextWrap(370, $YPos, 30, $FontSize, _('M/B') . ': ', 'right', 0, $fill);
	$PDF->addTextWrap(400, $YPos, 15, $FontSize, $HoldMBFlag, 'right', 0, $fill);
	// Get and print supplier info for part
	list($LastDate, $LastSupplier, $PreferredSupplier) = GetPartInfo($HoldPart);
	$Displaydate = $LastDate;
	if (!is_date($LastDate)) {
		$Displaydate = ' ';
	}
	$YPos-= $line_height;
	$PDF->addTextWrap(50, $YPos, 80, $FontSize, _('Last Purchase Date') . ': ', 'left', 0, $fill);
	$PDF->addTextWrap(130, $YPos, 60, $FontSize, $Displaydate, 'left', 0, $fill);
	$PDF->addTextWrap(190, $YPos, 60, $FontSize, _('Supplier') . ': ', 'left', 0, $fill);
	$PDF->addTextWrap(250, $YPos, 60, $FontSize, $LastSupplier, 'left', 0, $fill);
	$PDF->addTextWrap(310, $YPos, 120, $FontSize, _('Preferred Supplier') . ': ', 'left', 0, $fill);
	$PDF->addTextWrap(430, $YPos, 60, $FontSize, $PreferredSupplier, 'left', 0, $fill);
	$FontSize = 8;
	$YPos-= (2 * $line_height);

	if ($YPos < $Bottom_Margin + $line_height) {
		PrintHeader($PDF, $YPos, $PageNumber, $Page_Height, $Top_Margin, $Left_Margin, $Page_Width, $Right_Margin, $_POST['Consolidation'], $ReportDate);
		// include('includes/MRPPlannedPurchaseOrdersPageHeader.php');
		
	}
	/*Print out the grand totals */
	$PDF->addTextWrap($Left_Margin, $YPos, 120, $FontSize, _('Number of Purchase Orders') . ': ', 'left');
	$PDF->addTextWrap(150, $YPos, 30, $FontSize, $Partctr, 'left');
	$PDF->addTextWrap(200, $YPos, 100, $FontSize, _('Total Extended Cost') . ': ', 'right');
	$DisplayTotalVal = locale_number_format($TotalExtCost, $_SESSION['CompanyRecord']['decimalplaces']);
	$PDF->addTextWrap(310, $YPos, 60, $FontSize, $DisplayTotalVal, 'right');

	$PDF->OutputD($_SESSION['DatabaseName'] . '_MRP_Planned_Purchase_Orders_' . Date('Y-m-d') . '.pdf');
	$PDF->__destruct();

} else {
	/*The option to print PDF was not hit so display form */

	$Title = _('MRP Planned Purchase Orders Reporting');
	include ('includes/header.php');
	echo '<p class="page_title_text">
			<img src="', $RootPath, '/css/', $_SESSION['Theme'], '/images/inventory.png" title="', _('Inventory'), '" alt="" />', ' ', $Title, '
		</p>';

	echo '<form action="', htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8'), '" method="post">';
	echo '<input type="hidden" name="FormID" value="', $_SESSION['FormID'], '" />';
	echo '<fieldset>
			<legend>', _('Select Report Criteria'), '</legend>
				<field>
					<label for="Consolidation">', _('Consolidation'), ':</label>
					<select required="required" autofocus="autofocus" name="Consolidation">
						<option selected="selected" value="None">', _('None'), '</option>
						<option value="Weekly">', _('Weekly'), '</option>
						<option value="Monthly">', _('Monthly'), '</option>
					</select>
					<fieldhelp>', _('Select the method to use for consolidating orders'), '</fieldhelp>
				</field>
				<field>
					<label for="Fill">', _('Print Option'), ':</label>
					<select name="Fill">
						<option selected="selected" value="yes">', _('Print With Alternating Highlighted Lines'), '</option>
						<option value="no">', _('Plain Print'), '</option>
					</select>
					<fieldhelp>', _('Use colour for alternate rows to help readability of the report.'), '</fieldhelp>
				</field>
				<field>
					<label for="cutoffdate">', _('Cut Off Date'), ':</label>
					<input type ="text" required="required" class="date" name="cutoffdate" size="10" value="', date($_SESSION['DefaultDateFormat']), '" />
					<fieldhelp>', _('The cut off date to use for planned orders.'), '</fieldhelp>
				</field>
			</fieldset>
			<div class="centre">
				<input type="submit" name="PrintPDF" value="', _('Print PDF'), '" />
			</div>
		</form>';

	include ('includes/footer.php');

}
/*end of else not PrintPDF */

function PrintHeader(&$PDF, &$YPos, &$PageNumber, $Page_Height, $Top_Margin, $Left_Margin, $Page_Width, $Right_Margin, $consolidation, $ReportDate) {

	/*PDF page header for MRP Planned Work Orders report */
	if ($PageNumber > 1) {
		$PDF->newPage();
	}
	$line_height = 12;
	$FontSize = 9;
	$YPos = $Page_Height - $Top_Margin;

	$PDF->addTextWrap($Left_Margin, $YPos, 300, $FontSize, $_SESSION['CompanyRecord']['coyname']);

	$YPos-= $line_height;

	$PDF->addTextWrap($Left_Margin, $YPos, 150, $FontSize, _('MRP Planned Purchase Orders Report'));
	$PDF->addTextWrap(190, $YPos, 100, $FontSize, $ReportDate);
	$PDF->addTextWrap($Page_Width - $Right_Margin - 150, $YPos, 160, $FontSize, _('Printed') . ': ' . Date($_SESSION['DefaultDateFormat']) . '   ' . _('Page') . ' ' . $PageNumber, 'left');
	$YPos-= $line_height;
	if ($consolidation == 'None') {
		$displayconsolidation = _('None');
	} elseif ($consolidation == 'Weekly') {
		$displayconsolidation = _('Weekly');
	} else {
		$displayconsolidation = _('Monthly');
	}
	$PDF->addTextWrap($Left_Margin, $YPos, 65, $FontSize, _('Consolidation') . ': ');
	$PDF->addTextWrap(110, $YPos, 40, $FontSize, $displayconsolidation);

	$YPos-= (2 * $line_height);

	/*set up the headings */
	$Xpos = $Left_Margin + 1;

	$PDF->addTextWrap($Xpos, $YPos, 150, $FontSize, _('Part Number'), 'left');
	$PDF->addTextWrap(150, $YPos, 50, $FontSize, _('Due Date'), 'right');
	$PDF->addTextWrap(200, $YPos, 60, $FontSize, _('MRP Date'), 'right');
	$PDF->addTextWrap(260, $YPos, 50, $FontSize, _('Quantity'), 'right');
	$PDF->addTextWrap(310, $YPos, 60, $FontSize, _('Ext. Cost'), 'right');
	if ($consolidation == 'None') {
		$PDF->addTextWrap(370, $YPos, 80, $FontSize, _('Source Type'), 'right');
		$PDF->addTextWrap(450, $YPos, 80, $FontSize, _('Source Order'), 'right');
	} else {
		$PDF->addTextWrap(370, $YPos, 100, $FontSize, _('Consolidation Count'), 'right');
	}

	$FontSize = 8;
	$YPos = $YPos - (2 * $line_height);
	$PageNumber++;
} // End of PrintHeader function
function GetPartInfo($part) {
	// Get last purchase order date and supplier for part, and also preferred supplier
	// Printed when there is a part break
	$SQL = "SELECT orddate as maxdate,
				   purchorders.orderno
			FROM purchorders INNER JOIN purchorderdetails
			ON purchorders.orderno = purchorderdetails.orderno
			WHERE purchorderdetails.itemcode = '" . $part . "'
			ORDER BY orddate DESC LIMIT 1";
	$Result = DB_query($SQL);
	if (DB_num_rows($Result) > 0) {
		$MyRow = DB_fetch_array($Result);
		$PartInfo[] = ConvertSQLDate($MyRow['maxdate']);
		$OrderNo = $MyRow['orderno'];
		$SQL = "SELECT supplierno
				FROM purchorders
				WHERE purchorders.orderno = '" . $OrderNo . "'";
		$Result = DB_query($SQL);
		$MyRow = DB_fetch_array($Result);
		$PartInfo[] = $MyRow['supplierno'];
		$SQL = "SELECT supplierno
				FROM purchdata
				WHERE stockid = '" . $part . "'
				AND preferred='1'";
		$Result = DB_query($SQL);
		$MyRow = DB_fetch_array($Result);
		$PartInfo[] = $MyRow['supplierno'];
		return $PartInfo;
	} else {
		return array('', '', '');
	}

}

?>