<?php

include('includes/session.php');
$Title = _('Stock On Hand By Date');
include('includes/header.php');

echo '<p class="page_title_text" >
		<img src="' . $RootPath . '/css/' . $_SESSION['Theme'] . '/images/inventory.png" title="' . _('Inventory') . '" alt="" /><b>' . $Title . '</b>
	</p>';

echo '<form action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '" method="post">';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';

$SQL = "SELECT categoryid, categorydescription FROM stockcategory";
$ResultStkLocs = DB_query($SQL);

echo '<table class="selection">
	<tr>
		<td>' . _('For Stock Category') . ':</td>
		<td>
			<select required="required" name="StockCategory">
				<option value="All">' . _('All') . '</option>';

while ($MyRow = DB_fetch_array($ResultStkLocs)) {
	if (isset($_POST['StockCategory']) and $_POST['StockCategory'] != 'All') {
		if ($MyRow['categoryid'] == $_POST['StockCategory']) {
			echo '<option selected="selected" value="' . $MyRow['categoryid'] . '">' . $MyRow['categorydescription'] . '</option>';
		} else {
			echo '<option value="' . $MyRow['categoryid'] . '">' . $MyRow['categorydescription'] . '</option>';
		}
	} else {
		echo '<option value="' . $MyRow['categoryid'] . '">' . $MyRow['categorydescription'] . '</option>';
	}
}
echo '</select></td>';

$SQL = "SELECT locationname,
				locations.loccode
			FROM locations
			INNER JOIN locationusers
				ON locationusers.loccode=locations.loccode
				AND locationusers.userid='" .  $_SESSION['UserID'] . "'
				AND locationusers.canview=1";

$ResultStkLocs = DB_query($SQL);

echo '<td>' . _('For Stock Location') . ':</td>
	<td><select required="required" name="StockLocation"> ';

while ($MyRow = DB_fetch_array($ResultStkLocs)) {
	if (isset($_POST['StockLocation']) and $_POST['StockLocation'] != 'All') {
		if ($MyRow['loccode'] == $_POST['StockLocation']) {
			echo '<option selected="selected" value="' . $MyRow['loccode'] . '">' . $MyRow['locationname'] . '</option>';
		} else {
			echo '<option value="' . $MyRow['loccode'] . '">' . $MyRow['locationname'] . '</option>';
		}
	} elseif ($MyRow['loccode'] == $_SESSION['UserStockLocation']) {
		echo '<option selected="selected" value="' . $MyRow['loccode'] . '">' . $MyRow['locationname'] . '</option>';
		$_POST['StockLocation'] = $MyRow['loccode'];
	} else {
		echo '<option value="' . $MyRow['loccode'] . '">' . $MyRow['locationname'] . '</option>';
	}
}
echo '</select></td>';

if (!isset($_POST['OnHandDate'])) {
	$_POST['OnHandDate'] = Date($_SESSION['DefaultDateFormat'], Mktime(0, 0, 0, Date('m'), 0, Date('y')));
}

echo '<td>' . _('On-Hand On Date') . ':</td>
	<td><input type="text" class="date" alt="' . $_SESSION['DefaultDateFormat'] . '" name="OnHandDate" size="12" required="required" maxlength="10" value="' . $_POST['OnHandDate'] . '" /></td></tr>';
echo '<tr>
		<td colspan="6">
		<div class="centre">
		<input type="submit" name="ShowStatus" value="' . _('Show Stock Status') . '" />
		</div></td>
	</tr>
	</table>
	</form>';

$TotalQuantity = 0;

