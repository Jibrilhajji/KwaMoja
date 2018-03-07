<?php

/*	Please note that addTextWrap prints a font-size-height further down than
addText and other functions.*/

// $PageNumber is initialised in 0 by includes/PDFStarter.php.
$PageNumber++; // Increments $PageNumber before printing.
if ($PageNumber > 1) { // Inserts a page break if it is not the first page.
	$PDF->newPage();
}

// Prints company logo:
$XPos = $Page_Width / 2 - 140;
$PDF->Image(
	$_SESSION['LogoFile'],// Name of the file containing the image.
	301,// Abscissa from left border to the upper-left corner (LTR).
	$Page_Height -(520) -(60),// Ordinate from top border to the upper-left corner (LTR).
	0,// Width of the image in the page. If not specified or equal to zero, it is automatically calculated.
	60,// Height of the image in the page. If not specified or equal to zero, it is automatically calculated.
	''// Image format. If not specified, the type is inferred from the file extension.
);// Public function Image() in ~/includes/tcpdf/tcpdf.php.

// Prints 'Quotation' title:
$PDF->addTextWrap(0, $Page_Height - $Top_Margin - 18, $Page_Width, 18, _('Quotation'), 'center');

// Prints company info:
$XPos = $Page_Width / 2 + $Left_Margin;
$YPos = 720;
$FontSize = 12;
$PDF->addText($XPos, $YPos, $FontSize, $_SESSION['CompanyRecord']['coyname']);
$YPos -= $FontSize;
$FontSize = 10;
$PDF->addText($XPos, $YPos, $FontSize, $_SESSION['CompanyRecord']['regoffice1']);
$PDF->addText($XPos, $YPos - $FontSize * 1, $FontSize, $_SESSION['CompanyRecord']['regoffice2']);
$PDF->addText($XPos, $YPos - $FontSize * 2, $FontSize, $_SESSION['CompanyRecord']['regoffice3']);
$PDF->addText($XPos, $YPos - $FontSize * 3, $FontSize, $_SESSION['CompanyRecord']['regoffice4']);
$PDF->addText($XPos, $YPos - $FontSize * 4, $FontSize, $_SESSION['CompanyRecord']['regoffice5'] . ' ' . $_SESSION['CompanyRecord']['regoffice6']);
$PDF->addText($XPos, $YPos - $FontSize * 5, $FontSize, _('Ph') . ': ' . $_SESSION['CompanyRecord']['telephone'] . ' ' . _('Fax') . ': ' . $_SESSION['CompanyRecord']['fax']);
$PDF->addText($XPos, $YPos - $FontSize * 6, $FontSize, $_SESSION['CompanyRecord']['email']);

// Prints 'Delivery To' info:
$XPos = 46;
$YPos = 770;
$FontSize = 12;
$MyRow = array_map(html_entity_decode, $MyRow);
$line_height = 15;
$PDF->addText($XPos, $YPos + 10, $FontSize, _('Delivery To') . ':');
$PDF->addText($XPos, $YPos - 3, $FontSize, $MyRow['deliverto']);
$PDF->addText($XPos, $YPos - ($line_height * 1), $FontSize, $MyRow['deladd1']);
$PDF->addText($XPos, $YPos - ($line_height * 2), $FontSize, $MyRow['deladd2']);
$PDF->addText($XPos, $YPos - ($line_height * 3), $FontSize, $MyRow['deladd3'] . ' ' . $MyRow['deladd4'] . ' ' . $MyRow['deladd5']);

// Prints 'Quotation For' info:
$YPos -= 80;
$PDF->addText($XPos, $YPos, $FontSize, _('Quotation For') . ':');
$PDF->addText($XPos, $YPos - ($line_height * 1), $FontSize, $MyRow['name']);
$PDF->addText($XPos, $YPos - ($line_height * 2), $FontSize, $MyRow['address1']);
$PDF->addText($XPos, $YPos - ($line_height * 3), $FontSize, $MyRow['address2']);
$PDF->addText($XPos, $YPos - ($line_height * 4), $FontSize, $MyRow['address3'] . ' ' . $MyRow['address4'] . ' ' . $MyRow['address5']);

