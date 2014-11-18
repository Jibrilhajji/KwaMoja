<?php

/* This function returns a list of the sales type abbreviations
 * currently setup on KwaMoja
 */

function GetSalesTypeList($user, $password) {
	$Errors = array();
	$db = db($user, $password);
	if (gettype($db) == 'integer') {
		$Errors[0] = NoAuthorisation;
		return $Errors;
	}
	$SQL = "SELECT typeabbrev FROM salestypes";
	$Result = api_DB_query($SQL);
	$i = 0;
	while ($MyRow = DB_fetch_array($Result)) {
		$SalesTypeList[$i] = $MyRow[0];
		++$i;
	}
	$Errors[0] = 0;
	$Errors[1] = $SalesTypeList;
	return $Errors;
}

/* This function takes as a parameter a sales type abbreviation
 * and returns an array containing the details of the selected
 * sales type.
 */

function GetSalesTypeDetails($salestype, $user, $password) {
	$Errors = array();
	$db = db($user, $password);
	if (gettype($db) == 'integer') {
		$Errors[0] = NoAuthorisation;
		return $Errors;
	}
	$Errors = VerifySalesType($salestype, sizeof($Errors), $Errors);
	if (sizeof($Errors) == 0) {
		$SQL = "SELECT * FROM salestypes WHERE typeabbrev='" . $salestype . "'";
		$Result = api_DB_query($SQL);
		$Errors[0] = 0;
		$Errors[1] = DB_fetch_array($Result);
		return $Errors;
	} else {
		return $Errors;
	}
}

/* This function takes as a parameter an array of sales type details
 * to be inserted into KwaMoja.
 */

function InsertSalesType($SalesTypeDetails, $user, $password) {
	$Errors = array();
	$db = db($user, $password);
	if (gettype($db) == 'integer') {
		$Errors[0] = NoAuthorisation;
		return $Errors;
	}

	$FieldNames = '';
	$FieldValues = '';
	foreach ($SalesTypeDetails as $Key => $Value) {
		$FieldNames .= $Key . ', ';
		$FieldValues .= '"' . $Value . '", ';
	}
	$SQL = "INSERT INTO salestypes ('" . mb_substr($FieldNames, 0, -2) . "')
				VALUES ('" . mb_substr($FieldValues, 0, -2) . "') ";
	if (sizeof($Errors) == 0) {
		$Result = DB_Query($SQL);
		if (DB_error_no() != 0) {
			$Errors[0] = DatabaseUpdateFailed;
		} else {
			$Errors[0] = 0;
		}
	}
	return $Errors;
}

?>