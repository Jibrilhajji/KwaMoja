<?php

If (isset($_POST['PrintPDF']) AND isset($_POST['PayrollID'])) {

	include('config.php');
	include('includes/PDFStarter.php');
	include('includes/ConnectDB.php');
	include('includes/DateFunctions.php');
	include('includes/prlFunctions.php');

	$FontSize = 12;
	$pdf->addinfo('Title', _('Over the Counter'));
	$pdf->addinfo('Subject', _('Over the Counter'));

	$PageNumber = 0;
	$line_height = 12;

	$PayDesc = GetPayrollRow($_POST['PayrollID'], 1);
	$FromPeriod = GetPayrollRow($_POST['PayrollID'], 3);
	$ToPeriod = GetPayrollRow($_POST['PayrollID'], 4);

	$FontSize = 10;
	$line_height = 12;
	$FullName = '';
	$ATM = '';
	$PayAmount = 0;
	$PayAmountTotal = 0;
	include('includes/PDFCashPageHeader.php');

	$SQL = "SELECT employeeid,netpay
			FROM prlpayrolltrans
			WHERE prlpayrolltrans.payrollid='" . $_POST['PayrollID'] . "'";
	$PayResult = DB_query($SQL);
	if (DB_num_rows($PayResult) > 0) {
		while ($MyRow = DB_fetch_array($PayResult)) {
			$EmpID = $MyRow['employeeid'];
			$FullName = GetName($EmpID);
			$ATM = GetEmpRow($EmpID, 19);
			$PayAmount = $MyRow['netpay'];
			if (($PayAmount > 0) and ($ATM == '')) {
				$PayAmountTotal += $PayAmount;
				$FontSize = 8;
				$pdf->selectFont('./fonts/Helvetica.afm');
				$LeftOvers = $pdf->addTextWrap($Left_Margin, $YPos, 150, $FontSize, $FullName);
				$LeftOvers = $pdf->addTextWrap($Left_Margin + 410, $YPos, 50, $FontSize, number_format($PayAmount, 2), 'right');
				$YPos -= $line_height;
				if ($YPos < ($Bottom_Margin)) {
					include('includes/PDFCashPageHeader.php');
				}
			}
		}
	}
	$LeftOvers = $pdf->line($Page_Width - $Right_Margin, $YPos, $Left_Margin, $YPos);
	$YPos -= (2 * $line_height);
	$LeftOvers = $pdf->addTextWrap($Left_Margin, $YPos, 150, $FontSize, 'Grand Total');
	$LeftOvers = $pdf->addTextWrap($Left_Margin + 410, $YPos, 50, $FontSize, number_format($PayAmountTotal, 2), 'right');
	$LeftOvers = $pdf->line($Page_Width - $Right_Margin, $YPos, $Left_Margin, $YPos);

	$buf = $pdf->output();
	$len = strlen($buf);

	header('Content-type: application/pdf');
	header("Content-Length: $len");
	header('Content-Disposition: inline; filename=CashListing.pdf');
	header('Expires: 0');
	header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
	header('Pragma: public');

	$pdf->stream();

} elseif (isset($_POST['ShowPR'])) {
	include('includes/session.php');
	$Title = _('Bank Transmittal Listing');
	include('includes/header.php');
	echo 'Use PrintPDF instead';
	echo '<br /><a href="' . $RootPath . '/index.php">' . _('Back to the menu') . '</a>';
	include('includes/footer.php');
	exit;
} else {
	/*The option to print PDF was not hit */

	include('includes/session.php');
	$Title = _('Over the Counter Listing');
	include('includes/header.php');

	echo '<form method="POST" action="' . $_SERVER['PHP_SELF'] . '?">';
	echo '<table><td><td>' . _('Select Payroll:') . '</td><td><select Name="PayrollID">';
	DB_data_seek($Result, 0);
	$SQL = 'SELECT payrollid, payrolldesc FROM prlpayrollperiod';
	$Result = DB_query($SQL);
	while ($MyRow = DB_fetch_array($Result)) {
		if ($MyRow['payrollid'] == isset($_POST['PayrollID'])) {
			echo '<option selected="selected" value=';
		} else {
			echo '<option value=';
		}
		echo $MyRow['payrollid'] . '>' . $MyRow['payrolldesc'];
	} //end while loop
	echo '</select></td></tr>';
	echo "</table><p><input type='Submit' name='ShowPR' value='" . _('Show Over the Counter Listing') . "'>";
	echo "<p><input type='Submit' name='PrintPDF' value='" . _('PrintPDF') . "'>";

	include('includes/footer.php');
}
/*end of else not PrintPDF */


?>