// Draws a box with round corners around 'Delivery To' info:
$XPos = 50;
$YPos += 25;
$PDF->RoundRectangle($XPos - 10, // RoundRectangle $XPos.
	$YPos + 60 + 10, // RoundRectangle $YPos.
	200 + 10 + 10, // RoundRectangle $Width.
	60 + 10 + 10, // RoundRectangle $Height.
	10, // RoundRectangle $RadiusX.
	10); // RoundRectangle $RadiusY.

// Draws a box with round corners around around 'Quotation For' info:
$YPos -= 90;
$PDF->RoundRectangle($XPos - 10, // RoundRectangle $XPos.
	$YPos + 60 + 10, // RoundRectangle $YPos.
	200 + 10 + 10, // RoundRectangle $Width.
	60 + 10 + 10, // RoundRectangle $Height.
	10, // RoundRectangle $RadiusX.
	10); // RoundRectangle $RadiusY.

// Prints quotation info:
$PDF->addTextWrap($Page_Width - $Right_Margin - 200, $Page_Height - $Top_Margin - $FontSize * 1, 200, $FontSize, _('Number') . ': ' . $_GET['QuotationNo'], 'right');
$PDF->addTextWrap($Page_Width - $Right_Margin - 200, $Page_Height - $Top_Margin - $FontSize * 2, 200, $FontSize, _('Your Ref') . ': ' . $MyRow['customerref'], 'right');
$PDF->addTextWrap($Page_Width - $Right_Margin - 200, $Page_Height - $Top_Margin - $FontSize * 3, 200, $FontSize, _('Date') . ': ' . ConvertSQLDate($MyRow['quotedate']), 'right');
$PDF->addTextWrap($Page_Width - $Right_Margin - 200, $Page_Height - $Top_Margin - $FontSize * 4, 200, $FontSize, _('Page') . ': ' . $PageNumber, 'right');

$FontSize = 10;

// Prints the currency name:
$PDF->addText($Page_Width / 2 + $Left_Margin, $YPos + 5, $FontSize, _('All amounts stated in') . ' ' . $MyRow['currcode'] . ' - ' . $MyRow['currency']);

// Prints table header:
$YPos -= 45;
$XPos = 40;
$LeftOvers = $PDF->addTextWrap($Left_Margin, $YPos, 100, $FontSize, _('Item Code'));
$LeftOvers = $PDF->addTextWrap(120, $YPos, 235, $FontSize, _('Item Description'));
$LeftOvers = $PDF->addTextWrap(180, $YPos, 85, $FontSize, _('Quantity'), 'right');
$LeftOvers = $PDF->addTextWrap(230, $YPos, 85, $FontSize, _('Price'), 'right');
$LeftOvers = $PDF->addTextWrap(280, $YPos, 85, $FontSize, _('Discount'), 'right');
$LeftOvers = $PDF->addTextWrap(330, $YPos, 85, $FontSize, _('Tax Class'), 'right');
$LeftOvers = $PDF->addTextWrap(400, $YPos, 85, $FontSize, _('Tax Amount'), 'right');
$LeftOvers = $PDF->addTextWrap($Page_Width - $Right_Margin - 90, $YPos, 90, $FontSize, _('Total'), 'right');

// Draws a box with round corners around line items:
$PDF->RoundRectangle($Left_Margin, // RoundRectangle $XPos.
	$YPos + $FontSize + 5, // RoundRectangle $YPos.
	$Page_Width - $Left_Margin - $Right_Margin, // RoundRectangle $Width.
	$YPos + $FontSize - $Bottom_Margin + 5, // RoundRectangle $Height.
	10, // RoundRectangle $RadiusX.
	10); // RoundRectangle $RadiusY.

// Line under table headings:
$LineYPos = $YPos - $FontSize - 1;
$PDF->line($Page_Width - $Right_Margin, $LineYPos, $Left_Margin, $LineYPos);

$YPos -= $FontSize; // This is to use addTextWrap's $YPos instead of normal $YPos.

?>