if (isset($_POST['ShowStatus']) and is_date($_POST['OnHandDate'])) {
	if ($_POST['StockCategory'] == 'All') {
		$SQL = "SELECT stockid,
						 description,
						 decimalplaces
					 FROM stockmaster
					 WHERE (mbflag='M' OR mbflag='B')";
	} else {
		$SQL = "SELECT stockid,
						description,
						decimalplaces
					 FROM stockmaster
					 WHERE categoryid = '" . $_POST['StockCategory'] . "'
					 AND (mbflag='M' OR mbflag='B')";
	}

	$ErrMsg = _('The stock items in the category selected cannot be retrieved because');
	$DbgMsg = _('The SQL that failed was');

	$StockResult = DB_query($SQL, $ErrMsg, $DbgMsg);

	$SQLOnHandDate = FormatDateForSQL($_POST['OnHandDate']);

	echo '<table class="selection">
			<tr>
				<th>' . _('Item Code') . '</th>
				<th>' . _('Description') . '</th>
				<th>' . _('Quantity On Hand') . '</th>
				<th>' . _('Cost per Unit') . '</th>
				<th>' . _('Total Value') . '</th>
			</tr>';

	while ($MyRows = DB_fetch_array($StockResult)) {

		$SQL = "SELECT stockid,
						newqoh
					FROM stockmoves
					WHERE stockmoves.trandate <= '" . $SQLOnHandDate . "'
						AND stockid = '" . $MyRows['stockid'] . "'
						AND loccode = '" . $_POST['StockLocation'] . "'
					ORDER BY stkmoveno DESC LIMIT 1";

		$ErrMsg = _('The stock held as at') . ' ' . $_POST['OnHandDate'] . ' ' . _('could not be retrieved because');

		$LocStockResult = DB_query($SQL, $ErrMsg);

		$NumRows = DB_num_rows($LocStockResult);

		$k = 0; //row colour counter

		while ($LocQtyRow = DB_fetch_array($LocStockResult)) {

			if ($k == 1) {
				echo '<tr class="OddTableRows">';
				$k = 0;
			} else {
				echo '<tr class="EvenTableRows">';
				$k = 1;
			}

			$CostSQL = "SELECT stockcosts.materialcost+stockcosts.labourcost+stockcosts.overheadcost AS cost
							FROM stockcosts
							WHERE stockcosts.costfrom<='" . $SQLOnHandDate . "'
								AND stockid = '" . $MyRows['stockid'] . "'
							ORDER BY costfrom DESC
							LIMIT 1";
			$CostResult = DB_query($CostSQL);
			if (DB_num_rows($CostResult) == 0) {
				$CostSQL = "SELECT stockcosts.materialcost+stockcosts.labourcost+stockcosts.overheadcost AS cost
								FROM stockcosts
								WHERE stockid = '" . $MyRows['stockid'] . "'
								ORDER BY costfrom DESC
								LIMIT 1";
				$CostResult = DB_query($CostSQL);
				$CostRow = DB_fetch_array($CostResult);
			} else {
				$CostRow = DB_fetch_array($CostResult);
			}
			if ($NumRows == 0) {
				printf('<td><a target="_blank" href="' . $RootPath . '/StockStatus.php?%s">%s</a></td>
						<td>%s</td>
						<td class="number">%s</td>
						<td class="number">%s</td>
						<td class="number">%s</td></tr>', 'StockID=' . mb_strtoupper($MyRows['stockid']), mb_strtoupper($MyRows['stockid']), $MyRows['description'], 0, locale_number_format($CostRow['cost'], $_SESSION['CompanyRecord']['decimalplaces']), 0);
			} else {
				printf('<td><a target="_blank" href="' . $RootPath . '/StockStatus.php?%s">%s</a></td>
						<td>%s</td>
						<td class="number">%s</td>
						<td class="number">%s</td>
						<td class="number">%s</td></tr>', 'StockID=' . mb_strtoupper($MyRows['stockid']), mb_strtoupper($MyRows['stockid']), $MyRows['description'], locale_number_format($LocQtyRow['newqoh'], $MyRows['decimalplaces']), locale_number_format($CostRow['cost'], $_SESSION['CompanyRecord']['decimalplaces']), locale_number_format(($CostRow['cost'] * $LocQtyRow['newqoh']), $_SESSION['CompanyRecord']['decimalplaces']));

				$TotalQuantity += $LocQtyRow['newqoh'];
			}
			//end of page full new headings if
		}

	} //end of while loop
	echo '<tr>
			<td>' . _('Total Quantity') . ': ' . $TotalQuantity . '</td>
		</tr>
		</table>';
}

include('includes/footer.php');
?>