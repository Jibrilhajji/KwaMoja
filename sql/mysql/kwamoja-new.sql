SET FOREIGN_KEY_CHECKS = 0;
-- MySQL dump 10.14  Distrib 10.0.0-MariaDB, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: kwamoja
-- ------------------------------------------------------
-- Server version	10.0.0-MariaDB-mariadb1~precise-log
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accountgroups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountgroups` (
  `groupname` char(30) NOT NULL DEFAULT '',
  `sectioninaccounts` int(11) NOT NULL DEFAULT '0',
  `pandl` tinyint(4) NOT NULL DEFAULT '1',
  `sequenceintb` smallint(6) NOT NULL DEFAULT '0',
  `parentgroupname` varchar(30) NOT NULL,
  PRIMARY KEY (`groupname`),
  KEY `SequenceInTB` (`sequenceintb`),
  KEY `sectioninaccounts` (`sectioninaccounts`),
  KEY `parentgroupname` (`parentgroupname`),
  CONSTRAINT `accountgroups_ibfk_1` FOREIGN KEY (`sectioninaccounts`) REFERENCES `accountsection` (`sectionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accountsection`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountsection` (
  `sectionid` int(11) NOT NULL DEFAULT '0',
  `sectionname` text NOT NULL,
  PRIMARY KEY (`sectionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `areas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areas` (
  `areacode` char(3) NOT NULL,
  `areadescription` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`areacode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assetmanager`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetmanager` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `serialno` varchar(30) NOT NULL DEFAULT '',
  `location` varchar(15) NOT NULL DEFAULT '',
  `cost` double NOT NULL DEFAULT '0',
  `depn` double NOT NULL DEFAULT '0',
  `datepurchased` date NOT NULL DEFAULT '0000-00-00',
  `disposalvalue` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audittrail`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audittrail` (
  `transactiondate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `userid` varchar(20) NOT NULL DEFAULT '',
  `querystring` text,
  KEY `UserID` (`userid`),
  CONSTRAINT `audittrail_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `www_users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bankaccounts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bankaccounts` (
  `accountcode` varchar(20) NOT NULL DEFAULT '0',
  `currcode` char(3) NOT NULL,
  `invoice` smallint(2) NOT NULL DEFAULT '0',
  `bankaccountcode` varchar(50) NOT NULL DEFAULT '',
  `bankaccountname` char(50) NOT NULL DEFAULT '',
  `bankaccountnumber` char(50) NOT NULL DEFAULT '',
  `bankaddress` char(50) DEFAULT NULL,
  PRIMARY KEY (`accountcode`),
  KEY `currcode` (`currcode`),
  KEY `BankAccountName` (`bankaccountname`),
  KEY `BankAccountNumber` (`bankaccountnumber`),
  CONSTRAINT `bankaccounts_ibfk_1` FOREIGN KEY (`accountcode`) REFERENCES `chartmaster` (`accountcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `banktrans`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banktrans` (
  `banktransid` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` smallint(6) NOT NULL DEFAULT '0',
  `transno` bigint(20) NOT NULL DEFAULT '0',
  `bankact` varchar(20) NOT NULL DEFAULT '0',
  `ref` varchar(50) NOT NULL DEFAULT '',
  `amountcleared` double NOT NULL DEFAULT '0',
  `exrate` double NOT NULL DEFAULT '1' COMMENT 'From bank account currency to payment currency',
  `functionalexrate` double NOT NULL DEFAULT '1' COMMENT 'Account currency to functional currency',
  `transdate` date NOT NULL DEFAULT '0000-00-00',
  `banktranstype` varchar(30) NOT NULL DEFAULT '',
  `amount` double NOT NULL DEFAULT '0',
  `currcode` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`banktransid`),
  KEY `BankAct` (`bankact`,`ref`),
  KEY `TransDate` (`transdate`),
  KEY `TransType` (`banktranstype`),
  KEY `Type` (`type`,`transno`),
  KEY `CurrCode` (`currcode`),
  KEY `ref` (`ref`),
  KEY `ref_2` (`ref`),
  KEY `ref_3` (`ref`),
  KEY `ref_4` (`ref`),
  KEY `ref_5` (`ref`),
  KEY `ref_6` (`ref`),
  KEY `ref_7` (`ref`),
  KEY `ref_8` (`ref`),
  KEY `ref_9` (`ref`),
  KEY `ref_10` (`ref`),
  CONSTRAINT `banktrans_ibfk_1` FOREIGN KEY (`type`) REFERENCES `systypes` (`typeid`),
  CONSTRAINT `banktrans_ibfk_2` FOREIGN KEY (`bankact`) REFERENCES `bankaccounts` (`accountcode`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bom`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bom` (
  `parent` char(20) NOT NULL DEFAULT '',
  `component` char(20) NOT NULL DEFAULT '',
  `workcentreadded` char(5) NOT NULL DEFAULT '',
  `loccode` char(5) NOT NULL DEFAULT '',
  `effectiveafter` date NOT NULL DEFAULT '0000-00-00',
  `effectiveto` date NOT NULL DEFAULT '9999-12-31',
  `quantity` double NOT NULL DEFAULT '1',
  `autoissue` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`parent`,`component`,`workcentreadded`,`loccode`),
  KEY `Component` (`component`),
  KEY `EffectiveAfter` (`effectiveafter`),
  KEY `EffectiveTo` (`effectiveto`),
  KEY `LocCode` (`loccode`),
  KEY `Parent` (`parent`,`effectiveafter`,`effectiveto`,`loccode`),
  KEY `Parent_2` (`parent`),
  KEY `WorkCentreAdded` (`workcentreadded`),
  CONSTRAINT `bom_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `bom_ibfk_2` FOREIGN KEY (`component`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `bom_ibfk_3` FOREIGN KEY (`workcentreadded`) REFERENCES `workcentres` (`code`),
  CONSTRAINT `bom_ibfk_4` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chartdetails`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chartdetails` (
  `accountcode` varchar(20) NOT NULL DEFAULT '0',
  `period` smallint(6) NOT NULL DEFAULT '0',
  `budget` double NOT NULL DEFAULT '0',
  `actual` double NOT NULL DEFAULT '0',
  `bfwd` double NOT NULL DEFAULT '0',
  `bfwdbudget` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`accountcode`,`period`),
  KEY `Period` (`period`),
  CONSTRAINT `chartdetails_ibfk_1` FOREIGN KEY (`accountcode`) REFERENCES `chartmaster` (`accountcode`),
  CONSTRAINT `chartdetails_ibfk_2` FOREIGN KEY (`period`) REFERENCES `periods` (`periodno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chartmaster`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chartmaster` (
  `accountcode` varchar(20) NOT NULL DEFAULT '0',
  `accountname` char(50) NOT NULL DEFAULT '',
  `group_` char(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`accountcode`),
  KEY `AccountName` (`accountname`),
  KEY `Group_` (`group_`),
  CONSTRAINT `chartmaster_ibfk_1` FOREIGN KEY (`group_`) REFERENCES `accountgroups` (`groupname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cogsglpostings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cogsglpostings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area` char(3) NOT NULL DEFAULT '',
  `stkcat` varchar(6) NOT NULL DEFAULT '',
  `glcode` int(11) NOT NULL DEFAULT '0',
  `salestype` char(2) NOT NULL DEFAULT 'AN',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Area_StkCat` (`area`,`stkcat`,`salestype`),
  KEY `Area` (`area`),
  KEY `StkCat` (`stkcat`),
  KEY `GLCode` (`glcode`),
  KEY `SalesType` (`salestype`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `companies`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies` (
  `coycode` int(11) NOT NULL DEFAULT '1',
  `coyname` varchar(50) NOT NULL DEFAULT '',
  `gstno` varchar(20) NOT NULL DEFAULT '',
  `companynumber` varchar(20) NOT NULL DEFAULT '0',
  `regoffice1` varchar(40) NOT NULL DEFAULT '',
  `regoffice2` varchar(40) NOT NULL DEFAULT '',
  `regoffice3` varchar(40) NOT NULL DEFAULT '',
  `regoffice4` varchar(40) NOT NULL DEFAULT '',
  `regoffice5` varchar(20) NOT NULL DEFAULT '',
  `regoffice6` varchar(15) NOT NULL DEFAULT '',
  `telephone` varchar(25) NOT NULL DEFAULT '',
  `fax` varchar(25) NOT NULL DEFAULT '',
  `email` varchar(55) NOT NULL DEFAULT '',
  `currencydefault` varchar(4) NOT NULL DEFAULT '',
  `debtorsact` int(11) NOT NULL DEFAULT '70000',
  `pytdiscountact` int(11) NOT NULL DEFAULT '55000',
  `creditorsact` int(11) NOT NULL DEFAULT '80000',
  `payrollact` int(11) NOT NULL DEFAULT '84000',
  `grnact` int(11) NOT NULL DEFAULT '72000',
  `exchangediffact` int(11) NOT NULL DEFAULT '65000',
  `purchasesexchangediffact` int(11) NOT NULL DEFAULT '0',
  `retainedearnings` int(11) NOT NULL DEFAULT '90000',
  `gllink_debtors` tinyint(1) DEFAULT '1',
  `gllink_creditors` tinyint(1) DEFAULT '1',
  `gllink_stock` tinyint(1) DEFAULT '1',
  `freightact` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`coycode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `config`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `confname` varchar(35) NOT NULL DEFAULT '',
  `confvalue` text NOT NULL,
  PRIMARY KEY (`confname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contractbom`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contractbom` (
  `contractref` varchar(20) NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `workcentreadded` char(5) NOT NULL DEFAULT '',
  `quantity` double NOT NULL DEFAULT '1',
  PRIMARY KEY (`contractref`,`stockid`,`workcentreadded`),
  KEY `Stockid` (`stockid`),
  KEY `ContractRef` (`contractref`),
  KEY `WorkCentreAdded` (`workcentreadded`),
  CONSTRAINT `contractbom_ibfk_1` FOREIGN KEY (`workcentreadded`) REFERENCES `workcentres` (`code`),
  CONSTRAINT `contractbom_ibfk_3` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contractcharges`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contractcharges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contractref` varchar(20) NOT NULL,
  `transtype` smallint(6) NOT NULL DEFAULT '20',
  `transno` int(11) NOT NULL DEFAULT '0',
  `amount` double NOT NULL DEFAULT '0',
  `narrative` text NOT NULL,
  `anticipated` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `contractref` (`contractref`,`transtype`,`transno`),
  KEY `contractcharges_ibfk_2` (`transtype`),
  CONSTRAINT `contractcharges_ibfk_1` FOREIGN KEY (`contractref`) REFERENCES `contracts` (`contractref`),
  CONSTRAINT `contractcharges_ibfk_2` FOREIGN KEY (`transtype`) REFERENCES `systypes` (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contractreqts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contractreqts` (
  `contractreqid` int(11) NOT NULL AUTO_INCREMENT,
  `contractref` varchar(20) NOT NULL DEFAULT '0',
  `requirement` varchar(40) NOT NULL DEFAULT '',
  `quantity` double NOT NULL DEFAULT '1',
  `costperunit` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`contractreqid`),
  KEY `ContractRef` (`contractref`),
  CONSTRAINT `contractreqts_ibfk_1` FOREIGN KEY (`contractref`) REFERENCES `contracts` (`contractref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contracts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contracts` (
  `contractref` varchar(20) NOT NULL DEFAULT '',
  `contractdescription` text NOT NULL,
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `categoryid` varchar(6) NOT NULL DEFAULT '',
  `orderno` int(11) NOT NULL DEFAULT '0',
  `customerref` varchar(20) NOT NULL DEFAULT '',
  `margin` double NOT NULL DEFAULT '1',
  `wo` int(11) NOT NULL DEFAULT '0',
  `requireddate` date NOT NULL DEFAULT '0000-00-00',
  `drawing` varchar(50) NOT NULL DEFAULT '',
  `exrate` double NOT NULL DEFAULT '1',
  PRIMARY KEY (`contractref`),
  KEY `OrderNo` (`orderno`),
  KEY `CategoryID` (`categoryid`),
  KEY `Status` (`status`),
  KEY `WO` (`wo`),
  KEY `loccode` (`loccode`),
  KEY `DebtorNo` (`debtorno`,`branchcode`),
  CONSTRAINT `contracts_ibfk_1` FOREIGN KEY (`debtorno`, `branchcode`) REFERENCES `custbranch` (`debtorno`, `branchcode`),
  CONSTRAINT `contracts_ibfk_2` FOREIGN KEY (`categoryid`) REFERENCES `stockcategory` (`categoryid`),
  CONSTRAINT `contracts_ibfk_3` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currencies`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currencies` (
  `currency` char(20) NOT NULL DEFAULT '',
  `currabrev` char(3) NOT NULL DEFAULT '',
  `country` char(50) NOT NULL DEFAULT '',
  `hundredsname` char(15) NOT NULL DEFAULT 'Cents',
  `decimalplaces` tinyint(3) NOT NULL DEFAULT '2',
  `rate` double NOT NULL DEFAULT '1',
  PRIMARY KEY (`currabrev`),
  KEY `Country` (`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custallocns`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custallocns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amt` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `datealloc` date NOT NULL DEFAULT '0000-00-00',
  `transid_allocfrom` int(11) NOT NULL DEFAULT '0',
  `transid_allocto` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `DateAlloc` (`datealloc`),
  KEY `TransID_AllocFrom` (`transid_allocfrom`),
  KEY `TransID_AllocTo` (`transid_allocto`),
  CONSTRAINT `custallocns_ibfk_1` FOREIGN KEY (`transid_allocfrom`) REFERENCES `debtortrans` (`id`),
  CONSTRAINT `custallocns_ibfk_2` FOREIGN KEY (`transid_allocto`) REFERENCES `debtortrans` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custbranch`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custbranch` (
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `brname` varchar(40) NOT NULL DEFAULT '',
  `braddress1` varchar(40) NOT NULL DEFAULT '',
  `braddress2` varchar(40) NOT NULL DEFAULT '',
  `braddress3` varchar(40) NOT NULL DEFAULT '',
  `braddress4` varchar(50) NOT NULL DEFAULT '',
  `braddress5` varchar(20) NOT NULL DEFAULT '',
  `braddress6` varchar(40) NOT NULL DEFAULT '',
  `lat` float(10,6) NOT NULL DEFAULT '0.000000',
  `lng` float(10,6) NOT NULL DEFAULT '0.000000',
  `estdeliverydays` smallint(6) NOT NULL DEFAULT '1',
  `area` char(3) NOT NULL,
  `salesman` varchar(4) NOT NULL DEFAULT '',
  `fwddate` smallint(6) NOT NULL DEFAULT '0',
  `phoneno` varchar(20) NOT NULL DEFAULT '',
  `faxno` varchar(20) NOT NULL DEFAULT '',
  `contactname` varchar(30) NOT NULL DEFAULT '',
  `email` varchar(55) NOT NULL DEFAULT '',
  `defaultlocation` varchar(5) NOT NULL DEFAULT '',
  `taxgroupid` tinyint(4) NOT NULL DEFAULT '1',
  `defaultshipvia` int(11) NOT NULL DEFAULT '1',
  `deliverblind` tinyint(1) DEFAULT '1',
  `disabletrans` tinyint(4) NOT NULL DEFAULT '0',
  `brpostaddr1` varchar(40) NOT NULL DEFAULT '',
  `brpostaddr2` varchar(40) NOT NULL DEFAULT '',
  `brpostaddr3` varchar(30) NOT NULL DEFAULT '',
  `brpostaddr4` varchar(20) NOT NULL DEFAULT '',
  `brpostaddr5` varchar(20) NOT NULL DEFAULT '',
  `brpostaddr6` varchar(15) NOT NULL DEFAULT '',
  `specialinstructions` text NOT NULL,
  `custbranchcode` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`branchcode`,`debtorno`),
  KEY `BrName` (`brname`),
  KEY `DebtorNo` (`debtorno`),
  KEY `Salesman` (`salesman`),
  KEY `Area` (`area`),
  KEY `DefaultLocation` (`defaultlocation`),
  KEY `DefaultShipVia` (`defaultshipvia`),
  KEY `taxgroupid` (`taxgroupid`),
  CONSTRAINT `custbranch_ibfk_1` FOREIGN KEY (`debtorno`) REFERENCES `debtorsmaster` (`debtorno`),
  CONSTRAINT `custbranch_ibfk_2` FOREIGN KEY (`area`) REFERENCES `areas` (`areacode`),
  CONSTRAINT `custbranch_ibfk_3` FOREIGN KEY (`salesman`) REFERENCES `salesman` (`salesmancode`),
  CONSTRAINT `custbranch_ibfk_4` FOREIGN KEY (`defaultlocation`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `custbranch_ibfk_6` FOREIGN KEY (`defaultshipvia`) REFERENCES `shippers` (`shipper_id`),
  CONSTRAINT `custbranch_ibfk_7` FOREIGN KEY (`taxgroupid`) REFERENCES `taxgroups` (`taxgroupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custcontacts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custcontacts` (
  `contid` int(11) NOT NULL AUTO_INCREMENT,
  `debtorno` varchar(10) NOT NULL,
  `contactname` varchar(40) NOT NULL,
  `role` varchar(40) NOT NULL,
  `phoneno` varchar(20) NOT NULL,
  `notes` varchar(255) NOT NULL,
  `email` varchar(55) NOT NULL,
  PRIMARY KEY (`contid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custnotes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custnotes` (
  `noteid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `debtorno` varchar(10) NOT NULL DEFAULT '0',
  `href` varchar(100) NOT NULL,
  `note` text NOT NULL,
  `date` date NOT NULL DEFAULT '0000-00-00',
  `priority` varchar(20) NOT NULL,
  PRIMARY KEY (`noteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `debtorsmaster`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `debtorsmaster` (
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `name` varchar(40) NOT NULL DEFAULT '',
  `address1` varchar(40) NOT NULL DEFAULT '',
  `address2` varchar(40) NOT NULL DEFAULT '',
  `address3` varchar(40) NOT NULL DEFAULT '',
  `address4` varchar(50) NOT NULL DEFAULT '',
  `address5` varchar(20) NOT NULL DEFAULT '',
  `address6` varchar(40) NOT NULL DEFAULT '',
  `currcode` char(3) NOT NULL DEFAULT '',
  `salestype` char(2) NOT NULL DEFAULT '',
  `clientsince` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `holdreason` smallint(6) NOT NULL DEFAULT '0',
  `paymentterms` char(2) NOT NULL DEFAULT 'f',
  `discount` double NOT NULL DEFAULT '0',
  `pymtdiscount` double NOT NULL DEFAULT '0',
  `lastpaid` double NOT NULL DEFAULT '0',
  `lastpaiddate` datetime DEFAULT NULL,
  `creditlimit` double NOT NULL DEFAULT '1000',
  `invaddrbranch` tinyint(4) NOT NULL DEFAULT '0',
  `discountcode` char(2) NOT NULL DEFAULT '',
  `ediinvoices` tinyint(4) NOT NULL DEFAULT '0',
  `ediorders` tinyint(4) NOT NULL DEFAULT '0',
  `edireference` varchar(20) NOT NULL DEFAULT '',
  `editransport` varchar(5) NOT NULL DEFAULT 'email',
  `ediaddress` varchar(50) NOT NULL DEFAULT '',
  `ediserveruser` varchar(20) NOT NULL DEFAULT '',
  `ediserverpwd` varchar(20) NOT NULL DEFAULT '',
  `taxref` varchar(20) NOT NULL DEFAULT '',
  `customerpoline` tinyint(1) NOT NULL DEFAULT '0',
  `typeid` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`debtorno`),
  KEY `Currency` (`currcode`),
  KEY `HoldReason` (`holdreason`),
  KEY `Name` (`name`),
  KEY `PaymentTerms` (`paymentterms`),
  KEY `SalesType` (`salestype`),
  KEY `EDIInvoices` (`ediinvoices`),
  KEY `EDIOrders` (`ediorders`),
  KEY `debtorsmaster_ibfk_5` (`typeid`),
  CONSTRAINT `debtorsmaster_ibfk_1` FOREIGN KEY (`holdreason`) REFERENCES `holdreasons` (`reasoncode`),
  CONSTRAINT `debtorsmaster_ibfk_2` FOREIGN KEY (`currcode`) REFERENCES `currencies` (`currabrev`),
  CONSTRAINT `debtorsmaster_ibfk_3` FOREIGN KEY (`paymentterms`) REFERENCES `paymentterms` (`termsindicator`),
  CONSTRAINT `debtorsmaster_ibfk_4` FOREIGN KEY (`salestype`) REFERENCES `salestypes` (`typeabbrev`),
  CONSTRAINT `debtorsmaster_ibfk_5` FOREIGN KEY (`typeid`) REFERENCES `debtortype` (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `debtortrans`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `debtortrans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transno` int(11) NOT NULL DEFAULT '0',
  `type` smallint(6) NOT NULL DEFAULT '0',
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `trandate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `inputdate` datetime NOT NULL,
  `prd` smallint(6) NOT NULL DEFAULT '0',
  `settled` tinyint(4) NOT NULL DEFAULT '0',
  `reference` varchar(20) NOT NULL DEFAULT '',
  `tpe` char(2) NOT NULL DEFAULT '',
  `order_` int(11) NOT NULL DEFAULT '0',
  `rate` double NOT NULL DEFAULT '0',
  `ovamount` double NOT NULL DEFAULT '0',
  `ovgst` double NOT NULL DEFAULT '0',
  `ovfreight` double NOT NULL DEFAULT '0',
  `ovdiscount` double NOT NULL DEFAULT '0',
  `diffonexch` double NOT NULL DEFAULT '0',
  `alloc` double NOT NULL DEFAULT '0',
  `invtext` text,
  `shipvia` int(11) NOT NULL DEFAULT '0',
  `edisent` tinyint(4) NOT NULL DEFAULT '0',
  `consignment` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `DebtorNo` (`debtorno`,`branchcode`),
  KEY `Order_` (`order_`),
  KEY `Prd` (`prd`),
  KEY `Tpe` (`tpe`),
  KEY `Type` (`type`),
  KEY `Settled` (`settled`),
  KEY `TranDate` (`trandate`),
  KEY `TransNo` (`transno`),
  KEY `Type_2` (`type`,`transno`),
  KEY `EDISent` (`edisent`),
  CONSTRAINT `debtortrans_ibfk_2` FOREIGN KEY (`type`) REFERENCES `systypes` (`typeid`),
  CONSTRAINT `debtortrans_ibfk_3` FOREIGN KEY (`prd`) REFERENCES `periods` (`periodno`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `debtortranstaxes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `debtortranstaxes` (
  `debtortransid` int(11) NOT NULL DEFAULT '0',
  `taxauthid` tinyint(4) NOT NULL DEFAULT '0',
  `taxamount` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`debtortransid`,`taxauthid`),
  KEY `taxauthid` (`taxauthid`),
  CONSTRAINT `debtortranstaxes_ibfk_1` FOREIGN KEY (`taxauthid`) REFERENCES `taxauthorities` (`taxid`),
  CONSTRAINT `debtortranstaxes_ibfk_2` FOREIGN KEY (`debtortransid`) REFERENCES `debtortrans` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `debtortype`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `debtortype` (
  `typeid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `typename` varchar(100) NOT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `debtortypenotes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `debtortypenotes` (
  `noteid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `typeid` tinyint(4) NOT NULL DEFAULT '0',
  `href` varchar(100) NOT NULL,
  `note` varchar(200) NOT NULL,
  `date` date NOT NULL DEFAULT '0000-00-00',
  `priority` varchar(20) NOT NULL,
  PRIMARY KEY (`noteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deliverynotes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deliverynotes` (
  `deliverynotenumber` int(11) NOT NULL,
  `deliverynotelineno` tinyint(4) NOT NULL,
  `salesorderno` int(11) NOT NULL,
  `salesorderlineno` int(11) NOT NULL,
  `qtydelivered` double NOT NULL DEFAULT '0',
  `printed` tinyint(4) NOT NULL DEFAULT '0',
  `invoiced` tinyint(4) NOT NULL DEFAULT '0',
  `deliverydate` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`deliverynotenumber`,`deliverynotelineno`),
  KEY `deliverynotes_ibfk_2` (`salesorderno`,`salesorderlineno`),
  CONSTRAINT `deliverynotes_ibfk_1` FOREIGN KEY (`salesorderno`) REFERENCES `salesorders` (`orderno`),
  CONSTRAINT `deliverynotes_ibfk_2` FOREIGN KEY (`salesorderno`, `salesorderlineno`) REFERENCES `salesorderdetails` (`orderno`, `orderlineno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `departments`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `departmentid` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL DEFAULT '',
  `authoriser` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`departmentid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discountmatrix`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discountmatrix` (
  `salestype` char(2) NOT NULL DEFAULT '',
  `discountcategory` char(2) NOT NULL DEFAULT '',
  `quantitybreak` int(11) NOT NULL DEFAULT '1',
  `discountrate` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`salestype`,`discountcategory`,`quantitybreak`),
  KEY `QuantityBreak` (`quantitybreak`),
  KEY `DiscountCategory` (`discountcategory`),
  KEY `SalesType` (`salestype`),
  CONSTRAINT `discountmatrix_ibfk_1` FOREIGN KEY (`salestype`) REFERENCES `salestypes` (`typeabbrev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edi_orders_seg_groups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edi_orders_seg_groups` (
  `seggroupno` tinyint(4) NOT NULL DEFAULT '0',
  `maxoccur` int(4) NOT NULL DEFAULT '0',
  `parentseggroup` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`seggroupno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edi_orders_segs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edi_orders_segs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `segtag` char(3) NOT NULL DEFAULT '',
  `seggroup` tinyint(4) NOT NULL DEFAULT '0',
  `maxoccur` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `SegTag` (`segtag`),
  KEY `SegNo` (`seggroup`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ediitemmapping`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ediitemmapping` (
  `supporcust` varchar(4) NOT NULL DEFAULT '',
  `partnercode` varchar(10) NOT NULL DEFAULT '',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `partnerstockid` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`supporcust`,`partnercode`,`stockid`),
  KEY `PartnerCode` (`partnercode`),
  KEY `StockID` (`stockid`),
  KEY `PartnerStockID` (`partnerstockid`),
  KEY `SuppOrCust` (`supporcust`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edimessageformat`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edimessageformat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `partnercode` varchar(10) NOT NULL DEFAULT '',
  `messagetype` varchar(6) NOT NULL DEFAULT '',
  `section` varchar(7) NOT NULL DEFAULT '',
  `sequenceno` int(11) NOT NULL DEFAULT '0',
  `linetext` varchar(70) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `PartnerCode` (`partnercode`,`messagetype`,`sequenceno`),
  KEY `Section` (`section`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emailsettings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emailsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(30) NOT NULL,
  `port` char(5) NOT NULL,
  `heloaddress` varchar(20) NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `timeout` int(11) DEFAULT '5',
  `companyname` varchar(50) DEFAULT NULL,
  `auth` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factorcompanies`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factorcompanies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coyname` varchar(50) NOT NULL DEFAULT '',
  `address1` varchar(40) NOT NULL DEFAULT '',
  `address2` varchar(40) NOT NULL DEFAULT '',
  `address3` varchar(40) NOT NULL DEFAULT '',
  `address4` varchar(40) NOT NULL DEFAULT '',
  `address5` varchar(20) NOT NULL DEFAULT '',
  `address6` varchar(15) NOT NULL DEFAULT '',
  `contact` varchar(25) NOT NULL DEFAULT '',
  `telephone` varchar(25) NOT NULL DEFAULT '',
  `fax` varchar(25) NOT NULL DEFAULT '',
  `email` varchar(55) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `factor_name` (`coyname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fixedassetcategories`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fixedassetcategories` (
  `categoryid` char(6) NOT NULL DEFAULT '',
  `categorydescription` char(20) NOT NULL DEFAULT '',
  `costact` int(11) NOT NULL DEFAULT '0',
  `depnact` int(11) NOT NULL DEFAULT '0',
  `disposalact` int(11) NOT NULL DEFAULT '80000',
  `accumdepnact` int(11) NOT NULL DEFAULT '0',
  `defaultdepnrate` double NOT NULL DEFAULT '0.2',
  `defaultdepntype` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`categoryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fixedassetlocations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fixedassetlocations` (
  `locationid` char(6) NOT NULL DEFAULT '',
  `locationdescription` char(20) NOT NULL DEFAULT '',
  `parentlocationid` char(6) DEFAULT '',
  PRIMARY KEY (`locationid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fixedassets`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fixedassets` (
  `assetid` int(11) NOT NULL AUTO_INCREMENT,
  `serialno` varchar(30) NOT NULL DEFAULT '',
  `barcode` varchar(20) NOT NULL,
  `assetlocation` varchar(6) NOT NULL DEFAULT '',
  `cost` double NOT NULL DEFAULT '0',
  `accumdepn` double NOT NULL DEFAULT '0',
  `datepurchased` date NOT NULL DEFAULT '0000-00-00',
  `disposalproceeds` double NOT NULL DEFAULT '0',
  `assetcategoryid` varchar(6) NOT NULL DEFAULT '',
  `description` varchar(50) NOT NULL DEFAULT '',
  `longdescription` text NOT NULL,
  `depntype` int(11) NOT NULL DEFAULT '1',
  `depnrate` double NOT NULL,
  `disposaldate` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`assetid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fixedassettrans`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fixedassettrans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetid` int(11) NOT NULL,
  `transtype` tinyint(4) NOT NULL,
  `transdate` date NOT NULL,
  `transno` int(11) NOT NULL,
  `periodno` smallint(6) NOT NULL,
  `inputdate` date NOT NULL,
  `fixedassettranstype` varchar(8) NOT NULL,
  `amount` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assetid` (`assetid`,`transtype`,`transno`),
  KEY `inputdate` (`inputdate`),
  KEY `transdate` (`transdate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `freightcosts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `freightcosts` (
  `shipcostfromid` int(11) NOT NULL AUTO_INCREMENT,
  `locationfrom` varchar(5) NOT NULL DEFAULT '',
  `destination` varchar(40) NOT NULL DEFAULT '',
  `shipperid` int(11) NOT NULL DEFAULT '0',
  `cubrate` double NOT NULL DEFAULT '0',
  `kgrate` double NOT NULL DEFAULT '0',
  `maxkgs` double NOT NULL DEFAULT '999999',
  `maxcub` double NOT NULL DEFAULT '999999',
  `fixedprice` double NOT NULL DEFAULT '0',
  `minimumchg` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`shipcostfromid`),
  KEY `Destination` (`destination`),
  KEY `LocationFrom` (`locationfrom`),
  KEY `ShipperID` (`shipperid`),
  KEY `Destination_2` (`destination`,`locationfrom`,`shipperid`),
  CONSTRAINT `freightcosts_ibfk_1` FOREIGN KEY (`locationfrom`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `freightcosts_ibfk_2` FOREIGN KEY (`shipperid`) REFERENCES `shippers` (`shipper_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `geocode_param`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geocode_param` (
  `geocodeid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `geocode_key` varchar(200) NOT NULL DEFAULT '',
  `center_long` varchar(20) NOT NULL DEFAULT '',
  `center_lat` varchar(20) NOT NULL DEFAULT '',
  `map_height` varchar(10) NOT NULL DEFAULT '',
  `map_width` varchar(10) NOT NULL DEFAULT '',
  `map_host` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`geocodeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gltrans`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gltrans` (
  `counterindex` int(11) NOT NULL AUTO_INCREMENT,
  `type` smallint(6) NOT NULL DEFAULT '0',
  `typeno` bigint(16) NOT NULL DEFAULT '1',
  `chequeno` int(11) NOT NULL DEFAULT '0',
  `trandate` date NOT NULL DEFAULT '0000-00-00',
  `periodno` smallint(6) NOT NULL DEFAULT '0',
  `account` varchar(20) NOT NULL DEFAULT '0',
  `narrative` varchar(200) NOT NULL DEFAULT '',
  `amount` double NOT NULL DEFAULT '0',
  `posted` tinyint(4) NOT NULL DEFAULT '0',
  `jobref` varchar(20) NOT NULL DEFAULT '',
  `tag` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`counterindex`),
  KEY `Account` (`account`),
  KEY `ChequeNo` (`chequeno`),
  KEY `PeriodNo` (`periodno`),
  KEY `Posted` (`posted`),
  KEY `TranDate` (`trandate`),
  KEY `TypeNo` (`typeno`),
  KEY `Type_and_Number` (`type`,`typeno`),
  KEY `JobRef` (`jobref`),
  CONSTRAINT `gltrans_ibfk_1` FOREIGN KEY (`account`) REFERENCES `chartmaster` (`accountcode`),
  CONSTRAINT `gltrans_ibfk_2` FOREIGN KEY (`type`) REFERENCES `systypes` (`typeid`),
  CONSTRAINT `gltrans_ibfk_3` FOREIGN KEY (`periodno`) REFERENCES `periods` (`periodno`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grns`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grns` (
  `grnbatch` smallint(6) NOT NULL DEFAULT '0',
  `grnno` int(11) NOT NULL AUTO_INCREMENT,
  `podetailitem` int(11) NOT NULL DEFAULT '0',
  `itemcode` varchar(20) NOT NULL DEFAULT '',
  `deliverydate` date NOT NULL DEFAULT '0000-00-00',
  `itemdescription` varchar(100) NOT NULL DEFAULT '',
  `qtyrecd` double NOT NULL DEFAULT '0',
  `quantityinv` double NOT NULL DEFAULT '0',
  `supplierid` varchar(10) NOT NULL DEFAULT '',
  `stdcostunit` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`grnno`),
  KEY `DeliveryDate` (`deliverydate`),
  KEY `ItemCode` (`itemcode`),
  KEY `PODetailItem` (`podetailitem`),
  KEY `SupplierID` (`supplierid`),
  CONSTRAINT `grns_ibfk_1` FOREIGN KEY (`supplierid`) REFERENCES `suppliers` (`supplierid`),
  CONSTRAINT `grns_ibfk_2` FOREIGN KEY (`podetailitem`) REFERENCES `purchorderdetails` (`podetailitem`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `holdreasons`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `holdreasons` (
  `reasoncode` smallint(6) NOT NULL DEFAULT '1',
  `reasondescription` char(30) NOT NULL DEFAULT '',
  `dissallowinvoices` tinyint(4) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`reasoncode`),
  KEY `ReasonDescription` (`reasondescription`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `internalstockcatrole`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `internalstockcatrole` (
  `categoryid` varchar(6) NOT NULL,
  `secroleid` int(11) NOT NULL,
  PRIMARY KEY (`categoryid`,`secroleid`),
  KEY `internalstockcatrole_ibfk_1` (`categoryid`),
  KEY `internalstockcatrole_ibfk_2` (`secroleid`),
  CONSTRAINT `internalstockcatrole_ibfk_1` FOREIGN KEY (`categoryid`) REFERENCES `stockcategory` (`categoryid`),
  CONSTRAINT `internalstockcatrole_ibfk_2` FOREIGN KEY (`secroleid`) REFERENCES `securityroles` (`secroleid`),
  CONSTRAINT `internalstockcatrole_ibfk_3` FOREIGN KEY (`categoryid`) REFERENCES `stockcategory` (`categoryid`),
  CONSTRAINT `internalstockcatrole_ibfk_4` FOREIGN KEY (`secroleid`) REFERENCES `securityroles` (`secroleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobcards`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobcards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `debtorno` varchar(255) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `task1` varchar(500) DEFAULT NULL,
  `task2` varchar(500) DEFAULT NULL,
  `task3` varchar(500) DEFAULT NULL,
  `task4` varchar(500) DEFAULT NULL,
  `task5` varchar(500) DEFAULT NULL,
  `task6` varchar(500) DEFAULT NULL,
  `createdate` date DEFAULT NULL,
  `completedate` date DEFAULT NULL,
  `invoice` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `labelfields`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labelfields` (
  `labelfieldid` int(11) NOT NULL AUTO_INCREMENT,
  `labelid` tinyint(4) NOT NULL,
  `fieldvalue` varchar(20) NOT NULL,
  `vpos` double NOT NULL DEFAULT '0',
  `hpos` double NOT NULL DEFAULT '0',
  `fontsize` tinyint(4) NOT NULL,
  `barcode` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`labelfieldid`),
  KEY `labelid` (`labelid`),
  KEY `vpos` (`vpos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `labels`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labels` (
  `labelid` tinyint(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) NOT NULL,
  `pagewidth` double NOT NULL DEFAULT '0',
  `pageheight` double NOT NULL DEFAULT '0',
  `height` double NOT NULL DEFAULT '0',
  `width` double NOT NULL DEFAULT '0',
  `topmargin` double NOT NULL DEFAULT '0',
  `leftmargin` double NOT NULL DEFAULT '0',
  `rowheight` double NOT NULL DEFAULT '0',
  `columnwidth` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`labelid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lastcostrollup`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lastcostrollup` (
  `stockid` char(20) NOT NULL DEFAULT '',
  `totalonhand` double NOT NULL DEFAULT '0',
  `matcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `labcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `oheadcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `categoryid` char(6) NOT NULL DEFAULT '',
  `stockact` int(11) NOT NULL DEFAULT '0',
  `adjglact` int(11) NOT NULL DEFAULT '0',
  `newmatcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `newlabcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `newoheadcost` decimal(20,4) NOT NULL DEFAULT '0.0000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `locationname` varchar(50) NOT NULL DEFAULT '',
  `deladd1` varchar(40) NOT NULL DEFAULT '',
  `deladd2` varchar(40) NOT NULL DEFAULT '',
  `deladd3` varchar(40) NOT NULL DEFAULT '',
  `deladd4` varchar(40) NOT NULL DEFAULT '',
  `deladd5` varchar(20) NOT NULL DEFAULT '',
  `deladd6` varchar(15) NOT NULL DEFAULT '',
  `tel` varchar(30) NOT NULL DEFAULT '',
  `fax` varchar(30) NOT NULL DEFAULT '',
  `email` varchar(55) NOT NULL DEFAULT '',
  `contact` varchar(30) NOT NULL DEFAULT '',
  `taxprovinceid` tinyint(4) NOT NULL DEFAULT '1',
  `cashsalecustomer` varchar(10) DEFAULT '',
  `managed` int(11) DEFAULT '0',
  `cashsalebranch` varchar(10) DEFAULT '',
  `internalrequest` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Allow (1) or not (0) internal request from this location',
  PRIMARY KEY (`loccode`),
  UNIQUE KEY `locationname` (`locationname`),
  KEY `taxprovinceid` (`taxprovinceid`),
  CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`taxprovinceid`) REFERENCES `taxprovinces` (`taxprovinceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locstock`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locstock` (
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `quantity` double NOT NULL DEFAULT '0',
  `reorderlevel` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`loccode`,`stockid`),
  KEY `StockID` (`stockid`),
  CONSTRAINT `locstock_ibfk_1` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `locstock_ibfk_2` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loctransfers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loctransfers` (
  `reference` int(11) NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `shipqty` double NOT NULL DEFAULT '0',
  `recqty` double NOT NULL DEFAULT '0',
  `shipdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `recdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `shiploc` varchar(7) NOT NULL DEFAULT '',
  `recloc` varchar(7) NOT NULL DEFAULT '',
  KEY `Reference` (`reference`,`stockid`),
  KEY `ShipLoc` (`shiploc`),
  KEY `RecLoc` (`recloc`),
  KEY `StockID` (`stockid`),
  CONSTRAINT `loctransfers_ibfk_1` FOREIGN KEY (`shiploc`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `loctransfers_ibfk_2` FOREIGN KEY (`recloc`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `loctransfers_ibfk_3` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores Shipments To And From Locations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mrpcalendar`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrpcalendar` (
  `calendardate` date NOT NULL,
  `daynumber` int(6) NOT NULL,
  `manufacturingflag` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`calendardate`),
  KEY `daynumber` (`daynumber`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mrpdemands`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrpdemands` (
  `demandid` int(11) NOT NULL AUTO_INCREMENT,
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `mrpdemandtype` varchar(6) NOT NULL DEFAULT '',
  `quantity` double NOT NULL DEFAULT '0',
  `duedate` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`demandid`),
  KEY `StockID` (`stockid`),
  KEY `mrpdemands_ibfk_1` (`mrpdemandtype`),
  CONSTRAINT `mrpdemands_ibfk_1` FOREIGN KEY (`mrpdemandtype`) REFERENCES `mrpdemandtypes` (`mrpdemandtype`),
  CONSTRAINT `mrpdemands_ibfk_2` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mrpdemandtypes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrpdemandtypes` (
  `mrpdemandtype` varchar(6) NOT NULL DEFAULT '',
  `description` char(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`mrpdemandtype`),
  KEY `mrpdemandtype` (`mrpdemandtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mrpplannedorders`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrpplannedorders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `part` char(20) DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `supplyquantity` double DEFAULT NULL,
  `ordertype` varchar(6) DEFAULT NULL,
  `orderno` int(11) DEFAULT NULL,
  `mrpdate` date DEFAULT NULL,
  `updateflag` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `offers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offers` (
  `offerid` int(11) NOT NULL AUTO_INCREMENT,
  `tenderid` int(11) NOT NULL DEFAULT '0',
  `supplierid` varchar(10) NOT NULL DEFAULT '',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `quantity` double NOT NULL DEFAULT '0',
  `uom` varchar(15) NOT NULL DEFAULT '',
  `price` double NOT NULL DEFAULT '0',
  `expirydate` date NOT NULL DEFAULT '0000-00-00',
  `currcode` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`offerid`),
  KEY `offers_ibfk_1` (`supplierid`),
  KEY `offers_ibfk_2` (`stockid`),
  CONSTRAINT `offers_ibfk_1` FOREIGN KEY (`supplierid`) REFERENCES `suppliers` (`supplierid`),
  CONSTRAINT `offers_ibfk_2` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orderdeliverydifferenceslog`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderdeliverydifferenceslog` (
  `orderno` int(11) NOT NULL DEFAULT '0',
  `invoiceno` int(11) NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `quantitydiff` double NOT NULL DEFAULT '0',
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `branch` varchar(10) NOT NULL DEFAULT '',
  `can_or_bo` char(3) NOT NULL DEFAULT 'CAN',
  KEY `StockID` (`stockid`),
  KEY `DebtorNo` (`debtorno`,`branch`),
  KEY `Can_or_BO` (`can_or_bo`),
  KEY `OrderNo` (`orderno`),
  CONSTRAINT `orderdeliverydifferenceslog_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `orderdeliverydifferenceslog_ibfk_2` FOREIGN KEY (`debtorno`, `branch`) REFERENCES `custbranch` (`debtorno`, `branchcode`),
  CONSTRAINT `orderdeliverydifferenceslog_ibfk_3` FOREIGN KEY (`orderno`) REFERENCES `salesorders` (`orderno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paymentmethods`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentmethods` (
  `paymentid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `paymentname` varchar(15) NOT NULL DEFAULT '',
  `paymenttype` int(11) NOT NULL DEFAULT '1',
  `receipttype` int(11) NOT NULL DEFAULT '1',
  `usepreprintedstationery` tinyint(4) NOT NULL DEFAULT '0',
  `opencashdrawer` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`paymentid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paymentterms`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentterms` (
  `termsindicator` char(2) NOT NULL DEFAULT '',
  `terms` char(40) NOT NULL DEFAULT '',
  `daysbeforedue` smallint(6) NOT NULL DEFAULT '0',
  `dayinfollowingmonth` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`termsindicator`),
  KEY `DaysBeforeDue` (`daysbeforedue`),
  KEY `DayInFollowingMonth` (`dayinfollowingmonth`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pcashdetails`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pcashdetails` (
  `counterindex` int(20) NOT NULL AUTO_INCREMENT,
  `tabcode` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `codeexpense` varchar(20) NOT NULL,
  `amount` double NOT NULL,
  `authorized` date NOT NULL COMMENT 'date cash assigment was revised and authorized by authorizer from tabs table',
  `posted` tinyint(4) NOT NULL COMMENT 'has (or has not) been posted into gltrans',
  `notes` text NOT NULL,
  `receipt` text COMMENT 'filename or path to scanned receipt or code of receipt to find physical receipt if tax guys or auditors show up',
  PRIMARY KEY (`counterindex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pcexpenses`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pcexpenses` (
  `codeexpense` varchar(20) NOT NULL COMMENT 'code for the group',
  `description` varchar(50) NOT NULL COMMENT 'text description, e.g. meals, train tickets, fuel, etc',
  `glaccount` varchar(20) NOT NULL DEFAULT '0',
  `tag` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`codeexpense`),
  KEY `glaccount` (`glaccount`),
  CONSTRAINT `pcexpenses_ibfk_1` FOREIGN KEY (`glaccount`) REFERENCES `chartmaster` (`accountcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pctabexpenses`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pctabexpenses` (
  `typetabcode` varchar(20) NOT NULL,
  `codeexpense` varchar(20) NOT NULL,
  KEY `typetabcode` (`typetabcode`),
  KEY `codeexpense` (`codeexpense`),
  CONSTRAINT `pctabexpenses_ibfk_1` FOREIGN KEY (`typetabcode`) REFERENCES `pctypetabs` (`typetabcode`),
  CONSTRAINT `pctabexpenses_ibfk_2` FOREIGN KEY (`codeexpense`) REFERENCES `pcexpenses` (`codeexpense`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pctabs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pctabs` (
  `tabcode` varchar(20) NOT NULL,
  `usercode` varchar(20) NOT NULL COMMENT 'code of user employee from www_users',
  `typetabcode` varchar(20) NOT NULL,
  `currency` char(3) NOT NULL,
  `tablimit` double NOT NULL,
  `assigner` varchar(20) NOT NULL COMMENT 'Cash assigner for the tab',
  `authorizer` varchar(20) NOT NULL COMMENT 'code of user from www_users',
  `glaccountassignment` varchar(20) NOT NULL DEFAULT '0',
  `glaccountpcash` varchar(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tabcode`),
  KEY `usercode` (`usercode`),
  KEY `typetabcode` (`typetabcode`),
  KEY `currency` (`currency`),
  KEY `authorizer` (`authorizer`),
  KEY `glaccountassignment` (`glaccountassignment`),
  CONSTRAINT `pctabs_ibfk_1` FOREIGN KEY (`usercode`) REFERENCES `www_users` (`userid`),
  CONSTRAINT `pctabs_ibfk_2` FOREIGN KEY (`typetabcode`) REFERENCES `pctypetabs` (`typetabcode`),
  CONSTRAINT `pctabs_ibfk_3` FOREIGN KEY (`currency`) REFERENCES `currencies` (`currabrev`),
  CONSTRAINT `pctabs_ibfk_4` FOREIGN KEY (`authorizer`) REFERENCES `www_users` (`userid`),
  CONSTRAINT `pctabs_ibfk_5` FOREIGN KEY (`glaccountassignment`) REFERENCES `chartmaster` (`accountcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pctypetabs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pctypetabs` (
  `typetabcode` varchar(20) NOT NULL COMMENT 'code for the type of petty cash tab',
  `typetabdescription` varchar(50) NOT NULL COMMENT 'text description, e.g. tab for CEO',
  PRIMARY KEY (`typetabcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `periods`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `periods` (
  `periodno` smallint(6) NOT NULL DEFAULT '0',
  `lastdate_in_period` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`periodno`),
  KEY `LastDate_in_Period` (`lastdate_in_period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pickinglistdetails`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pickinglistdetails` (
  `pickinglistno` int(11) NOT NULL DEFAULT '0',
  `pickinglistlineno` int(11) NOT NULL DEFAULT '0',
  `orderlineno` int(11) NOT NULL DEFAULT '0',
  `qtyexpected` double NOT NULL DEFAULT '0',
  `qtypicked` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`pickinglistno`,`pickinglistlineno`),
  CONSTRAINT `pickinglistdetails_ibfk_1` FOREIGN KEY (`pickinglistno`) REFERENCES `pickinglists` (`pickinglistno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pickinglists`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pickinglists` (
  `pickinglistno` int(11) NOT NULL DEFAULT '0',
  `orderno` int(11) NOT NULL DEFAULT '0',
  `pickinglistdate` date NOT NULL DEFAULT '0000-00-00',
  `dateprinted` date NOT NULL DEFAULT '0000-00-00',
  `deliverynotedate` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`pickinglistno`),
  KEY `pickinglists_ibfk_1` (`orderno`),
  CONSTRAINT `pickinglists_ibfk_1` FOREIGN KEY (`orderno`) REFERENCES `salesorders` (`orderno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prices`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prices` (
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `typeabbrev` char(2) NOT NULL DEFAULT '',
  `currabrev` char(3) NOT NULL DEFAULT '',
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `price` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `startdate` date NOT NULL DEFAULT '0000-00-00',
  `enddate` date NOT NULL DEFAULT '9999-12-31',
  PRIMARY KEY (`stockid`,`typeabbrev`,`currabrev`,`debtorno`,`branchcode`,`startdate`,`enddate`),
  KEY `CurrAbrev` (`currabrev`),
  KEY `DebtorNo` (`debtorno`),
  KEY `StockID` (`stockid`),
  KEY `TypeAbbrev` (`typeabbrev`),
  CONSTRAINT `prices_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `prices_ibfk_2` FOREIGN KEY (`currabrev`) REFERENCES `currencies` (`currabrev`),
  CONSTRAINT `prices_ibfk_3` FOREIGN KEY (`typeabbrev`) REFERENCES `salestypes` (`typeabbrev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchdata`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchdata` (
  `supplierno` char(10) NOT NULL DEFAULT '',
  `stockid` char(20) NOT NULL DEFAULT '',
  `price` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `suppliersuom` char(50) NOT NULL DEFAULT '',
  `conversionfactor` double NOT NULL DEFAULT '1',
  `supplierdescription` char(50) NOT NULL DEFAULT '',
  `leadtime` smallint(6) NOT NULL DEFAULT '1',
  `preferred` tinyint(4) NOT NULL DEFAULT '0',
  `effectivefrom` date NOT NULL,
  `suppliers_partno` varchar(50) NOT NULL DEFAULT '',
  `minorderqty` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`supplierno`,`stockid`,`effectivefrom`),
  KEY `StockID` (`stockid`),
  KEY `SupplierNo` (`supplierno`),
  KEY `Preferred` (`preferred`),
  CONSTRAINT `purchdata_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `purchdata_ibfk_2` FOREIGN KEY (`supplierno`) REFERENCES `suppliers` (`supplierid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchorderauth`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchorderauth` (
  `userid` varchar(20) NOT NULL DEFAULT '',
  `currabrev` char(3) NOT NULL DEFAULT '',
  `cancreate` smallint(2) NOT NULL DEFAULT '0',
  `authlevel` int(11) NOT NULL DEFAULT '0',
  `offhold` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`,`currabrev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchorderdetails`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchorderdetails` (
  `podetailitem` int(11) NOT NULL AUTO_INCREMENT,
  `orderno` int(11) NOT NULL DEFAULT '0',
  `itemcode` varchar(20) NOT NULL DEFAULT '',
  `deliverydate` date NOT NULL DEFAULT '0000-00-00',
  `itemdescription` varchar(100) NOT NULL,
  `glcode` int(11) NOT NULL DEFAULT '0',
  `qtyinvoiced` double NOT NULL DEFAULT '0',
  `unitprice` double NOT NULL DEFAULT '0',
  `actprice` double NOT NULL DEFAULT '0',
  `stdcostunit` double NOT NULL DEFAULT '0',
  `quantityord` double NOT NULL DEFAULT '0',
  `quantityrecd` double NOT NULL DEFAULT '0',
  `shiptref` int(11) NOT NULL DEFAULT '0',
  `jobref` varchar(20) NOT NULL DEFAULT '',
  `completed` tinyint(4) NOT NULL DEFAULT '0',
  `suppliersunit` varchar(50) DEFAULT NULL,
  `suppliers_partno` varchar(50) NOT NULL DEFAULT '',
  `assetid` int(11) NOT NULL DEFAULT '0',
  `conversionfactor` double NOT NULL DEFAULT '1',
  PRIMARY KEY (`podetailitem`),
  KEY `DeliveryDate` (`deliverydate`),
  KEY `GLCode` (`glcode`),
  KEY `ItemCode` (`itemcode`),
  KEY `JobRef` (`jobref`),
  KEY `OrderNo` (`orderno`),
  KEY `ShiptRef` (`shiptref`),
  KEY `Completed` (`completed`),
  CONSTRAINT `purchorderdetails_ibfk_1` FOREIGN KEY (`orderno`) REFERENCES `purchorders` (`orderno`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchorders`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchorders` (
  `orderno` int(11) NOT NULL AUTO_INCREMENT,
  `supplierno` varchar(10) NOT NULL DEFAULT '',
  `comments` longblob,
  `orddate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `rate` double NOT NULL DEFAULT '1',
  `dateprinted` datetime DEFAULT NULL,
  `allowprint` tinyint(4) NOT NULL DEFAULT '1',
  `initiator` varchar(20) DEFAULT NULL,
  `requisitionno` varchar(15) DEFAULT NULL,
  `intostocklocation` varchar(5) NOT NULL DEFAULT '',
  `deladd1` varchar(40) NOT NULL DEFAULT '',
  `deladd2` varchar(40) NOT NULL DEFAULT '',
  `deladd3` varchar(40) NOT NULL DEFAULT '',
  `deladd4` varchar(40) NOT NULL DEFAULT '',
  `deladd5` varchar(20) NOT NULL DEFAULT '',
  `deladd6` varchar(15) NOT NULL DEFAULT '',
  `tel` varchar(15) NOT NULL DEFAULT '',
  `suppdeladdress1` varchar(40) NOT NULL DEFAULT '',
  `suppdeladdress2` varchar(40) NOT NULL DEFAULT '',
  `suppdeladdress3` varchar(40) NOT NULL DEFAULT '',
  `suppdeladdress4` varchar(40) NOT NULL DEFAULT '',
  `suppdeladdress5` varchar(20) NOT NULL DEFAULT '',
  `suppdeladdress6` varchar(15) NOT NULL DEFAULT '',
  `suppliercontact` varchar(30) NOT NULL DEFAULT '',
  `supptel` varchar(30) NOT NULL DEFAULT '',
  `contact` varchar(30) NOT NULL DEFAULT '',
  `version` decimal(3,2) NOT NULL DEFAULT '1.00',
  `revised` date NOT NULL DEFAULT '0000-00-00',
  `realorderno` varchar(16) NOT NULL DEFAULT '',
  `deliveryby` varchar(100) NOT NULL DEFAULT '',
  `deliverydate` date NOT NULL DEFAULT '0000-00-00',
  `status` varchar(12) NOT NULL DEFAULT '',
  `stat_comment` text NOT NULL,
  `paymentterms` char(2) NOT NULL DEFAULT '',
  `port` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`orderno`),
  KEY `OrdDate` (`orddate`),
  KEY `SupplierNo` (`supplierno`),
  KEY `IntoStockLocation` (`intostocklocation`),
  KEY `AllowPrintPO` (`allowprint`),
  CONSTRAINT `purchorders_ibfk_1` FOREIGN KEY (`supplierno`) REFERENCES `suppliers` (`supplierid`),
  CONSTRAINT `purchorders_ibfk_2` FOREIGN KEY (`intostocklocation`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurringsalesorders`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recurringsalesorders` (
  `recurrorderno` int(11) NOT NULL AUTO_INCREMENT,
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `customerref` varchar(50) NOT NULL DEFAULT '',
  `buyername` varchar(50) DEFAULT NULL,
  `comments` longblob,
  `orddate` date NOT NULL DEFAULT '0000-00-00',
  `ordertype` char(2) NOT NULL DEFAULT '',
  `shipvia` int(11) NOT NULL DEFAULT '0',
  `deladd1` varchar(40) NOT NULL DEFAULT '',
  `deladd2` varchar(40) NOT NULL DEFAULT '',
  `deladd3` varchar(40) NOT NULL DEFAULT '',
  `deladd4` varchar(40) DEFAULT NULL,
  `deladd5` varchar(20) NOT NULL DEFAULT '',
  `deladd6` varchar(15) NOT NULL DEFAULT '',
  `contactphone` varchar(25) DEFAULT NULL,
  `contactemail` varchar(25) DEFAULT NULL,
  `deliverto` varchar(40) NOT NULL DEFAULT '',
  `freightcost` double NOT NULL DEFAULT '0',
  `fromstkloc` varchar(5) NOT NULL DEFAULT '',
  `lastrecurrence` date NOT NULL DEFAULT '0000-00-00',
  `stopdate` date NOT NULL DEFAULT '0000-00-00',
  `frequency` tinyint(4) NOT NULL DEFAULT '1',
  `autoinvoice` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`recurrorderno`),
  KEY `debtorno` (`debtorno`),
  KEY `orddate` (`orddate`),
  KEY `ordertype` (`ordertype`),
  KEY `locationindex` (`fromstkloc`),
  KEY `branchcode` (`branchcode`,`debtorno`),
  CONSTRAINT `recurringsalesorders_ibfk_1` FOREIGN KEY (`branchcode`, `debtorno`) REFERENCES `custbranch` (`branchcode`, `debtorno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurrsalesorderdetails`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recurrsalesorderdetails` (
  `recurrorderno` int(11) NOT NULL DEFAULT '0',
  `stkcode` varchar(20) NOT NULL DEFAULT '',
  `unitprice` double NOT NULL DEFAULT '0',
  `quantity` double NOT NULL DEFAULT '0',
  `discountpercent` double NOT NULL DEFAULT '0',
  `narrative` text NOT NULL,
  KEY `orderno` (`recurrorderno`),
  KEY `stkcode` (`stkcode`),
  CONSTRAINT `recurrsalesorderdetails_ibfk_1` FOREIGN KEY (`recurrorderno`) REFERENCES `recurringsalesorders` (`recurrorderno`),
  CONSTRAINT `recurrsalesorderdetails_ibfk_2` FOREIGN KEY (`stkcode`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportcolumns`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportcolumns` (
  `reportid` smallint(6) NOT NULL DEFAULT '0',
  `colno` smallint(6) NOT NULL DEFAULT '0',
  `heading1` varchar(15) NOT NULL DEFAULT '',
  `heading2` varchar(15) DEFAULT NULL,
  `calculation` tinyint(1) NOT NULL DEFAULT '0',
  `periodfrom` smallint(6) DEFAULT NULL,
  `periodto` smallint(6) DEFAULT NULL,
  `datatype` varchar(15) DEFAULT NULL,
  `colnumerator` tinyint(4) DEFAULT NULL,
  `coldenominator` tinyint(4) DEFAULT NULL,
  `calcoperator` char(1) DEFAULT NULL,
  `budgetoractual` tinyint(1) NOT NULL DEFAULT '0',
  `valformat` char(1) NOT NULL DEFAULT 'N',
  `constant` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`reportid`,`colno`),
  CONSTRAINT `reportcolumns_ibfk_1` FOREIGN KEY (`reportid`) REFERENCES `reportheaders` (`reportid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportfields`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportfields` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `reportid` int(5) NOT NULL DEFAULT '0',
  `entrytype` varchar(15) NOT NULL DEFAULT '',
  `seqnum` int(3) NOT NULL DEFAULT '0',
  `fieldname` varchar(80) NOT NULL DEFAULT '',
  `displaydesc` varchar(25) NOT NULL DEFAULT '',
  `visible` enum('1','0') NOT NULL DEFAULT '1',
  `columnbreak` enum('1','0') NOT NULL DEFAULT '1',
  `params` text,
  PRIMARY KEY (`id`),
  KEY `reportid` (`reportid`)
) ENGINE=MyISAM AUTO_INCREMENT=1805 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportheaders`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportheaders` (
  `reportid` smallint(6) NOT NULL AUTO_INCREMENT,
  `reportheading` varchar(80) NOT NULL DEFAULT '',
  `groupbydata1` varchar(15) NOT NULL DEFAULT '',
  `newpageafter1` tinyint(1) NOT NULL DEFAULT '0',
  `lower1` varchar(10) NOT NULL DEFAULT '',
  `upper1` varchar(10) NOT NULL DEFAULT '',
  `groupbydata2` varchar(15) DEFAULT NULL,
  `newpageafter2` tinyint(1) NOT NULL DEFAULT '0',
  `lower2` varchar(10) DEFAULT NULL,
  `upper2` varchar(10) DEFAULT NULL,
  `groupbydata3` varchar(15) DEFAULT NULL,
  `newpageafter3` tinyint(1) NOT NULL DEFAULT '0',
  `lower3` varchar(10) DEFAULT NULL,
  `upper3` varchar(10) DEFAULT NULL,
  `groupbydata4` varchar(15) NOT NULL DEFAULT '',
  `newpageafter4` tinyint(1) NOT NULL DEFAULT '0',
  `upper4` varchar(10) NOT NULL DEFAULT '',
  `lower4` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`reportid`),
  KEY `ReportHeading` (`reportheading`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportlinks`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportlinks` (
  `table1` varchar(25) NOT NULL DEFAULT '',
  `table2` varchar(25) NOT NULL DEFAULT '',
  `equation` varchar(75) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reports`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `reportname` varchar(30) NOT NULL DEFAULT '',
  `reporttype` char(3) NOT NULL DEFAULT 'rpt',
  `groupname` varchar(9) NOT NULL DEFAULT 'misc',
  `defaultreport` enum('1','0') NOT NULL DEFAULT '0',
  `papersize` varchar(15) NOT NULL DEFAULT 'A4,210,297',
  `paperorientation` enum('P','L') NOT NULL DEFAULT 'P',
  `margintop` int(3) NOT NULL DEFAULT '10',
  `marginbottom` int(3) NOT NULL DEFAULT '10',
  `marginleft` int(3) NOT NULL DEFAULT '10',
  `marginright` int(3) NOT NULL DEFAULT '10',
  `coynamefont` varchar(20) NOT NULL DEFAULT 'Helvetica',
  `coynamefontsize` int(3) NOT NULL DEFAULT '12',
  `coynamefontcolor` varchar(11) NOT NULL DEFAULT '0,0,0',
  `coynamealign` enum('L','C','R') NOT NULL DEFAULT 'C',
  `coynameshow` enum('1','0') NOT NULL DEFAULT '1',
  `title1desc` varchar(50) NOT NULL DEFAULT '%reportname%',
  `title1font` varchar(20) NOT NULL DEFAULT 'Helvetica',
  `title1fontsize` int(3) NOT NULL DEFAULT '10',
  `title1fontcolor` varchar(11) NOT NULL DEFAULT '0,0,0',
  `title1fontalign` enum('L','C','R') NOT NULL DEFAULT 'C',
  `title1show` enum('1','0') NOT NULL DEFAULT '1',
  `title2desc` varchar(50) NOT NULL DEFAULT 'Report Generated %date%',
  `title2font` varchar(20) NOT NULL DEFAULT 'Helvetica',
  `title2fontsize` int(3) NOT NULL DEFAULT '10',
  `title2fontcolor` varchar(11) NOT NULL DEFAULT '0,0,0',
  `title2fontalign` enum('L','C','R') NOT NULL DEFAULT 'C',
  `title2show` enum('1','0') NOT NULL DEFAULT '1',
  `filterfont` varchar(10) NOT NULL DEFAULT 'Helvetica',
  `filterfontsize` int(3) NOT NULL DEFAULT '8',
  `filterfontcolor` varchar(11) NOT NULL DEFAULT '0,0,0',
  `filterfontalign` enum('L','C','R') NOT NULL DEFAULT 'L',
  `datafont` varchar(10) NOT NULL DEFAULT 'Helvetica',
  `datafontsize` int(3) NOT NULL DEFAULT '10',
  `datafontcolor` varchar(10) NOT NULL DEFAULT 'black',
  `datafontalign` enum('L','C','R') NOT NULL DEFAULT 'L',
  `totalsfont` varchar(10) NOT NULL DEFAULT 'Helvetica',
  `totalsfontsize` int(3) NOT NULL DEFAULT '10',
  `totalsfontcolor` varchar(11) NOT NULL DEFAULT '0,0,0',
  `totalsfontalign` enum('L','C','R') NOT NULL DEFAULT 'L',
  `col1width` int(3) NOT NULL DEFAULT '25',
  `col2width` int(3) NOT NULL DEFAULT '25',
  `col3width` int(3) NOT NULL DEFAULT '25',
  `col4width` int(3) NOT NULL DEFAULT '25',
  `col5width` int(3) NOT NULL DEFAULT '25',
  `col6width` int(3) NOT NULL DEFAULT '25',
  `col7width` int(3) NOT NULL DEFAULT '25',
  `col8width` int(3) NOT NULL DEFAULT '25',
  `col9width` int(3) NOT NULL DEFAULT '25',
  `col10width` int(3) NOT NULL DEFAULT '25',
  `col11width` int(3) NOT NULL DEFAULT '25',
  `col12width` int(3) NOT NULL DEFAULT '25',
  `col13width` int(3) NOT NULL DEFAULT '25',
  `col14width` int(3) NOT NULL DEFAULT '25',
  `col15width` int(3) NOT NULL DEFAULT '25',
  `col16width` int(3) NOT NULL DEFAULT '25',
  `col17width` int(3) NOT NULL DEFAULT '25',
  `col18width` int(3) NOT NULL DEFAULT '25',
  `col19width` int(3) NOT NULL DEFAULT '25',
  `col20width` int(3) NOT NULL DEFAULT '25',
  `table1` varchar(25) NOT NULL DEFAULT '',
  `table2` varchar(25) DEFAULT NULL,
  `table2criteria` varchar(75) DEFAULT NULL,
  `table3` varchar(25) DEFAULT NULL,
  `table3criteria` varchar(75) DEFAULT NULL,
  `table4` varchar(25) DEFAULT NULL,
  `table4criteria` varchar(75) DEFAULT NULL,
  `table5` varchar(25) DEFAULT NULL,
  `table5criteria` varchar(75) DEFAULT NULL,
  `table6` varchar(25) DEFAULT NULL,
  `table6criteria` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`reportname`,`groupname`)
) ENGINE=MyISAM AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesanalysis`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesanalysis` (
  `typeabbrev` char(2) NOT NULL DEFAULT '',
  `periodno` smallint(6) NOT NULL DEFAULT '0',
  `amt` double NOT NULL DEFAULT '0',
  `cost` double NOT NULL DEFAULT '0',
  `cust` varchar(10) NOT NULL DEFAULT '',
  `custbranch` varchar(10) NOT NULL DEFAULT '',
  `qty` double NOT NULL DEFAULT '0',
  `disc` double NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `area` varchar(3) NOT NULL,
  `budgetoractual` tinyint(1) NOT NULL DEFAULT '0',
  `salesperson` char(3) NOT NULL DEFAULT '',
  `stkcategory` varchar(6) NOT NULL DEFAULT '',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `CustBranch` (`custbranch`),
  KEY `Cust` (`cust`),
  KEY `PeriodNo` (`periodno`),
  KEY `StkCategory` (`stkcategory`),
  KEY `StockID` (`stockid`),
  KEY `TypeAbbrev` (`typeabbrev`),
  KEY `Area` (`area`),
  KEY `BudgetOrActual` (`budgetoractual`),
  KEY `Salesperson` (`salesperson`),
  CONSTRAINT `salesanalysis_ibfk_1` FOREIGN KEY (`periodno`) REFERENCES `periods` (`periodno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salescat`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salescat` (
  `salescatid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `parentcatid` tinyint(4) DEFAULT NULL,
  `salescatname` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`salescatid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salescatprod`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salescatprod` (
  `salescatid` tinyint(4) NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`salescatid`,`stockid`),
  KEY `salescatid` (`salescatid`),
  KEY `stockid` (`stockid`),
  CONSTRAINT `salescatprod_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `salescatprod_ibfk_2` FOREIGN KEY (`salescatid`) REFERENCES `salescat` (`salescatid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesglpostings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesglpostings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area` varchar(3) NOT NULL,
  `stkcat` varchar(6) NOT NULL DEFAULT '',
  `discountglcode` int(11) NOT NULL DEFAULT '0',
  `salesglcode` int(11) NOT NULL DEFAULT '0',
  `salestype` char(2) NOT NULL DEFAULT 'AN',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Area_StkCat` (`area`,`stkcat`,`salestype`),
  KEY `Area` (`area`),
  KEY `StkCat` (`stkcat`),
  KEY `SalesType` (`salestype`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesman`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesman` (
  `salesmancode` varchar(4) NOT NULL DEFAULT '',
  `salesmanname` char(30) NOT NULL DEFAULT '',
  `smantel` char(20) NOT NULL DEFAULT '',
  `smanfax` char(20) NOT NULL DEFAULT '',
  `commissionrate1` double NOT NULL DEFAULT '0',
  `breakpoint` decimal(10,0) NOT NULL DEFAULT '0',
  `commissionrate2` double NOT NULL DEFAULT '0',
  `current` tinyint(4) NOT NULL COMMENT 'Salesman current (1) or not (0)',
  PRIMARY KEY (`salesmancode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesorderdetails`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesorderdetails` (
  `orderlineno` int(11) NOT NULL DEFAULT '0',
  `orderno` int(11) NOT NULL DEFAULT '0',
  `stkcode` varchar(20) NOT NULL DEFAULT '',
  `qtyinvoiced` double NOT NULL DEFAULT '0',
  `unitprice` double NOT NULL DEFAULT '0',
  `quantity` double NOT NULL DEFAULT '0',
  `estimate` tinyint(4) NOT NULL DEFAULT '0',
  `discountpercent` double NOT NULL DEFAULT '0',
  `actualdispatchdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `narrative` text,
  `itemdue` date DEFAULT NULL COMMENT 'Due date for line item.  Some customers require \r\nacknowledgements with due dates by line item',
  `poline` varchar(10) DEFAULT NULL COMMENT 'Some Customers require acknowledgements with a PO line number for each sales line',
  PRIMARY KEY (`orderlineno`,`orderno`),
  KEY `OrderNo` (`orderno`),
  KEY `StkCode` (`stkcode`),
  KEY `Completed` (`completed`),
  CONSTRAINT `salesorderdetails_ibfk_1` FOREIGN KEY (`orderno`) REFERENCES `salesorders` (`orderno`),
  CONSTRAINT `salesorderdetails_ibfk_2` FOREIGN KEY (`stkcode`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesorders`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesorders` (
  `orderno` int(11) NOT NULL,
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `customerref` varchar(50) NOT NULL DEFAULT '',
  `buyername` varchar(50) DEFAULT NULL,
  `comments` longblob,
  `orddate` date NOT NULL DEFAULT '0000-00-00',
  `ordertype` char(2) NOT NULL DEFAULT '',
  `shipvia` int(11) NOT NULL DEFAULT '0',
  `deladd1` varchar(40) NOT NULL DEFAULT '',
  `deladd2` varchar(40) NOT NULL DEFAULT '',
  `deladd3` varchar(40) NOT NULL DEFAULT '',
  `deladd4` varchar(40) DEFAULT NULL,
  `deladd5` varchar(20) NOT NULL DEFAULT '',
  `deladd6` varchar(15) NOT NULL DEFAULT '',
  `contactphone` varchar(25) DEFAULT NULL,
  `contactemail` varchar(40) DEFAULT NULL,
  `deliverto` varchar(40) NOT NULL DEFAULT '',
  `deliverblind` tinyint(1) DEFAULT '1',
  `freightcost` double NOT NULL DEFAULT '0',
  `fromstkloc` varchar(5) NOT NULL DEFAULT '',
  `deliverydate` date NOT NULL DEFAULT '0000-00-00',
  `confirmeddate` date NOT NULL DEFAULT '0000-00-00',
  `printedpackingslip` tinyint(4) NOT NULL DEFAULT '0',
  `datepackingslipprinted` date NOT NULL DEFAULT '0000-00-00',
  `quotation` tinyint(4) NOT NULL DEFAULT '0',
  `quotedate` date NOT NULL DEFAULT '0000-00-00',
  `poplaced` tinyint(4) NOT NULL DEFAULT '0',
  `salesperson` varchar(4) NOT NULL,
  PRIMARY KEY (`orderno`),
  KEY `DebtorNo` (`debtorno`),
  KEY `OrdDate` (`orddate`),
  KEY `OrderType` (`ordertype`),
  KEY `LocationIndex` (`fromstkloc`),
  KEY `BranchCode` (`branchcode`,`debtorno`),
  KEY `ShipVia` (`shipvia`),
  KEY `quotation` (`quotation`),
  KEY `poplaced` (`poplaced`),
  KEY `salesperson` (`salesperson`),
  CONSTRAINT `salesorders_ibfk_1` FOREIGN KEY (`branchcode`, `debtorno`) REFERENCES `custbranch` (`branchcode`, `debtorno`),
  CONSTRAINT `salesorders_ibfk_2` FOREIGN KEY (`shipvia`) REFERENCES `shippers` (`shipper_id`),
  CONSTRAINT `salesorders_ibfk_3` FOREIGN KEY (`fromstkloc`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salestypes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salestypes` (
  `typeabbrev` char(2) NOT NULL DEFAULT '',
  `sales_type` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`typeabbrev`),
  KEY `Sales_Type` (`sales_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scripts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scripts` (
  `script` varchar(78) NOT NULL DEFAULT '',
  `pagesecurity` int(11) NOT NULL DEFAULT '1',
  `description` text NOT NULL,
  PRIMARY KEY (`script`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `securitygroups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `securitygroups` (
  `secroleid` int(11) NOT NULL DEFAULT '0',
  `tokenid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`secroleid`,`tokenid`),
  KEY `secroleid` (`secroleid`),
  KEY `tokenid` (`tokenid`),
  CONSTRAINT `securitygroups_secroleid_fk` FOREIGN KEY (`secroleid`) REFERENCES `securityroles` (`secroleid`),
  CONSTRAINT `securitygroups_tokenid_fk` FOREIGN KEY (`tokenid`) REFERENCES `securitytokens` (`tokenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `securityroles`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `securityroles` (
  `secroleid` int(11) NOT NULL AUTO_INCREMENT,
  `secrolename` text NOT NULL,
  PRIMARY KEY (`secroleid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `securitytokens`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `securitytokens` (
  `tokenid` int(11) NOT NULL DEFAULT '0',
  `tokenname` text NOT NULL,
  PRIMARY KEY (`tokenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipmentcharges`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipmentcharges` (
  `shiptchgid` int(11) NOT NULL AUTO_INCREMENT,
  `shiptref` int(11) NOT NULL DEFAULT '0',
  `transtype` smallint(6) NOT NULL DEFAULT '0',
  `transno` int(11) NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `value` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`shiptchgid`),
  KEY `TransType` (`transtype`,`transno`),
  KEY `ShiptRef` (`shiptref`),
  KEY `StockID` (`stockid`),
  KEY `TransType_2` (`transtype`),
  CONSTRAINT `shipmentcharges_ibfk_1` FOREIGN KEY (`shiptref`) REFERENCES `shipments` (`shiptref`),
  CONSTRAINT `shipmentcharges_ibfk_2` FOREIGN KEY (`transtype`) REFERENCES `systypes` (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipments`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipments` (
  `shiptref` int(11) NOT NULL DEFAULT '0',
  `voyageref` varchar(20) NOT NULL DEFAULT '0',
  `vessel` varchar(50) NOT NULL DEFAULT '',
  `eta` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `accumvalue` double NOT NULL DEFAULT '0',
  `supplierid` varchar(10) NOT NULL DEFAULT '',
  `closed` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`shiptref`),
  KEY `ETA` (`eta`),
  KEY `SupplierID` (`supplierid`),
  KEY `ShipperRef` (`voyageref`),
  KEY `Vessel` (`vessel`),
  CONSTRAINT `shipments_ibfk_1` FOREIGN KEY (`supplierid`) REFERENCES `suppliers` (`supplierid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shippers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shippers` (
  `shipper_id` int(11) NOT NULL AUTO_INCREMENT,
  `shippername` char(40) NOT NULL DEFAULT '',
  `mincharge` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`shipper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockcategory`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockcategory` (
  `categoryid` char(6) NOT NULL DEFAULT '',
  `categorydescription` char(20) NOT NULL DEFAULT '',
  `stocktype` char(1) NOT NULL DEFAULT 'F',
  `stockact` int(11) NOT NULL DEFAULT '0',
  `adjglact` int(11) NOT NULL DEFAULT '0',
  `issueglact` int(11) NOT NULL DEFAULT '0',
  `purchpricevaract` int(11) NOT NULL DEFAULT '80000',
  `materialuseagevarac` int(11) NOT NULL DEFAULT '80000',
  `wipact` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`categoryid`),
  KEY `CategoryDescription` (`categorydescription`),
  KEY `StockType` (`stocktype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockcatproperties`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockcatproperties` (
  `stkcatpropid` int(11) NOT NULL AUTO_INCREMENT,
  `categoryid` char(6) NOT NULL,
  `label` text NOT NULL,
  `controltype` tinyint(4) NOT NULL DEFAULT '0',
  `defaultvalue` varchar(100) NOT NULL DEFAULT '''''',
  `maximumvalue` double NOT NULL DEFAULT '999999999',
  `reqatsalesorder` tinyint(4) NOT NULL DEFAULT '0',
  `minimumvalue` double NOT NULL DEFAULT '-999999999',
  `numericvalue` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`stkcatpropid`),
  KEY `categoryid` (`categoryid`),
  CONSTRAINT `stockcatproperties_ibfk_1` FOREIGN KEY (`categoryid`) REFERENCES `stockcategory` (`categoryid`),
  CONSTRAINT `stockcatproperties_ibfk_2` FOREIGN KEY (`categoryid`) REFERENCES `stockcategory` (`categoryid`),
  CONSTRAINT `stockcatproperties_ibfk_3` FOREIGN KEY (`categoryid`) REFERENCES `stockcategory` (`categoryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockcheckfreeze`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockcheckfreeze` (
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `qoh` double NOT NULL DEFAULT '0',
  `stockcheckdate` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`stockid`,`loccode`),
  KEY `LocCode` (`loccode`),
  CONSTRAINT `stockcheckfreeze_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockcheckfreeze_ibfk_2` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockcounts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockcounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `qtycounted` double NOT NULL DEFAULT '0',
  `reference` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `StockID` (`stockid`),
  KEY `LocCode` (`loccode`),
  CONSTRAINT `stockcounts_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockcounts_ibfk_2` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockitemproperties`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockitemproperties` (
  `stockid` varchar(20) NOT NULL,
  `stkcatpropid` int(11) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`stockid`,`stkcatpropid`),
  KEY `stockid` (`stockid`),
  KEY `value` (`value`),
  KEY `stkcatpropid` (`stkcatpropid`),
  CONSTRAINT `stockitemproperties_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockitemproperties_ibfk_2` FOREIGN KEY (`stkcatpropid`) REFERENCES `stockcatproperties` (`stkcatpropid`),
  CONSTRAINT `stockitemproperties_ibfk_3` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockitemproperties_ibfk_4` FOREIGN KEY (`stkcatpropid`) REFERENCES `stockcatproperties` (`stkcatpropid`),
  CONSTRAINT `stockitemproperties_ibfk_5` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockitemproperties_ibfk_6` FOREIGN KEY (`stkcatpropid`) REFERENCES `stockcatproperties` (`stkcatpropid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockmaster`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockmaster` (
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `categoryid` varchar(6) NOT NULL DEFAULT '',
  `description` varchar(50) NOT NULL DEFAULT '',
  `longdescription` text NOT NULL,
  `units` varchar(20) NOT NULL DEFAULT 'each',
  `mbflag` char(1) NOT NULL DEFAULT 'B',
  `actualcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `lastcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `materialcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `labourcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `overheadcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `lowestlevel` smallint(6) NOT NULL DEFAULT '0',
  `discontinued` tinyint(4) NOT NULL DEFAULT '0',
  `controlled` tinyint(4) NOT NULL DEFAULT '0',
  `eoq` double NOT NULL DEFAULT '0',
  `volume` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `kgs` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `barcode` varchar(50) NOT NULL DEFAULT '',
  `discountcategory` char(2) NOT NULL DEFAULT '',
  `taxcatid` tinyint(4) NOT NULL DEFAULT '1',
  `serialised` tinyint(4) NOT NULL DEFAULT '0',
  `appendfile` varchar(40) NOT NULL DEFAULT 'none',
  `perishable` tinyint(1) NOT NULL DEFAULT '0',
  `decimalplaces` tinyint(4) NOT NULL DEFAULT '0',
  `pansize` double NOT NULL DEFAULT '0',
  `shrinkfactor` double NOT NULL DEFAULT '0',
  `nextserialno` bigint(20) NOT NULL DEFAULT '0',
  `netweight` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `lastcostupdate` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`stockid`),
  KEY `CategoryID` (`categoryid`),
  KEY `Description` (`description`),
  KEY `MBflag` (`mbflag`),
  KEY `StockID` (`stockid`,`categoryid`),
  KEY `Controlled` (`controlled`),
  KEY `DiscountCategory` (`discountcategory`),
  KEY `taxcatid` (`taxcatid`),
  CONSTRAINT `stockmaster_ibfk_1` FOREIGN KEY (`categoryid`) REFERENCES `stockcategory` (`categoryid`),
  CONSTRAINT `stockmaster_ibfk_2` FOREIGN KEY (`taxcatid`) REFERENCES `taxcategories` (`taxcatid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockmoves`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockmoves` (
  `stkmoveno` int(11) NOT NULL AUTO_INCREMENT,
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `type` smallint(6) NOT NULL DEFAULT '0',
  `transno` int(11) NOT NULL DEFAULT '0',
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `trandate` date NOT NULL DEFAULT '0000-00-00',
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `price` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `prd` smallint(6) NOT NULL DEFAULT '0',
  `reference` varchar(40) NOT NULL DEFAULT '',
  `qty` double NOT NULL DEFAULT '1',
  `discountpercent` double NOT NULL DEFAULT '0',
  `standardcost` double NOT NULL DEFAULT '0',
  `show_on_inv_crds` tinyint(4) NOT NULL DEFAULT '1',
  `newqoh` double NOT NULL DEFAULT '0',
  `hidemovt` tinyint(4) NOT NULL DEFAULT '0',
  `narrative` text,
  PRIMARY KEY (`stkmoveno`),
  KEY `DebtorNo` (`debtorno`),
  KEY `LocCode` (`loccode`),
  KEY `Prd` (`prd`),
  KEY `StockID_2` (`stockid`),
  KEY `TranDate` (`trandate`),
  KEY `TransNo` (`transno`),
  KEY `Type` (`type`),
  KEY `Show_On_Inv_Crds` (`show_on_inv_crds`),
  KEY `Hide` (`hidemovt`),
  KEY `reference` (`reference`),
  CONSTRAINT `stockmoves_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockmoves_ibfk_2` FOREIGN KEY (`type`) REFERENCES `systypes` (`typeid`),
  CONSTRAINT `stockmoves_ibfk_3` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `stockmoves_ibfk_4` FOREIGN KEY (`prd`) REFERENCES `periods` (`periodno`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockmovestaxes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockmovestaxes` (
  `stkmoveno` int(11) NOT NULL DEFAULT '0',
  `taxauthid` tinyint(4) NOT NULL DEFAULT '0',
  `taxrate` double NOT NULL DEFAULT '0',
  `taxontax` tinyint(4) NOT NULL DEFAULT '0',
  `taxcalculationorder` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`stkmoveno`,`taxauthid`),
  KEY `taxauthid` (`taxauthid`),
  KEY `calculationorder` (`taxcalculationorder`),
  CONSTRAINT `stockmovestaxes_ibfk_1` FOREIGN KEY (`taxauthid`) REFERENCES `taxauthorities` (`taxid`),
  CONSTRAINT `stockmovestaxes_ibfk_2` FOREIGN KEY (`stkmoveno`) REFERENCES `stockmoves` (`stkmoveno`),
  CONSTRAINT `stockmovestaxes_ibfk_3` FOREIGN KEY (`stkmoveno`) REFERENCES `stockmoves` (`stkmoveno`),
  CONSTRAINT `stockmovestaxes_ibfk_4` FOREIGN KEY (`stkmoveno`) REFERENCES `stockmoves` (`stkmoveno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockrequest`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockrequest` (
  `dispatchid` int(11) NOT NULL AUTO_INCREMENT,
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `departmentid` int(11) NOT NULL DEFAULT '0',
  `despatchdate` date NOT NULL DEFAULT '0000-00-00',
  `authorised` tinyint(4) NOT NULL DEFAULT '0',
  `closed` tinyint(4) NOT NULL DEFAULT '0',
  `narrative` text NOT NULL,
  PRIMARY KEY (`dispatchid`),
  KEY `loccode` (`loccode`),
  KEY `departmentid` (`departmentid`),
  KEY `loccode_2` (`loccode`),
  KEY `departmentid_2` (`departmentid`),
  CONSTRAINT `stockrequest_ibfk_1` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `stockrequest_ibfk_2` FOREIGN KEY (`departmentid`) REFERENCES `departments` (`departmentid`),
  CONSTRAINT `stockrequest_ibfk_3` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `stockrequest_ibfk_4` FOREIGN KEY (`departmentid`) REFERENCES `departments` (`departmentid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockrequestitems`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockrequestitems` (
  `dispatchitemsid` int(11) NOT NULL DEFAULT '0',
  `dispatchid` int(11) NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `quantity` double NOT NULL DEFAULT '0',
  `qtydelivered` double NOT NULL DEFAULT '0',
  `decimalplaces` int(11) NOT NULL DEFAULT '0',
  `uom` varchar(20) NOT NULL DEFAULT '',
  `completed` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dispatchitemsid`),
  KEY `dispatchid` (`dispatchid`),
  KEY `stockid` (`stockid`),
  KEY `dispatchid_2` (`dispatchid`),
  KEY `stockid_2` (`stockid`),
  CONSTRAINT `stockrequestitems_ibfk_1` FOREIGN KEY (`dispatchid`) REFERENCES `stockrequest` (`dispatchid`),
  CONSTRAINT `stockrequestitems_ibfk_2` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockrequestitems_ibfk_3` FOREIGN KEY (`dispatchid`) REFERENCES `stockrequest` (`dispatchid`),
  CONSTRAINT `stockrequestitems_ibfk_4` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockserialitems`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockserialitems` (
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `serialno` varchar(30) NOT NULL DEFAULT '',
  `expirationdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `quantity` double NOT NULL DEFAULT '0',
  `qualitytext` text NOT NULL,
  PRIMARY KEY (`stockid`,`serialno`,`loccode`),
  KEY `StockID` (`stockid`),
  KEY `LocCode` (`loccode`),
  KEY `serialno` (`serialno`),
  CONSTRAINT `stockserialitems_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockserialitems_ibfk_2` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockserialmoves`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockserialmoves` (
  `stkitmmoveno` int(11) NOT NULL AUTO_INCREMENT,
  `stockmoveno` int(11) NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `serialno` varchar(30) NOT NULL DEFAULT '',
  `moveqty` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`stkitmmoveno`),
  KEY `StockMoveNo` (`stockmoveno`),
  KEY `StockID_SN` (`stockid`,`serialno`),
  KEY `serialno` (`serialno`),
  CONSTRAINT `stockserialmoves_ibfk_1` FOREIGN KEY (`stockmoveno`) REFERENCES `stockmoves` (`stkmoveno`),
  CONSTRAINT `stockserialmoves_ibfk_2` FOREIGN KEY (`stockid`, `serialno`) REFERENCES `stockserialitems` (`stockid`, `serialno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suppallocs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suppallocs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amt` double NOT NULL DEFAULT '0',
  `datealloc` date NOT NULL DEFAULT '0000-00-00',
  `transid_allocfrom` int(11) NOT NULL DEFAULT '0',
  `transid_allocto` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `TransID_AllocFrom` (`transid_allocfrom`),
  KEY `TransID_AllocTo` (`transid_allocto`),
  KEY `DateAlloc` (`datealloc`),
  CONSTRAINT `suppallocs_ibfk_1` FOREIGN KEY (`transid_allocfrom`) REFERENCES `supptrans` (`id`),
  CONSTRAINT `suppallocs_ibfk_2` FOREIGN KEY (`transid_allocto`) REFERENCES `supptrans` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suppliercontacts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suppliercontacts` (
  `supplierid` varchar(10) NOT NULL DEFAULT '',
  `contact` varchar(30) NOT NULL DEFAULT '',
  `position` varchar(30) NOT NULL DEFAULT '',
  `tel` varchar(30) NOT NULL DEFAULT '',
  `fax` varchar(30) NOT NULL DEFAULT '',
  `mobile` varchar(30) NOT NULL DEFAULT '',
  `email` varchar(55) NOT NULL DEFAULT '',
  `ordercontact` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`supplierid`,`contact`),
  KEY `Contact` (`contact`),
  KEY `SupplierID` (`supplierid`),
  CONSTRAINT `suppliercontacts_ibfk_1` FOREIGN KEY (`supplierid`) REFERENCES `suppliers` (`supplierid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suppliers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suppliers` (
  `supplierid` varchar(10) NOT NULL DEFAULT '',
  `suppname` varchar(40) NOT NULL DEFAULT '',
  `address1` varchar(40) NOT NULL DEFAULT '',
  `address2` varchar(40) NOT NULL DEFAULT '',
  `address3` varchar(40) NOT NULL DEFAULT '',
  `address4` varchar(50) NOT NULL DEFAULT '',
  `address5` varchar(20) NOT NULL DEFAULT '',
  `address6` varchar(40) NOT NULL DEFAULT '',
  `supptype` tinyint(4) NOT NULL DEFAULT '1',
  `lat` float(10,6) NOT NULL DEFAULT '0.000000',
  `lng` float(10,6) NOT NULL DEFAULT '0.000000',
  `currcode` char(3) NOT NULL DEFAULT '',
  `suppliersince` date NOT NULL DEFAULT '0000-00-00',
  `paymentterms` char(2) NOT NULL DEFAULT '',
  `lastpaid` double NOT NULL DEFAULT '0',
  `lastpaiddate` datetime DEFAULT NULL,
  `bankact` varchar(30) NOT NULL DEFAULT '',
  `bankref` varchar(12) NOT NULL DEFAULT '',
  `bankpartics` varchar(12) NOT NULL DEFAULT '',
  `remittance` tinyint(4) NOT NULL DEFAULT '1',
  `taxgroupid` tinyint(4) NOT NULL DEFAULT '1',
  `factorcompanyid` int(11) NOT NULL DEFAULT '1',
  `taxref` varchar(20) NOT NULL DEFAULT '',
  `phn` varchar(50) NOT NULL DEFAULT '',
  `port` varchar(200) NOT NULL DEFAULT '',
  `email` varchar(55) DEFAULT NULL,
  `fax` varchar(25) DEFAULT NULL,
  `telephone` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`supplierid`),
  KEY `CurrCode` (`currcode`),
  KEY `PaymentTerms` (`paymentterms`),
  KEY `SuppName` (`suppname`),
  KEY `taxgroupid` (`taxgroupid`),
  CONSTRAINT `suppliers_ibfk_1` FOREIGN KEY (`currcode`) REFERENCES `currencies` (`currabrev`),
  CONSTRAINT `suppliers_ibfk_2` FOREIGN KEY (`paymentterms`) REFERENCES `paymentterms` (`termsindicator`),
  CONSTRAINT `suppliers_ibfk_3` FOREIGN KEY (`taxgroupid`) REFERENCES `taxgroups` (`taxgroupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suppliertype`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suppliertype` (
  `typeid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `typename` varchar(100) NOT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supptrans`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supptrans` (
  `transno` int(11) NOT NULL DEFAULT '0',
  `type` smallint(6) NOT NULL DEFAULT '0',
  `supplierno` varchar(10) NOT NULL DEFAULT '',
  `suppreference` varchar(20) NOT NULL DEFAULT '',
  `trandate` date NOT NULL DEFAULT '0000-00-00',
  `duedate` date NOT NULL DEFAULT '0000-00-00',
  `inputdate` datetime NOT NULL,
  `settled` tinyint(4) NOT NULL DEFAULT '0',
  `rate` double NOT NULL DEFAULT '1',
  `ovamount` double NOT NULL DEFAULT '0',
  `ovgst` double NOT NULL DEFAULT '0',
  `diffonexch` double NOT NULL DEFAULT '0',
  `alloc` double NOT NULL DEFAULT '0',
  `transtext` text,
  `hold` tinyint(4) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `TypeTransNo` (`transno`,`type`),
  KEY `DueDate` (`duedate`),
  KEY `Hold` (`hold`),
  KEY `SupplierNo` (`supplierno`),
  KEY `Settled` (`settled`),
  KEY `SupplierNo_2` (`supplierno`,`suppreference`),
  KEY `SuppReference` (`suppreference`),
  KEY `TranDate` (`trandate`),
  KEY `TransNo` (`transno`),
  KEY `Type` (`type`),
  CONSTRAINT `supptrans_ibfk_1` FOREIGN KEY (`type`) REFERENCES `systypes` (`typeid`),
  CONSTRAINT `supptrans_ibfk_2` FOREIGN KEY (`supplierno`) REFERENCES `suppliers` (`supplierid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supptranstaxes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supptranstaxes` (
  `supptransid` int(11) NOT NULL DEFAULT '0',
  `taxauthid` tinyint(4) NOT NULL DEFAULT '0',
  `taxamount` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`supptransid`,`taxauthid`),
  KEY `taxauthid` (`taxauthid`),
  CONSTRAINT `supptranstaxes_ibfk_1` FOREIGN KEY (`taxauthid`) REFERENCES `taxauthorities` (`taxid`),
  CONSTRAINT `supptranstaxes_ibfk_2` FOREIGN KEY (`supptransid`) REFERENCES `supptrans` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systypes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systypes` (
  `typeid` smallint(6) NOT NULL DEFAULT '0',
  `typename` char(50) NOT NULL DEFAULT '',
  `typeno` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`typeid`),
  KEY `TypeNo` (`typeno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `tagref` tinyint(4) NOT NULL AUTO_INCREMENT,
  `tagdescription` varchar(50) NOT NULL,
  PRIMARY KEY (`tagref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxauthorities`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxauthorities` (
  `taxid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `description` varchar(40) NOT NULL DEFAULT '',
  `taxglcode` varchar(20) NOT NULL DEFAULT '0',
  `purchtaxglaccount` varchar(20) NOT NULL DEFAULT '0',
  `bank` varchar(50) NOT NULL DEFAULT '',
  `bankacctype` varchar(20) NOT NULL DEFAULT '',
  `bankacc` varchar(50) NOT NULL DEFAULT '',
  `bankswift` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`taxid`),
  KEY `TaxGLCode` (`taxglcode`),
  KEY `PurchTaxGLAccount` (`purchtaxglaccount`),
  CONSTRAINT `taxauthorities_ibfk_1` FOREIGN KEY (`taxglcode`) REFERENCES `chartmaster` (`accountcode`),
  CONSTRAINT `taxauthorities_ibfk_2` FOREIGN KEY (`purchtaxglaccount`) REFERENCES `chartmaster` (`accountcode`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxauthrates`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxauthrates` (
  `taxauthority` tinyint(4) NOT NULL DEFAULT '1',
  `dispatchtaxprovince` tinyint(4) NOT NULL DEFAULT '1',
  `taxcatid` tinyint(4) NOT NULL DEFAULT '0',
  `taxrate` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`taxauthority`,`dispatchtaxprovince`,`taxcatid`),
  KEY `TaxAuthority` (`taxauthority`),
  KEY `dispatchtaxprovince` (`dispatchtaxprovince`),
  KEY `taxcatid` (`taxcatid`),
  CONSTRAINT `taxauthrates_ibfk_1` FOREIGN KEY (`taxauthority`) REFERENCES `taxauthorities` (`taxid`),
  CONSTRAINT `taxauthrates_ibfk_2` FOREIGN KEY (`taxcatid`) REFERENCES `taxcategories` (`taxcatid`),
  CONSTRAINT `taxauthrates_ibfk_3` FOREIGN KEY (`dispatchtaxprovince`) REFERENCES `taxprovinces` (`taxprovinceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxcategories`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxcategories` (
  `taxcatid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `taxcatname` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`taxcatid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxgroups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxgroups` (
  `taxgroupid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `taxgroupdescription` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`taxgroupid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxgrouptaxes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxgrouptaxes` (
  `taxgroupid` tinyint(4) NOT NULL DEFAULT '0',
  `taxauthid` tinyint(4) NOT NULL DEFAULT '0',
  `calculationorder` tinyint(4) NOT NULL DEFAULT '0',
  `taxontax` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`taxgroupid`,`taxauthid`),
  KEY `taxgroupid` (`taxgroupid`),
  KEY `taxauthid` (`taxauthid`),
  CONSTRAINT `taxgrouptaxes_ibfk_1` FOREIGN KEY (`taxgroupid`) REFERENCES `taxgroups` (`taxgroupid`),
  CONSTRAINT `taxgrouptaxes_ibfk_2` FOREIGN KEY (`taxauthid`) REFERENCES `taxauthorities` (`taxid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxprovinces`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxprovinces` (
  `taxprovinceid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `taxprovincename` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`taxprovinceid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tenderitems`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tenderitems` (
  `tenderid` int(11) NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `quantity` varchar(40) NOT NULL DEFAULT '',
  `units` varchar(20) NOT NULL DEFAULT 'each',
  PRIMARY KEY (`tenderid`,`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tenders`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tenders` (
  `tenderid` int(11) NOT NULL DEFAULT '0',
  `location` varchar(5) NOT NULL DEFAULT '',
  `address1` varchar(40) NOT NULL DEFAULT '',
  `address2` varchar(40) NOT NULL DEFAULT '',
  `address3` varchar(40) NOT NULL DEFAULT '',
  `address4` varchar(40) NOT NULL DEFAULT '',
  `address5` varchar(20) NOT NULL DEFAULT '',
  `address6` varchar(15) NOT NULL DEFAULT '',
  `telephone` varchar(25) NOT NULL DEFAULT '',
  `closed` int(2) NOT NULL DEFAULT '0',
  `requiredbydate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`tenderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tendersuppliers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tendersuppliers` (
  `tenderid` int(11) NOT NULL DEFAULT '0',
  `supplierid` varchar(10) NOT NULL DEFAULT '',
  `email` varchar(40) NOT NULL DEFAULT '',
  `responded` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tenderid`,`supplierid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unitsofmeasure`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unitsofmeasure` (
  `unitid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `unitname` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`unitid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `woitems`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `woitems` (
  `wo` int(11) NOT NULL,
  `stockid` char(20) NOT NULL DEFAULT '',
  `qtyreqd` double NOT NULL DEFAULT '1',
  `qtyrecd` double NOT NULL DEFAULT '0',
  `stdcost` double NOT NULL,
  `nextlotsnref` varchar(20) DEFAULT '',
  PRIMARY KEY (`wo`,`stockid`),
  KEY `stockid` (`stockid`),
  CONSTRAINT `woitems_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `woitems_ibfk_2` FOREIGN KEY (`wo`) REFERENCES `workorders` (`wo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `worequirements`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `worequirements` (
  `wo` int(11) NOT NULL,
  `parentstockid` varchar(20) NOT NULL,
  `stockid` varchar(20) NOT NULL,
  `qtypu` double NOT NULL DEFAULT '1',
  `stdcost` double NOT NULL DEFAULT '0',
  `autoissue` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`wo`,`parentstockid`,`stockid`),
  KEY `stockid` (`stockid`),
  KEY `worequirements_ibfk_3` (`parentstockid`),
  CONSTRAINT `worequirements_ibfk_1` FOREIGN KEY (`wo`) REFERENCES `workorders` (`wo`),
  CONSTRAINT `worequirements_ibfk_2` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `worequirements_ibfk_3` FOREIGN KEY (`wo`, `parentstockid`) REFERENCES `woitems` (`wo`, `stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `workcentres`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workcentres` (
  `code` char(5) NOT NULL DEFAULT '',
  `location` char(5) NOT NULL DEFAULT '',
  `description` char(20) NOT NULL DEFAULT '',
  `capacity` double NOT NULL DEFAULT '1',
  `overheadperhour` decimal(10,0) NOT NULL DEFAULT '0',
  `overheadrecoveryact` int(11) NOT NULL DEFAULT '0',
  `setuphrs` decimal(10,0) NOT NULL DEFAULT '0',
  PRIMARY KEY (`code`),
  KEY `Description` (`description`),
  KEY `Location` (`location`),
  CONSTRAINT `workcentres_ibfk_1` FOREIGN KEY (`location`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `workorders`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workorders` (
  `wo` int(11) NOT NULL,
  `loccode` char(5) NOT NULL DEFAULT '',
  `requiredby` date NOT NULL DEFAULT '0000-00-00',
  `startdate` date NOT NULL DEFAULT '0000-00-00',
  `costissued` double NOT NULL DEFAULT '0',
  `closed` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`wo`),
  KEY `LocCode` (`loccode`),
  KEY `StartDate` (`startdate`),
  KEY `RequiredBy` (`requiredby`),
  CONSTRAINT `worksorders_ibfk_1` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `woserialnos`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `woserialnos` (
  `wo` int(11) NOT NULL,
  `stockid` varchar(20) NOT NULL,
  `serialno` varchar(30) NOT NULL,
  `quantity` double NOT NULL DEFAULT '1',
  `qualitytext` text NOT NULL,
  PRIMARY KEY (`wo`,`stockid`,`serialno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `www_users`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `www_users` (
  `userid` varchar(20) NOT NULL DEFAULT '',
  `password` text NOT NULL,
  `realname` varchar(35) NOT NULL DEFAULT '',
  `customerid` varchar(10) NOT NULL DEFAULT '',
  `supplierid` varchar(10) NOT NULL DEFAULT '',
  `salesman` char(3) NOT NULL,
  `phone` varchar(30) NOT NULL DEFAULT '',
  `email` varchar(55) DEFAULT NULL,
  `defaultlocation` varchar(5) NOT NULL DEFAULT '',
  `fullaccess` int(11) NOT NULL DEFAULT '1',
  `cancreatetender` tinyint(1) NOT NULL DEFAULT '0',
  `lastvisitdate` datetime DEFAULT NULL,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `pagesize` varchar(20) NOT NULL DEFAULT 'A4',
  `modulesallowed` varchar(40) NOT NULL DEFAULT '',
  `blocked` tinyint(4) NOT NULL DEFAULT '0',
  `displayrecordsmax` int(11) NOT NULL DEFAULT '0',
  `theme` varchar(30) NOT NULL DEFAULT 'fresh',
  `language` varchar(10) NOT NULL DEFAULT 'en_GB.utf8',
  `pdflanguage` tinyint(1) NOT NULL DEFAULT '0',
  `department` int(11) NOT NULL DEFAULT '0',
  `fontsize` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`),
  KEY `CustomerID` (`customerid`),
  KEY `DefaultLocation` (`defaultlocation`),
  CONSTRAINT `www_users_ibfk_1` FOREIGN KEY (`defaultlocation`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-01-25 10:39:53
-- MySQL dump 10.14  Distrib 10.0.0-MariaDB, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: kwamoja
-- ------------------------------------------------------
-- Server version	10.0.0-MariaDB-mariadb1~precise-log
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `accountgroups`
--

INSERT INTO `accountgroups` VALUES ('BBQs',5,1,6000,'Promotion Overheads');
INSERT INTO `accountgroups` VALUES ('Cost of Goods Sold',2,1,5000,'');
INSERT INTO `accountgroups` VALUES ('Current Assets',20,0,1000,'');
INSERT INTO `accountgroups` VALUES ('Equity',50,0,3000,'');
INSERT INTO `accountgroups` VALUES ('Fixed Assets',10,0,500,'');
INSERT INTO `accountgroups` VALUES ('Giveaways',5,1,6000,'Promotion Overheads');
INSERT INTO `accountgroups` VALUES ('Income Tax',5,1,9000,'');
INSERT INTO `accountgroups` VALUES ('Liabilities',30,0,2000,'');
INSERT INTO `accountgroups` VALUES ('Marketing Expenses',5,1,6000,'');
INSERT INTO `accountgroups` VALUES ('Operating Overheads',5,1,7000,'');
INSERT INTO `accountgroups` VALUES ('Other Revenue and Expenses',5,1,8000,'');
INSERT INTO `accountgroups` VALUES ('Outward Freight',2,1,5000,'Cost of Goods Sold');
INSERT INTO `accountgroups` VALUES ('Promotion Overheads',5,1,6000,'Marketing Expenses');
INSERT INTO `accountgroups` VALUES ('Revenue',1,1,4000,'');
INSERT INTO `accountgroups` VALUES ('Sales',1,1,10,'');

--
-- Dumping data for table `bankaccounts`
--

INSERT INTO `bankaccounts` VALUES ('1030','KES',1,'','Cheque Account','1','');
INSERT INTO `bankaccounts` VALUES ('1040','KES',0,'','Savings Account','2','');

--
-- Dumping data for table `chartmaster`
--

INSERT INTO `chartmaster` VALUES ('1','Default Sales/Discounts','Sales');
INSERT INTO `chartmaster` VALUES ('1010','Petty Cash','Current Assets');
INSERT INTO `chartmaster` VALUES ('1020','Cash on Hand','Current Assets');
INSERT INTO `chartmaster` VALUES ('1030','Cheque Accounts','Current Assets');
INSERT INTO `chartmaster` VALUES ('1040','Savings Accounts','Current Assets');
INSERT INTO `chartmaster` VALUES ('1050','Payroll Accounts','Current Assets');
INSERT INTO `chartmaster` VALUES ('1060','Special Accounts','Current Assets');
INSERT INTO `chartmaster` VALUES ('1070','Money Market Investments','Current Assets');
INSERT INTO `chartmaster` VALUES ('1080','Short-Term Investments (< 90 days)','Current Assets');
INSERT INTO `chartmaster` VALUES ('1090','Interest Receivable','Current Assets');
INSERT INTO `chartmaster` VALUES ('1100','Accounts Receivable','Current Assets');
INSERT INTO `chartmaster` VALUES ('1150','Allowance for Doubtful Accounts','Current Assets');
INSERT INTO `chartmaster` VALUES ('1200','Notes Receivable','Current Assets');
INSERT INTO `chartmaster` VALUES ('1250','Income Tax Receivable','Current Assets');
INSERT INTO `chartmaster` VALUES ('1300','Prepaid Expenses','Current Assets');
INSERT INTO `chartmaster` VALUES ('1350','Advances','Current Assets');
INSERT INTO `chartmaster` VALUES ('1400','Supplies Inventory','Current Assets');
INSERT INTO `chartmaster` VALUES ('1420','Raw Material Inventory','Current Assets');
INSERT INTO `chartmaster` VALUES ('1440','Work in Progress Inventory','Current Assets');
INSERT INTO `chartmaster` VALUES ('1460','Finished Goods Inventory','Current Assets');
INSERT INTO `chartmaster` VALUES ('1500','Land','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1550','Bonds','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1600','Buildings','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1620','Accumulated Depreciation of Buildings','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1650','Equipment','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1670','Accumulated Depreciation of Equipment','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1700','Furniture & Fixtures','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1710','Accumulated Depreciation of Furniture & Fixtures','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1720','Office Equipment','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1730','Accumulated Depreciation of Office Equipment','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1740','Software','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1750','Accumulated Depreciation of Software','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1760','Vehicles','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1770','Accumulated Depreciation Vehicles','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1780','Other Depreciable Property','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1790','Accumulated Depreciation of Other Depreciable Prop','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1800','Patents','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1850','Goodwill','Fixed Assets');
INSERT INTO `chartmaster` VALUES ('1900','Future Income Tax Receivable','Current Assets');
INSERT INTO `chartmaster` VALUES ('2010','Bank Indedebtedness (overdraft)','Liabilities');
INSERT INTO `chartmaster` VALUES ('2020','Retainers or Advances on Work','Liabilities');
INSERT INTO `chartmaster` VALUES ('2050','Interest Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2100','Accounts Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2150','Goods Received Suspense','Liabilities');
INSERT INTO `chartmaster` VALUES ('2200','Short-Term Loan Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2230','Current Portion of Long-Term Debt Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2250','Income Tax Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2300','GST Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2310','GST Recoverable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2320','PST Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2330','PST Recoverable (commission)','Liabilities');
INSERT INTO `chartmaster` VALUES ('2340','Payroll Tax Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2350','Withholding Income Tax Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2360','Other Taxes Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2400','Employee Salaries Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2410','Management Salaries Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2420','Director / Partner Fees Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2450','Health Benefits Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2460','Pension Benefits Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2470','Canada Pension Plan Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2480','Employment Insurance Premiums Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2500','Land Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2550','Long-Term Bank Loan','Liabilities');
INSERT INTO `chartmaster` VALUES ('2560','Notes Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2600','Building & Equipment Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2700','Furnishing & Fixture Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2720','Office Equipment Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2740','Vehicle Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2760','Other Property Payable','Liabilities');
INSERT INTO `chartmaster` VALUES ('2800','Shareholder Loans','Liabilities');
INSERT INTO `chartmaster` VALUES ('2900','Suspense','Liabilities');
INSERT INTO `chartmaster` VALUES ('3100','Capital Stock','Equity');
INSERT INTO `chartmaster` VALUES ('3200','Capital Surplus / Dividends','Equity');
INSERT INTO `chartmaster` VALUES ('3300','Dividend Taxes Payable','Equity');
INSERT INTO `chartmaster` VALUES ('3400','Dividend Taxes Refundable','Equity');
INSERT INTO `chartmaster` VALUES ('3500','Retained Earnings','Equity');
INSERT INTO `chartmaster` VALUES ('4100','Product / Service Sales','Revenue');
INSERT INTO `chartmaster` VALUES ('4200','Sales Exchange Gains/Losses','Revenue');
INSERT INTO `chartmaster` VALUES ('4500','Consulting Services','Revenue');
INSERT INTO `chartmaster` VALUES ('4600','Rentals','Revenue');
INSERT INTO `chartmaster` VALUES ('4700','Finance Charge Income','Revenue');
INSERT INTO `chartmaster` VALUES ('4800','Sales Returns & Allowances','Revenue');
INSERT INTO `chartmaster` VALUES ('4900','Sales Discounts','Revenue');
INSERT INTO `chartmaster` VALUES ('5000','Cost of Sales','Cost of Goods Sold');
INSERT INTO `chartmaster` VALUES ('5100','Production Expenses','Cost of Goods Sold');
INSERT INTO `chartmaster` VALUES ('5200','Purchases Exchange Gains/Losses','Cost of Goods Sold');
INSERT INTO `chartmaster` VALUES ('5500','Direct Labour Costs','Cost of Goods Sold');
INSERT INTO `chartmaster` VALUES ('5600','Freight Charges','Outward Freight');
INSERT INTO `chartmaster` VALUES ('5700','Inventory Adjustment','Cost of Goods Sold');
INSERT INTO `chartmaster` VALUES ('5800','Purchase Returns & Allowances','Cost of Goods Sold');
INSERT INTO `chartmaster` VALUES ('5900','Purchase Discounts','Cost of Goods Sold');
INSERT INTO `chartmaster` VALUES ('6005','Free Gifts','Giveaways');
INSERT INTO `chartmaster` VALUES ('6100','Advertising','Marketing Expenses');
INSERT INTO `chartmaster` VALUES ('6150','Promotion','Promotion Overheads');
INSERT INTO `chartmaster` VALUES ('6200','Communications','Marketing Expenses');
INSERT INTO `chartmaster` VALUES ('6250','Meeting Expenses','Marketing Expenses');
INSERT INTO `chartmaster` VALUES ('6300','Travelling Expenses','Marketing Expenses');
INSERT INTO `chartmaster` VALUES ('6400','Delivery Expenses','Marketing Expenses');
INSERT INTO `chartmaster` VALUES ('6500','Sales Salaries & Commission','Marketing Expenses');
INSERT INTO `chartmaster` VALUES ('6550','Sales Salaries & Commission Deductions','Marketing Expenses');
INSERT INTO `chartmaster` VALUES ('6590','Benefits','Marketing Expenses');
INSERT INTO `chartmaster` VALUES ('6600','Other Selling Expenses','Marketing Expenses');
INSERT INTO `chartmaster` VALUES ('6700','Permits, Licenses & License Fees','Marketing Expenses');
INSERT INTO `chartmaster` VALUES ('6800','Research & Development','Marketing Expenses');
INSERT INTO `chartmaster` VALUES ('6900','Professional Services','Marketing Expenses');
INSERT INTO `chartmaster` VALUES ('7020','Support Salaries & Wages','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7030','Support Salary & Wage Deductions','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7040','Management Salaries','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7050','Management Salary deductions','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7060','Director / Partner Fees','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7070','Director / Partner Deductions','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7080','Payroll Tax','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7090','Benefits','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7100','Training & Education Expenses','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7150','Dues & Subscriptions','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7200','Accounting Fees','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7210','Audit Fees','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7220','Banking Fees','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7230','Credit Card Fees','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7240','Consulting Fees','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7260','Legal Fees','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7280','Other Professional Fees','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7300','Business Tax','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7350','Property Tax','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7390','Corporation Capital Tax','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7400','Office Rent','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7450','Equipment Rental','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7500','Office Supplies','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7550','Office Repair & Maintenance','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7600','Automotive Expenses','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7610','Communication Expenses','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7620','Insurance Expenses','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7630','Postage & Courier Expenses','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7640','Miscellaneous Expenses','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7650','Travel Expenses','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7660','Utilities','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7700','Ammortization Expenses','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7750','Depreciation Expenses','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7800','Interest Expense','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('7900','Bad Debt Expense','Operating Overheads');
INSERT INTO `chartmaster` VALUES ('8100','Gain on Sale of Assets','Other Revenue and Expenses');
INSERT INTO `chartmaster` VALUES ('8200','Interest Income','Other Revenue and Expenses');
INSERT INTO `chartmaster` VALUES ('8300','Recovery on Bad Debt','Other Revenue and Expenses');
INSERT INTO `chartmaster` VALUES ('8400','Other Revenue','Other Revenue and Expenses');
INSERT INTO `chartmaster` VALUES ('8500','Loss on Sale of Assets','Other Revenue and Expenses');
INSERT INTO `chartmaster` VALUES ('8600','Charitable Contributions','Other Revenue and Expenses');
INSERT INTO `chartmaster` VALUES ('8900','Other Expenses','Other Revenue and Expenses');
INSERT INTO `chartmaster` VALUES ('9100','Income Tax Provision','Income Tax');

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` VALUES (1,'KwaMoja Demonstration Company Ltd','not entered yet','KE1234567890','Plot 8172','Kisanjani Road','Ganjoni','Mombasa','Kenya','East Africa','+61 3 4567 8901','+61 3 4567 8902','kwamoja@kwamojademo.com','KES',1100,4900,2100,2400,2150,4200,5200,3500,1,1,1,5600);

--
-- Dumping data for table `cogsglpostings`
--

INSERT INTO `cogsglpostings` VALUES (5,'AN','ANY',5000,'AN');

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` VALUES ('Kenya Shillings','KES','Kenya','Cent',0,1);
INSERT INTO `currencies` VALUES ('Rwanda Franc','RWF','Rwanda','Centime',2,7.328490000000001);
INSERT INTO `currencies` VALUES ('Tanzania Shillings','TZS','Tanzania','Cent',0,21.538461740000002);
INSERT INTO `currencies` VALUES ('Uganda Shillings','UGX','Uganda','Centavo',0,26.923077030000005);

--
-- Dumping data for table `holdreasons`
--

INSERT INTO `holdreasons` VALUES (1,'Good History',0);
INSERT INTO `holdreasons` VALUES (20,'Watch',0);
INSERT INTO `holdreasons` VALUES (51,'In liquidation',1);

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` VALUES ('MSA','Mombasa Main Warehouse',' ','','','','','','','','','',1,'',0,'',1);

--
-- Dumping data for table `paymentterms`
--

INSERT INTO `paymentterms` VALUES ('20','Due 20th Of the Following Month',0,22);
INSERT INTO `paymentterms` VALUES ('30','Due By End Of The Following Month',0,30);
INSERT INTO `paymentterms` VALUES ('7','Payment due within 7 days',7,0);
INSERT INTO `paymentterms` VALUES ('CA','Cash Only',2,0);

--
-- Dumping data for table `reportlinks`
--

INSERT INTO `reportlinks` VALUES ('accountgroups','accountsection','accountgroups.sectioninaccounts=accountsection.sectionid');
INSERT INTO `reportlinks` VALUES ('audittrail','www_users','audittrail.userid=www_users.userid');
INSERT INTO `reportlinks` VALUES ('bankaccounts','chartmaster','bankaccounts.accountcode=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('banktrans','systypes','banktrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('banktrans','bankaccounts','banktrans.bankact=bankaccounts.accountcode');
INSERT INTO `reportlinks` VALUES ('bom','stockmaster','bom.parent=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('bom','stockmaster','bom.component=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('bom','workcentres','bom.workcentreadded=workcentres.code');
INSERT INTO `reportlinks` VALUES ('bom','locations','bom.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('chartdetails','chartmaster','chartdetails.accountcode=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartdetails','periods','chartdetails.period=periods.periodno');
INSERT INTO `reportlinks` VALUES ('chartmaster','accountgroups','chartmaster.group_=accountgroups.groupname');
INSERT INTO `reportlinks` VALUES ('contractbom','workcentres','contractbom.workcentreadded=workcentres.code');
INSERT INTO `reportlinks` VALUES ('contractbom','stockmaster','contractbom.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('contractcharges','contracts','contractcharges.contractref=contracts.contractref');
INSERT INTO `reportlinks` VALUES ('contractcharges','systypes','contractcharges.transtype=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('contractreqts','contracts','contractreqts.contractref=contracts.contractref');
INSERT INTO `reportlinks` VALUES ('contracts','custbranch','contracts.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('contracts','custbranch','contracts.branchcode=custbranch.branchcode');
INSERT INTO `reportlinks` VALUES ('contracts','stockcategory','contracts.categoryid=stockcategory.categoryid');
INSERT INTO `reportlinks` VALUES ('contracts','locations','contracts.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('custallocns','debtortrans','custallocns.transid_allocfrom=debtortrans.id');
INSERT INTO `reportlinks` VALUES ('custallocns','debtortrans','custallocns.transid_allocto=debtortrans.id');
INSERT INTO `reportlinks` VALUES ('custbranch','debtorsmaster','custbranch.debtorno=debtorsmaster.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','areas','custbranch.area=areas.areacode');
INSERT INTO `reportlinks` VALUES ('custbranch','salesman','custbranch.salesman=salesman.salesmancode');
INSERT INTO `reportlinks` VALUES ('custbranch','locations','custbranch.defaultlocation=locations.loccode');
INSERT INTO `reportlinks` VALUES ('custbranch','shippers','custbranch.defaultshipvia=shippers.shipper_id');
INSERT INTO `reportlinks` VALUES ('custbranch','taxgroups','custbranch.taxgroupid=taxgroups.taxgroupid');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','holdreasons','debtorsmaster.holdreason=holdreasons.reasoncode');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','currencies','debtorsmaster.currcode=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','paymentterms','debtorsmaster.paymentterms=paymentterms.termsindicator');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','salestypes','debtorsmaster.salestype=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','debtortype','debtorsmaster.typeid=debtortype.typeid');
INSERT INTO `reportlinks` VALUES ('debtortrans','systypes','debtortrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('debtortrans','periods','debtortrans.prd=periods.periodno');
INSERT INTO `reportlinks` VALUES ('debtortranstaxes','taxauthorities','debtortranstaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('debtortranstaxes','debtortrans','debtortranstaxes.debtortransid=debtortrans.id');
INSERT INTO `reportlinks` VALUES ('deliverynotes','salesorders','deliverynotes.salesorderno=salesorders.orderno');
INSERT INTO `reportlinks` VALUES ('deliverynotes','salesorderdetails','deliverynotes.salesorderno=salesorderdetails.orderno');
INSERT INTO `reportlinks` VALUES ('deliverynotes','salesorderdetails','deliverynotes.salesorderlineno=salesorderdetails.orderlineno');
INSERT INTO `reportlinks` VALUES ('discountmatrix','salestypes','discountmatrix.salestype=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('freightcosts','locations','freightcosts.locationfrom=locations.loccode');
INSERT INTO `reportlinks` VALUES ('freightcosts','shippers','freightcosts.shipperid=shippers.shipper_id');
INSERT INTO `reportlinks` VALUES ('gltrans','chartmaster','gltrans.account=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('gltrans','systypes','gltrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('gltrans','periods','gltrans.periodno=periods.periodno');
INSERT INTO `reportlinks` VALUES ('grns','suppliers','grns.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('grns','purchorderdetails','grns.podetailitem=purchorderdetails.podetailitem');
INSERT INTO `reportlinks` VALUES ('internalstockcatrole','stockcategory','internalstockcatrole.categoryid=stockcategory.categoryid');
INSERT INTO `reportlinks` VALUES ('internalstockcatrole','securityroles','internalstockcatrole.secroleid=securityroles.secroleid');
INSERT INTO `reportlinks` VALUES ('internalstockcatrole','stockcategory','internalstockcatrole.categoryid=stockcategory.categoryid');
INSERT INTO `reportlinks` VALUES ('internalstockcatrole','securityroles','internalstockcatrole.secroleid=securityroles.secroleid');
INSERT INTO `reportlinks` VALUES ('locations','taxprovinces','locations.taxprovinceid=taxprovinces.taxprovinceid');
INSERT INTO `reportlinks` VALUES ('locstock','locations','locstock.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locstock','stockmaster','locstock.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('loctransfers','locations','loctransfers.shiploc=locations.loccode');
INSERT INTO `reportlinks` VALUES ('loctransfers','locations','loctransfers.recloc=locations.loccode');
INSERT INTO `reportlinks` VALUES ('loctransfers','stockmaster','loctransfers.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('mrpdemands','mrpdemandtypes','mrpdemands.mrpdemandtype=mrpdemandtypes.mrpdemandtype');
INSERT INTO `reportlinks` VALUES ('mrpdemands','stockmaster','mrpdemands.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('offers','suppliers','offers.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('offers','stockmaster','offers.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','stockmaster','orderdeliverydifferenceslog.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','custbranch','orderdeliverydifferenceslog.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','custbranch','orderdeliverydifferenceslog.branch=custbranch.branchcode');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','salesorders','orderdeliverydifferenceslog.orderno=salesorders.orderno');
INSERT INTO `reportlinks` VALUES ('pcexpenses','chartmaster','pcexpenses.glaccount=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('pctabexpenses','pctypetabs','pctabexpenses.typetabcode=pctypetabs.typetabcode');
INSERT INTO `reportlinks` VALUES ('pctabexpenses','pcexpenses','pctabexpenses.codeexpense=pcexpenses.codeexpense');
INSERT INTO `reportlinks` VALUES ('pctabs','www_users','pctabs.usercode=www_users.userid');
INSERT INTO `reportlinks` VALUES ('pctabs','pctypetabs','pctabs.typetabcode=pctypetabs.typetabcode');
INSERT INTO `reportlinks` VALUES ('pctabs','currencies','pctabs.currency=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('pctabs','www_users','pctabs.authorizer=www_users.userid');
INSERT INTO `reportlinks` VALUES ('pctabs','chartmaster','pctabs.glaccountassignment=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('pickinglistdetails','pickinglists','pickinglistdetails.pickinglistno=pickinglists.pickinglistno');
INSERT INTO `reportlinks` VALUES ('pickinglists','salesorders','pickinglists.orderno=salesorders.orderno');
INSERT INTO `reportlinks` VALUES ('prices','stockmaster','prices.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('prices','currencies','prices.currabrev=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('prices','salestypes','prices.typeabbrev=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('purchdata','stockmaster','purchdata.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('purchdata','suppliers','purchdata.supplierno=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('purchorderdetails','purchorders','purchorderdetails.orderno=purchorders.orderno');
INSERT INTO `reportlinks` VALUES ('purchorders','suppliers','purchorders.supplierno=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('purchorders','locations','purchorders.intostocklocation=locations.loccode');
INSERT INTO `reportlinks` VALUES ('recurringsalesorders','custbranch','recurringsalesorders.branchcode=custbranch.branchcode');
INSERT INTO `reportlinks` VALUES ('recurringsalesorders','custbranch','recurringsalesorders.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('recurrsalesorderdetails','recurringsalesorders','recurrsalesorderdetails.recurrorderno=recurringsalesorders.recurrorderno');
INSERT INTO `reportlinks` VALUES ('recurrsalesorderdetails','stockmaster','recurrsalesorderdetails.stkcode=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('reportcolumns','reportheaders','reportcolumns.reportid=reportheaders.reportid');
INSERT INTO `reportlinks` VALUES ('salesanalysis','periods','salesanalysis.periodno=periods.periodno');
INSERT INTO `reportlinks` VALUES ('salescatprod','stockmaster','salescatprod.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('salescatprod','salescat','salescatprod.salescatid=salescat.salescatid');
INSERT INTO `reportlinks` VALUES ('salesorderdetails','salesorders','salesorderdetails.orderno=salesorders.orderno');
INSERT INTO `reportlinks` VALUES ('salesorderdetails','stockmaster','salesorderdetails.stkcode=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('salesorders','custbranch','salesorders.branchcode=custbranch.branchcode');
INSERT INTO `reportlinks` VALUES ('salesorders','custbranch','salesorders.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('salesorders','shippers','salesorders.shipvia=shippers.shipper_id');
INSERT INTO `reportlinks` VALUES ('salesorders','locations','salesorders.fromstkloc=locations.loccode');
INSERT INTO `reportlinks` VALUES ('securitygroups','securityroles','securitygroups.secroleid=securityroles.secroleid');
INSERT INTO `reportlinks` VALUES ('securitygroups','securitytokens','securitygroups.tokenid=securitytokens.tokenid');
INSERT INTO `reportlinks` VALUES ('shipmentcharges','shipments','shipmentcharges.shiptref=shipments.shiptref');
INSERT INTO `reportlinks` VALUES ('shipmentcharges','systypes','shipmentcharges.transtype=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('shipments','suppliers','shipments.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('stockcatproperties','stockcategory','stockcatproperties.categoryid=stockcategory.categoryid');
INSERT INTO `reportlinks` VALUES ('stockcatproperties','stockcategory','stockcatproperties.categoryid=stockcategory.categoryid');
INSERT INTO `reportlinks` VALUES ('stockcatproperties','stockcategory','stockcatproperties.categoryid=stockcategory.categoryid');
INSERT INTO `reportlinks` VALUES ('stockcheckfreeze','stockmaster','stockcheckfreeze.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockcheckfreeze','locations','stockcheckfreeze.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('stockcounts','stockmaster','stockcounts.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockcounts','locations','stockcounts.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('stockitemproperties','stockmaster','stockitemproperties.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockitemproperties','stockcatproperties','stockitemproperties.stkcatpropid=stockcatproperties.stkcatpropid');
INSERT INTO `reportlinks` VALUES ('stockitemproperties','stockmaster','stockitemproperties.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockitemproperties','stockcatproperties','stockitemproperties.stkcatpropid=stockcatproperties.stkcatpropid');
INSERT INTO `reportlinks` VALUES ('stockitemproperties','stockmaster','stockitemproperties.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockitemproperties','stockcatproperties','stockitemproperties.stkcatpropid=stockcatproperties.stkcatpropid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockcategory','stockmaster.categoryid=stockcategory.categoryid');
INSERT INTO `reportlinks` VALUES ('stockmaster','taxcategories','stockmaster.taxcatid=taxcategories.taxcatid');
INSERT INTO `reportlinks` VALUES ('stockmoves','stockmaster','stockmoves.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmoves','systypes','stockmoves.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('stockmoves','locations','stockmoves.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('stockmoves','periods','stockmoves.prd=periods.periodno');
INSERT INTO `reportlinks` VALUES ('stockmovestaxes','taxauthorities','stockmovestaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('stockmovestaxes','stockmoves','stockmovestaxes.stkmoveno=stockmoves.stkmoveno');
INSERT INTO `reportlinks` VALUES ('stockmovestaxes','stockmoves','stockmovestaxes.stkmoveno=stockmoves.stkmoveno');
INSERT INTO `reportlinks` VALUES ('stockmovestaxes','stockmoves','stockmovestaxes.stkmoveno=stockmoves.stkmoveno');
INSERT INTO `reportlinks` VALUES ('stockrequest','locations','stockrequest.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('stockrequest','departments','stockrequest.departmentid=departments.departmentid');
INSERT INTO `reportlinks` VALUES ('stockrequest','locations','stockrequest.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('stockrequest','departments','stockrequest.departmentid=departments.departmentid');
INSERT INTO `reportlinks` VALUES ('stockrequestitems','stockrequest','stockrequestitems.dispatchid=stockrequest.dispatchid');
INSERT INTO `reportlinks` VALUES ('stockrequestitems','stockmaster','stockrequestitems.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockrequestitems','stockrequest','stockrequestitems.dispatchid=stockrequest.dispatchid');
INSERT INTO `reportlinks` VALUES ('stockrequestitems','stockmaster','stockrequestitems.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockserialitems','stockmaster','stockserialitems.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockserialitems','locations','stockserialitems.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('stockserialmoves','stockmoves','stockserialmoves.stockmoveno=stockmoves.stkmoveno');
INSERT INTO `reportlinks` VALUES ('stockserialmoves','stockserialitems','stockserialmoves.stockid=stockserialitems.stockid');
INSERT INTO `reportlinks` VALUES ('stockserialmoves','stockserialitems','stockserialmoves.serialno=stockserialitems.serialno');
INSERT INTO `reportlinks` VALUES ('suppallocs','supptrans','suppallocs.transid_allocfrom=supptrans.id');
INSERT INTO `reportlinks` VALUES ('suppallocs','supptrans','suppallocs.transid_allocto=supptrans.id');
INSERT INTO `reportlinks` VALUES ('suppliercontacts','suppliers','suppliercontacts.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','currencies','suppliers.currcode=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('suppliers','paymentterms','suppliers.paymentterms=paymentterms.termsindicator');
INSERT INTO `reportlinks` VALUES ('suppliers','taxgroups','suppliers.taxgroupid=taxgroups.taxgroupid');
INSERT INTO `reportlinks` VALUES ('supptrans','systypes','supptrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('supptrans','suppliers','supptrans.supplierno=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('supptranstaxes','taxauthorities','supptranstaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('supptranstaxes','supptrans','supptranstaxes.supptransid=supptrans.id');
INSERT INTO `reportlinks` VALUES ('taxauthorities','chartmaster','taxauthorities.taxglcode=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('taxauthorities','chartmaster','taxauthorities.purchtaxglaccount=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('taxauthrates','taxauthorities','taxauthrates.taxauthority=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthrates','taxcategories','taxauthrates.taxcatid=taxcategories.taxcatid');
INSERT INTO `reportlinks` VALUES ('taxauthrates','taxprovinces','taxauthrates.dispatchtaxprovince=taxprovinces.taxprovinceid');
INSERT INTO `reportlinks` VALUES ('taxgrouptaxes','taxgroups','taxgrouptaxes.taxgroupid=taxgroups.taxgroupid');
INSERT INTO `reportlinks` VALUES ('taxgrouptaxes','taxauthorities','taxgrouptaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('woitems','stockmaster','woitems.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('woitems','workorders','woitems.wo=workorders.wo');
INSERT INTO `reportlinks` VALUES ('worequirements','workorders','worequirements.wo=workorders.wo');
INSERT INTO `reportlinks` VALUES ('worequirements','stockmaster','worequirements.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('worequirements','woitems','worequirements.wo=woitems.wo');
INSERT INTO `reportlinks` VALUES ('worequirements','woitems','worequirements.parentstockid=woitems.stockid');
INSERT INTO `reportlinks` VALUES ('workcentres','locations','workcentres.location=locations.loccode');
INSERT INTO `reportlinks` VALUES ('workorders','locations','workorders.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('www_users','locations','www_users.defaultlocation=locations.loccode');

--
-- Dumping data for table `salesglpostings`
--

INSERT INTO `salesglpostings` VALUES (1,'AN','ANY',4900,4100,'AN');
INSERT INTO `salesglpostings` VALUES (2,'AN','AIRCON',5000,4800,'DE');

--
-- Dumping data for table `systypes`
--

INSERT INTO `systypes` VALUES (0,'Journal - GL',2);
INSERT INTO `systypes` VALUES (1,'Payment - GL',0);
INSERT INTO `systypes` VALUES (2,'Receipt - GL',0);
INSERT INTO `systypes` VALUES (3,'Standing Journal',0);
INSERT INTO `systypes` VALUES (10,'Sales Invoice',2);
INSERT INTO `systypes` VALUES (11,'Credit Note',0);
INSERT INTO `systypes` VALUES (12,'Receipt',2);
INSERT INTO `systypes` VALUES (15,'Journal - Debtors',0);
INSERT INTO `systypes` VALUES (16,'Location Transfer',0);
INSERT INTO `systypes` VALUES (17,'Stock Adjustment',0);
INSERT INTO `systypes` VALUES (18,'Purchase Order',2);
INSERT INTO `systypes` VALUES (19,'Picking List',0);
INSERT INTO `systypes` VALUES (20,'Purchase Invoice',2);
INSERT INTO `systypes` VALUES (21,'Debit Note',0);
INSERT INTO `systypes` VALUES (22,'Creditors Payment',1);
INSERT INTO `systypes` VALUES (23,'Creditors Journal',0);
INSERT INTO `systypes` VALUES (25,'Purchase Order Delivery',1);
INSERT INTO `systypes` VALUES (26,'Work Order Receipt',2);
INSERT INTO `systypes` VALUES (28,'Work Order Issue',1);
INSERT INTO `systypes` VALUES (29,'Work Order Variance',0);
INSERT INTO `systypes` VALUES (30,'Sales Order',3);
INSERT INTO `systypes` VALUES (31,'Shipment Close',0);
INSERT INTO `systypes` VALUES (32,'Contract Close',0);
INSERT INTO `systypes` VALUES (35,'Cost Update',0);
INSERT INTO `systypes` VALUES (36,'Exchange Difference',0);
INSERT INTO `systypes` VALUES (37,'Tenders',1);
INSERT INTO `systypes` VALUES (38,'Stock Requests',1);
INSERT INTO `systypes` VALUES (40,'Work Order',3);
INSERT INTO `systypes` VALUES (41,'Asset Addition',0);
INSERT INTO `systypes` VALUES (42,'Asset Category Change',0);
INSERT INTO `systypes` VALUES (43,'Delete w/down asset',0);
INSERT INTO `systypes` VALUES (44,'Depreciation',0);
INSERT INTO `systypes` VALUES (49,'Import Fixed Assets',0);
INSERT INTO `systypes` VALUES (50,'Opening Balance',0);
INSERT INTO `systypes` VALUES (500,'Auto Debtor Number',0);

--
-- Dumping data for table `taxauthorities`
--

INSERT INTO `taxauthorities` VALUES (1,'Kenya Revenue Authority','2300','2310','','','','');
INSERT INTO `taxauthorities` VALUES (5,'Uganda Revenue Authority','2300','2310','','','','');
INSERT INTO `taxauthorities` VALUES (11,'Tanzania Revenue Authority','2300','2310','','','','');
INSERT INTO `taxauthorities` VALUES (12,'Rwanda Revenue Authority','2300','2310','','','','');
INSERT INTO `taxauthorities` VALUES (13,'Burundi Revenue Authority','2300','2310','','','','');

--
-- Dumping data for table `taxgroups`
--

INSERT INTO `taxgroups` VALUES (1,'Kenya');
INSERT INTO `taxgroups` VALUES (2,'Uganda');
INSERT INTO `taxgroups` VALUES (3,'Tanzania');
INSERT INTO `taxgroups` VALUES (4,'Rwanda');
INSERT INTO `taxgroups` VALUES (5,'Burundi');

--
-- Dumping data for table `taxauthrates`
--

INSERT INTO `taxauthrates` VALUES (1,1,1,0.16);
INSERT INTO `taxauthrates` VALUES (1,1,2,0.16);
INSERT INTO `taxauthrates` VALUES (1,1,5,0.16);
INSERT INTO `taxauthrates` VALUES (5,1,1,0.18);
INSERT INTO `taxauthrates` VALUES (5,1,2,0.18);
INSERT INTO `taxauthrates` VALUES (5,1,5,0.18);
INSERT INTO `taxauthrates` VALUES (11,1,1,0.18);
INSERT INTO `taxauthrates` VALUES (11,1,2,0.18);
INSERT INTO `taxauthrates` VALUES (11,1,5,0.18);
INSERT INTO `taxauthrates` VALUES (12,1,1,0.18);
INSERT INTO `taxauthrates` VALUES (12,1,2,0.18);
INSERT INTO `taxauthrates` VALUES (12,1,5,0.18);
INSERT INTO `taxauthrates` VALUES (13,1,1,0.18);
INSERT INTO `taxauthrates` VALUES (13,1,2,0.18);
INSERT INTO `taxauthrates` VALUES (13,1,5,0.18);

--
-- Dumping data for table `taxcategories`
--

INSERT INTO `taxcategories` VALUES (1,'Taxable supply');
INSERT INTO `taxcategories` VALUES (2,'Luxury Items');
INSERT INTO `taxcategories` VALUES (4,'Exempt');
INSERT INTO `taxcategories` VALUES (5,'Freight');

--
-- Dumping data for table `taxprovinces`
--

INSERT INTO `taxprovinces` VALUES (1,'East African Community');

--
-- Dumping data for table `www_users`
--

INSERT INTO `www_users` VALUES ('admin','8467dd232d0410dd7fc0e25a5e9ce72f9bdc0d1e','Demonstration user','','','','','info@kwamoja.com','MSA',8,1,'2013-01-25 10:30:00','','A4','1,1,1,1,1,1,1,1,1,1,1,',0,50,'aguapop','en_GB.utf8',0,0,0);
INSERT INTO `www_users` VALUES ('coastal','8467dd232d0410dd7fc0e25a5e9ce72f9bdc0d1e','Coastal Hotelsd Ltd','COA001','','','','','MSA',7,0,'2012-12-17 22:37:30','COA001','A4','1,1,0,0,0,0,0,0',0,50,'aguapop','en_GB.utf8',0,0,0);
INSERT INTO `www_users` VALUES ('voifv','8467dd232d0410dd7fc0e25a5e9ce72f9bdc0d1e','Voi Fruit and Vegetable supplies Lt','','VOI001','','','','MSA',9,0,'2013-01-03 11:59:54','','A4','0,0,0,0,0,0,0,0,0,0,0,',0,50,'silverwolf','en_GB.utf8',0,0,1);

--
-- Dumping data for table `edi_orders_segs`
--

INSERT INTO `edi_orders_segs` VALUES (1,'UNB',0,1);
INSERT INTO `edi_orders_segs` VALUES (2,'UNH',0,1);
INSERT INTO `edi_orders_segs` VALUES (3,'BGM',0,1);
INSERT INTO `edi_orders_segs` VALUES (4,'DTM',0,35);
INSERT INTO `edi_orders_segs` VALUES (5,'PAI',0,1);
INSERT INTO `edi_orders_segs` VALUES (6,'ALI',0,5);
INSERT INTO `edi_orders_segs` VALUES (7,'FTX',0,99);
INSERT INTO `edi_orders_segs` VALUES (8,'RFF',1,1);
INSERT INTO `edi_orders_segs` VALUES (9,'DTM',1,5);
INSERT INTO `edi_orders_segs` VALUES (10,'NAD',2,1);
INSERT INTO `edi_orders_segs` VALUES (11,'LOC',2,99);
INSERT INTO `edi_orders_segs` VALUES (12,'FII',2,5);
INSERT INTO `edi_orders_segs` VALUES (13,'RFF',3,1);
INSERT INTO `edi_orders_segs` VALUES (14,'CTA',5,1);
INSERT INTO `edi_orders_segs` VALUES (15,'COM',5,5);
INSERT INTO `edi_orders_segs` VALUES (16,'TAX',6,1);
INSERT INTO `edi_orders_segs` VALUES (17,'MOA',6,1);
INSERT INTO `edi_orders_segs` VALUES (18,'CUX',7,1);
INSERT INTO `edi_orders_segs` VALUES (19,'DTM',7,5);
INSERT INTO `edi_orders_segs` VALUES (20,'PAT',8,1);
INSERT INTO `edi_orders_segs` VALUES (21,'DTM',8,5);
INSERT INTO `edi_orders_segs` VALUES (22,'PCD',8,1);
INSERT INTO `edi_orders_segs` VALUES (23,'MOA',9,1);
INSERT INTO `edi_orders_segs` VALUES (24,'TDT',10,1);
INSERT INTO `edi_orders_segs` VALUES (25,'LOC',11,1);
INSERT INTO `edi_orders_segs` VALUES (26,'DTM',11,5);
INSERT INTO `edi_orders_segs` VALUES (27,'TOD',12,1);
INSERT INTO `edi_orders_segs` VALUES (28,'LOC',12,2);
INSERT INTO `edi_orders_segs` VALUES (29,'PAC',13,1);
INSERT INTO `edi_orders_segs` VALUES (30,'PCI',14,1);
INSERT INTO `edi_orders_segs` VALUES (31,'RFF',14,1);
INSERT INTO `edi_orders_segs` VALUES (32,'DTM',14,5);
INSERT INTO `edi_orders_segs` VALUES (33,'GIN',14,10);
INSERT INTO `edi_orders_segs` VALUES (34,'EQD',15,1);
INSERT INTO `edi_orders_segs` VALUES (35,'ALC',19,1);
INSERT INTO `edi_orders_segs` VALUES (36,'ALI',19,5);
INSERT INTO `edi_orders_segs` VALUES (37,'DTM',19,5);
INSERT INTO `edi_orders_segs` VALUES (38,'QTY',20,1);
INSERT INTO `edi_orders_segs` VALUES (39,'RNG',20,1);
INSERT INTO `edi_orders_segs` VALUES (40,'PCD',21,1);
INSERT INTO `edi_orders_segs` VALUES (41,'RNG',21,1);
INSERT INTO `edi_orders_segs` VALUES (42,'MOA',22,1);
INSERT INTO `edi_orders_segs` VALUES (43,'RNG',22,1);
INSERT INTO `edi_orders_segs` VALUES (44,'RTE',23,1);
INSERT INTO `edi_orders_segs` VALUES (45,'RNG',23,1);
INSERT INTO `edi_orders_segs` VALUES (46,'TAX',24,1);
INSERT INTO `edi_orders_segs` VALUES (47,'MOA',24,1);
INSERT INTO `edi_orders_segs` VALUES (48,'LIN',28,1);
INSERT INTO `edi_orders_segs` VALUES (49,'PIA',28,25);
INSERT INTO `edi_orders_segs` VALUES (50,'IMD',28,99);
INSERT INTO `edi_orders_segs` VALUES (51,'MEA',28,99);
INSERT INTO `edi_orders_segs` VALUES (52,'QTY',28,99);
INSERT INTO `edi_orders_segs` VALUES (53,'ALI',28,5);
INSERT INTO `edi_orders_segs` VALUES (54,'DTM',28,35);
INSERT INTO `edi_orders_segs` VALUES (55,'MOA',28,10);
INSERT INTO `edi_orders_segs` VALUES (56,'GIN',28,127);
INSERT INTO `edi_orders_segs` VALUES (57,'QVR',28,1);
INSERT INTO `edi_orders_segs` VALUES (58,'FTX',28,99);
INSERT INTO `edi_orders_segs` VALUES (59,'PRI',32,1);
INSERT INTO `edi_orders_segs` VALUES (60,'CUX',32,1);
INSERT INTO `edi_orders_segs` VALUES (61,'DTM',32,5);
INSERT INTO `edi_orders_segs` VALUES (62,'RFF',33,1);
INSERT INTO `edi_orders_segs` VALUES (63,'DTM',33,5);
INSERT INTO `edi_orders_segs` VALUES (64,'PAC',34,1);
INSERT INTO `edi_orders_segs` VALUES (65,'QTY',34,5);
INSERT INTO `edi_orders_segs` VALUES (66,'PCI',36,1);
INSERT INTO `edi_orders_segs` VALUES (67,'RFF',36,1);
INSERT INTO `edi_orders_segs` VALUES (68,'DTM',36,5);
INSERT INTO `edi_orders_segs` VALUES (69,'GIN',36,10);
INSERT INTO `edi_orders_segs` VALUES (70,'LOC',37,1);
INSERT INTO `edi_orders_segs` VALUES (71,'QTY',37,1);
INSERT INTO `edi_orders_segs` VALUES (72,'DTM',37,5);
INSERT INTO `edi_orders_segs` VALUES (73,'TAX',38,1);
INSERT INTO `edi_orders_segs` VALUES (74,'MOA',38,1);
INSERT INTO `edi_orders_segs` VALUES (75,'NAD',39,1);
INSERT INTO `edi_orders_segs` VALUES (76,'CTA',42,1);
INSERT INTO `edi_orders_segs` VALUES (77,'COM',42,5);
INSERT INTO `edi_orders_segs` VALUES (78,'ALC',43,1);
INSERT INTO `edi_orders_segs` VALUES (79,'ALI',43,5);
INSERT INTO `edi_orders_segs` VALUES (80,'DTM',43,5);
INSERT INTO `edi_orders_segs` VALUES (81,'QTY',44,1);
INSERT INTO `edi_orders_segs` VALUES (82,'RNG',44,1);
INSERT INTO `edi_orders_segs` VALUES (83,'PCD',45,1);
INSERT INTO `edi_orders_segs` VALUES (84,'RNG',45,1);
INSERT INTO `edi_orders_segs` VALUES (85,'MOA',46,1);
INSERT INTO `edi_orders_segs` VALUES (86,'RNG',46,1);
INSERT INTO `edi_orders_segs` VALUES (87,'RTE',47,1);
INSERT INTO `edi_orders_segs` VALUES (88,'RNG',47,1);
INSERT INTO `edi_orders_segs` VALUES (89,'TAX',48,1);
INSERT INTO `edi_orders_segs` VALUES (90,'MOA',48,1);
INSERT INTO `edi_orders_segs` VALUES (91,'TDT',49,1);
INSERT INTO `edi_orders_segs` VALUES (92,'UNS',50,1);
INSERT INTO `edi_orders_segs` VALUES (93,'MOA',50,1);
INSERT INTO `edi_orders_segs` VALUES (94,'CNT',50,1);
INSERT INTO `edi_orders_segs` VALUES (95,'UNT',50,1);

--
-- Dumping data for table `edi_orders_seg_groups`
--

INSERT INTO `edi_orders_seg_groups` VALUES (0,1,0);
INSERT INTO `edi_orders_seg_groups` VALUES (1,9999,0);
INSERT INTO `edi_orders_seg_groups` VALUES (2,99,0);
INSERT INTO `edi_orders_seg_groups` VALUES (3,99,2);
INSERT INTO `edi_orders_seg_groups` VALUES (5,5,2);
INSERT INTO `edi_orders_seg_groups` VALUES (6,5,0);
INSERT INTO `edi_orders_seg_groups` VALUES (7,5,0);
INSERT INTO `edi_orders_seg_groups` VALUES (8,10,0);
INSERT INTO `edi_orders_seg_groups` VALUES (9,9999,8);
INSERT INTO `edi_orders_seg_groups` VALUES (10,10,0);
INSERT INTO `edi_orders_seg_groups` VALUES (11,10,10);
INSERT INTO `edi_orders_seg_groups` VALUES (12,5,0);
INSERT INTO `edi_orders_seg_groups` VALUES (13,99,0);
INSERT INTO `edi_orders_seg_groups` VALUES (14,5,13);
INSERT INTO `edi_orders_seg_groups` VALUES (15,10,0);
INSERT INTO `edi_orders_seg_groups` VALUES (19,99,0);
INSERT INTO `edi_orders_seg_groups` VALUES (20,1,19);
INSERT INTO `edi_orders_seg_groups` VALUES (21,1,19);
INSERT INTO `edi_orders_seg_groups` VALUES (22,2,19);
INSERT INTO `edi_orders_seg_groups` VALUES (23,1,19);
INSERT INTO `edi_orders_seg_groups` VALUES (24,5,19);
INSERT INTO `edi_orders_seg_groups` VALUES (28,200000,0);
INSERT INTO `edi_orders_seg_groups` VALUES (32,25,28);
INSERT INTO `edi_orders_seg_groups` VALUES (33,9999,28);
INSERT INTO `edi_orders_seg_groups` VALUES (34,99,28);
INSERT INTO `edi_orders_seg_groups` VALUES (36,5,34);
INSERT INTO `edi_orders_seg_groups` VALUES (37,9999,28);
INSERT INTO `edi_orders_seg_groups` VALUES (38,10,28);
INSERT INTO `edi_orders_seg_groups` VALUES (39,999,28);
INSERT INTO `edi_orders_seg_groups` VALUES (42,5,39);
INSERT INTO `edi_orders_seg_groups` VALUES (43,99,28);
INSERT INTO `edi_orders_seg_groups` VALUES (44,1,43);
INSERT INTO `edi_orders_seg_groups` VALUES (45,1,43);
INSERT INTO `edi_orders_seg_groups` VALUES (46,2,43);
INSERT INTO `edi_orders_seg_groups` VALUES (47,1,43);
INSERT INTO `edi_orders_seg_groups` VALUES (48,5,43);
INSERT INTO `edi_orders_seg_groups` VALUES (49,10,28);
INSERT INTO `edi_orders_seg_groups` VALUES (50,1,0);

--
-- Dumping data for table `config`
--

INSERT INTO `config` VALUES ('AllowOrderLineItemNarrative','1');
INSERT INTO `config` VALUES ('AllowSalesOfZeroCostItems','0');
INSERT INTO `config` VALUES ('AutoAuthorisePO','1');
INSERT INTO `config` VALUES ('AutoCreateWOs','1');
INSERT INTO `config` VALUES ('AutoDebtorNo','0');
INSERT INTO `config` VALUES ('AutoIssue','1');
INSERT INTO `config` VALUES ('CheckCreditLimits','1');
INSERT INTO `config` VALUES ('Check_Price_Charged_vs_Order_Price','1');
INSERT INTO `config` VALUES ('Check_Qty_Charged_vs_Del_Qty','1');
INSERT INTO `config` VALUES ('CountryOfOperation','KES');
INSERT INTO `config` VALUES ('CreditingControlledItems_MustExist','0');
INSERT INTO `config` VALUES ('DB_Maintenance','30');
INSERT INTO `config` VALUES ('DB_Maintenance_LastRun','2013-01-01');
INSERT INTO `config` VALUES ('DefaultBlindPackNote','1');
INSERT INTO `config` VALUES ('DefaultCreditLimit','1000');
INSERT INTO `config` VALUES ('DefaultCustomerType','1');
INSERT INTO `config` VALUES ('DefaultDateFormat','d/m/Y');
INSERT INTO `config` VALUES ('DefaultDisplayRecordsMax','50');
INSERT INTO `config` VALUES ('DefaultFactoryLocation','MSA');
INSERT INTO `config` VALUES ('DefaultPriceList','EA');
INSERT INTO `config` VALUES ('DefaultSupplierType','1');
INSERT INTO `config` VALUES ('DefaultTaxCategory','1');
INSERT INTO `config` VALUES ('DefaultTheme','silverwolf');
INSERT INTO `config` VALUES ('Default_Shipper','1');
INSERT INTO `config` VALUES ('DefineControlledOnWOEntry','1');
INSERT INTO `config` VALUES ('DispatchCutOffTime','14');
INSERT INTO `config` VALUES ('DoFreightCalc','0');
INSERT INTO `config` VALUES ('EDIHeaderMsgId','D:01B:UN:EAN010');
INSERT INTO `config` VALUES ('EDIReference','KWAMOJA');
INSERT INTO `config` VALUES ('EDI_Incoming_Orders','companies/kwamojademo/EDI_Incoming_Orders');
INSERT INTO `config` VALUES ('EDI_MsgPending','companies/kwamojademo/EDI_MsgPending');
INSERT INTO `config` VALUES ('EDI_MsgSent','companies/kwamojademo/EDI_Sent');
INSERT INTO `config` VALUES ('ExchangeRateFeed','ECB');
INSERT INTO `config` VALUES ('Extended_CustomerInfo','0');
INSERT INTO `config` VALUES ('Extended_SupplierInfo','0');
INSERT INTO `config` VALUES ('FactoryManagerEmail','manager@company.com');
INSERT INTO `config` VALUES ('FreightChargeAppliesIfLessThan','1000');
INSERT INTO `config` VALUES ('FreightTaxCategory','1');
INSERT INTO `config` VALUES ('FrequentlyOrderedItems','0');
INSERT INTO `config` VALUES ('geocode_integration','0');
INSERT INTO `config` VALUES ('HTTPS_Only','0');
INSERT INTO `config` VALUES ('InventoryManagerEmail','');
INSERT INTO `config` VALUES ('InvoicePortraitFormat','1');
INSERT INTO `config` VALUES ('LogPath','');
INSERT INTO `config` VALUES ('LogSeverity','0');
INSERT INTO `config` VALUES ('MaxImageSize','300');
INSERT INTO `config` VALUES ('MonthsAuditTrail','1');
INSERT INTO `config` VALUES ('NumberOfMonthMustBeShown','6');
INSERT INTO `config` VALUES ('NumberOfPeriodsOfStockUsage','12');
INSERT INTO `config` VALUES ('OverChargeProportion','30');
INSERT INTO `config` VALUES ('OverReceiveProportion','20');
INSERT INTO `config` VALUES ('PackNoteFormat','1');
INSERT INTO `config` VALUES ('PageLength','48');
INSERT INTO `config` VALUES ('part_pics_dir','companies/kwamoja/EDI_Sent');
INSERT INTO `config` VALUES ('PastDueDays1','30');
INSERT INTO `config` VALUES ('PastDueDays2','60');
INSERT INTO `config` VALUES ('PO_AllowSameItemMultipleTimes','1');
INSERT INTO `config` VALUES ('ProhibitJournalsToControlAccounts','1');
INSERT INTO `config` VALUES ('ProhibitNegativeStock','1');
INSERT INTO `config` VALUES ('ProhibitPostingsBefore','1900-01-01');
INSERT INTO `config` VALUES ('PurchasingManagerEmail','test@company.com');
INSERT INTO `config` VALUES ('QuickEntries','10');
INSERT INTO `config` VALUES ('RadioBeaconFileCounter','/home/RadioBeacon/FileCounter');
INSERT INTO `config` VALUES ('RadioBeaconFTP_user_name','RadioBeacon ftp server user name');
INSERT INTO `config` VALUES ('RadioBeaconHomeDir','/home/RadioBeacon');
INSERT INTO `config` VALUES ('RadioBeaconStockLocation','BL');
INSERT INTO `config` VALUES ('RadioBraconFTP_server','192.168.2.2');
INSERT INTO `config` VALUES ('RadioBreaconFilePrefix','ORDXX');
INSERT INTO `config` VALUES ('RadionBeaconFTP_user_pass','Radio Beacon remote ftp server password');
INSERT INTO `config` VALUES ('reports_dir','companies/kwamoja/EDI_Sent');
INSERT INTO `config` VALUES ('RequirePickingNote','0');
INSERT INTO `config` VALUES ('RomalpaClause','Ownership will not pass to the buyer until the goods have been paid for in full.');
INSERT INTO `config` VALUES ('ShowStockidOnImages','0');
INSERT INTO `config` VALUES ('ShowValueOnGRN','1');
INSERT INTO `config` VALUES ('Show_Settled_LastMonth','1');
INSERT INTO `config` VALUES ('SO_AllowSameItemMultipleTimes','1');
INSERT INTO `config` VALUES ('StandardCostDecimalPlaces','2');
INSERT INTO `config` VALUES ('TaxAuthorityReferenceName','');
INSERT INTO `config` VALUES ('UpdateCurrencyRatesDaily','0');
INSERT INTO `config` VALUES ('VersionNumber','4.10.1');
INSERT INTO `config` VALUES ('WeightedAverageCosting','1');
INSERT INTO `config` VALUES ('WikiApp','Disabled');
INSERT INTO `config` VALUES ('WikiPath','wiki');
INSERT INTO `config` VALUES ('WorkingDaysWeek','5');
INSERT INTO `config` VALUES ('YearEnd','3');

--
-- Dumping data for table `unitsofmeasure`
--

INSERT INTO `unitsofmeasure` VALUES (1,'each');
INSERT INTO `unitsofmeasure` VALUES (2,'meters');
INSERT INTO `unitsofmeasure` VALUES (3,'kgs');
INSERT INTO `unitsofmeasure` VALUES (4,'litres');
INSERT INTO `unitsofmeasure` VALUES (5,'length');
INSERT INTO `unitsofmeasure` VALUES (6,'hours');

--
-- Dumping data for table `paymentmethods`
--

INSERT INTO `paymentmethods` VALUES (1,'Cheque',1,1,1,0);
INSERT INTO `paymentmethods` VALUES (2,'Cash',1,1,0,0);
INSERT INTO `paymentmethods` VALUES (3,'Direct Credit',1,1,0,0);

--
-- Dumping data for table `scripts`
--

INSERT INTO `scripts` VALUES ('AccountGroups.php',10,'Defines the groupings of general ledger accounts');
INSERT INTO `scripts` VALUES ('AccountSections.php',10,'Defines the sections in the general ledger reports');
INSERT INTO `scripts` VALUES ('AddCustomerContacts.php',3,'Adds customer contacts');
INSERT INTO `scripts` VALUES ('AddCustomerNotes.php',3,'Adds notes about customers');
INSERT INTO `scripts` VALUES ('AddCustomerTypeNotes.php',3,'');
INSERT INTO `scripts` VALUES ('AgedDebtors.php',2,'Lists customer account balances in detail or summary in selected currency');
INSERT INTO `scripts` VALUES ('AgedSuppliers.php',2,'Lists supplier account balances in detail or summary in selected currency');
INSERT INTO `scripts` VALUES ('Areas.php',3,'Defines the sales areas - all customers must belong to a sales area for the purposes of sales analysis');
INSERT INTO `scripts` VALUES ('AuditTrail.php',15,'Shows the activity with SQL statements and who performed the changes');
INSERT INTO `scripts` VALUES ('BankAccounts.php',10,'Defines the general ledger code for bank accounts and specifies that bank transactions be created for these accounts for the purposes of reconciliation');
INSERT INTO `scripts` VALUES ('BankMatching.php',7,'Allows payments and receipts to be matched off against bank statements');
INSERT INTO `scripts` VALUES ('BankReconciliation.php',7,'Displays the bank reconciliation for a selected bank account');
INSERT INTO `scripts` VALUES ('BOMExtendedQty.php',2,'Shows the component requirements to make an item');
INSERT INTO `scripts` VALUES ('BOMIndented.php',2,'Shows the bill of material indented for each level');
INSERT INTO `scripts` VALUES ('BOMIndentedReverse.php',2,'');
INSERT INTO `scripts` VALUES ('BOMInquiry.php',2,'Displays the bill of material with cost information');
INSERT INTO `scripts` VALUES ('BOMListing.php',2,'Lists the bills of material for a selected range of items');
INSERT INTO `scripts` VALUES ('BOMs.php',9,'Administers the bills of material for a selected item');
INSERT INTO `scripts` VALUES ('COGSGLPostings.php',10,'Defines the general ledger account to be used for cost of sales entries');
INSERT INTO `scripts` VALUES ('CompanyPreferences.php',10,'Defines the settings applicable for the company, including name, address, tax authority reference, whether GL integration used etc.');
INSERT INTO `scripts` VALUES ('ConfirmDispatchControlled_Invoice.php',11,'Specifies the batch references/serial numbers of items dispatched that are being invoiced');
INSERT INTO `scripts` VALUES ('ConfirmDispatch_Invoice.php',2,'Creates sales invoices from entered sales orders based on the quantities dispatched that can be modified');
INSERT INTO `scripts` VALUES ('ContractBOM.php',6,'Creates the item requirements from stock for a contract as part of the contract cost build up');
INSERT INTO `scripts` VALUES ('ContractCosting.php',6,'Shows a contract cost - the components and other non-stock costs issued to the contract');
INSERT INTO `scripts` VALUES ('ContractOtherReqts.php',4,'Creates the other requirements for a contract cost build up');
INSERT INTO `scripts` VALUES ('Contracts.php',6,'Creates or modifies a customer contract costing');
INSERT INTO `scripts` VALUES ('CopyBOM.php',9,'Allows a bill of material to be copied between items');
INSERT INTO `scripts` VALUES ('CounterReturns.php',5,'Allows credits and refunds from the default Counter Sale account for an inventory location');
INSERT INTO `scripts` VALUES ('CounterSales.php',1,'Allows sales to be entered against a cash sale customer account defined in the users location record');
INSERT INTO `scripts` VALUES ('CreditItemsControlled.php',3,'Specifies the batch references/serial numbers of items being credited back into stock');
INSERT INTO `scripts` VALUES ('CreditStatus.php',3,'Defines the credit status records. Each customer account is given a credit status from this table. Some credit status records can prohibit invoicing and new orders being entered.');
INSERT INTO `scripts` VALUES ('Credit_Invoice.php',3,'Creates a credit note based on the details of an existing invoice');
INSERT INTO `scripts` VALUES ('Currencies.php',9,'Defines the currencies available. Each customer and supplier must be defined as transacting in one of the currencies defined here.');
INSERT INTO `scripts` VALUES ('CustEDISetup.php',11,'Allows the set up the customer specified EDI parameters for server, email or ftp.');
INSERT INTO `scripts` VALUES ('CustLoginSetup.php',15,'');
INSERT INTO `scripts` VALUES ('CustomerAllocations.php',3,'Allows customer receipts and credit notes to be allocated to sales invoices');
INSERT INTO `scripts` VALUES ('CustomerBranches.php',3,'Defines the details of customer branches such as delivery address and contact details - also sales area, representative etc');
INSERT INTO `scripts` VALUES ('CustomerInquiry.php',1,'Shows the customers account transactions with balances outstanding, links available to drill down to invoice/credit note or email invoices/credit notes');
INSERT INTO `scripts` VALUES ('CustomerPurchases.php',5,'Shows the purchases a customer has made.');
INSERT INTO `scripts` VALUES ('CustomerReceipt.php',3,'Entry of both customer receipts against accounts receivable and also general ledger or nominal receipts');
INSERT INTO `scripts` VALUES ('Customers.php',3,'Defines the setup of a customer account, including payment terms, billing address, credit status, currency etc');
INSERT INTO `scripts` VALUES ('CustomerTransInquiry.php',2,'Lists in html the sequence of customer transactions, invoices, credit notes or receipts by a user entered date range');
INSERT INTO `scripts` VALUES ('CustomerTypes.php',15,'');
INSERT INTO `scripts` VALUES ('CustWhereAlloc.php',2,'Shows to which invoices a receipt was allocated to');
INSERT INTO `scripts` VALUES ('DailyBankTransactions.php',8,'');
INSERT INTO `scripts` VALUES ('DailySalesInquiry.php',2,'Shows the daily sales with GP in a calendar format');
INSERT INTO `scripts` VALUES ('DebtorsAtPeriodEnd.php',2,'Shows the debtors control account as at a previous period end - based on system calendar monthly periods');
INSERT INTO `scripts` VALUES ('DeliveryDetails.php',1,'Used during order entry to allow the entry of delivery addresses other than the defaulted branch delivery address and information about carrier/shipping method etc');
INSERT INTO `scripts` VALUES ('Departments.php',1,'Create business departments');
INSERT INTO `scripts` VALUES ('DiscountCategories.php',11,'Defines the items belonging to a discount category. Discount Categories are used to allow discounts based on quantities across a range of producs');
INSERT INTO `scripts` VALUES ('DiscountMatrix.php',11,'Defines the rates of discount applicable to discount categories and the customer groupings to which the rates are to apply');
INSERT INTO `scripts` VALUES ('EDIMessageFormat.php',10,'Specifies the EDI message format used by a customer - administrator use only.');
INSERT INTO `scripts` VALUES ('EDIProcessOrders.php',11,'Processes incoming EDI orders into sales orders');
INSERT INTO `scripts` VALUES ('EDISendInvoices.php',15,'Processes invoiced EDI customer invoices into EDI messages and sends using the customers preferred method either ftp or email attachments.');
INSERT INTO `scripts` VALUES ('EmailConfirmation.php',2,'');
INSERT INTO `scripts` VALUES ('EmailCustTrans.php',2,'Emails selected invoice or credit to the customer');
INSERT INTO `scripts` VALUES ('ExchangeRateTrend.php',2,'Shows the trend in exchange rates as retrieved from ECB');
INSERT INTO `scripts` VALUES ('Factors.php',5,'Defines supplier factor companies');
INSERT INTO `scripts` VALUES ('FixedAssetCategories.php',11,'Defines the various categories of fixed assets');
INSERT INTO `scripts` VALUES ('FixedAssetDepreciation.php',10,'Calculates and creates GL transactions to post depreciation for a period');
INSERT INTO `scripts` VALUES ('FixedAssetItems.php',11,'Allows fixed assets to be defined');
INSERT INTO `scripts` VALUES ('FixedAssetList.php',11,'');
INSERT INTO `scripts` VALUES ('FixedAssetLocations.php',11,'Allows the locations of fixed assets to be defined');
INSERT INTO `scripts` VALUES ('FixedAssetRegister.php',11,'Produces a csv, html or pdf report of the fixed assets over a period showing period depreciation, additions and disposals');
INSERT INTO `scripts` VALUES ('FixedAssetTransfer.php',11,'Allows the fixed asset locations to be changed in bulk');
INSERT INTO `scripts` VALUES ('FormDesigner.php',14,'');
INSERT INTO `scripts` VALUES ('FormMaker.php',1,'Allows running user defined Forms');
INSERT INTO `scripts` VALUES ('FreightCosts.php',11,'Defines the setup of the freight cost using different shipping methods to different destinations. The system can use this information to calculate applicable freight if the items are defined with the correct kgs and cubic volume');
INSERT INTO `scripts` VALUES ('FTP_RadioBeacon.php',2,'FTPs sales orders for dispatch to a radio beacon software enabled warehouse dispatching facility');
INSERT INTO `scripts` VALUES ('geocode.php',3,'');
INSERT INTO `scripts` VALUES ('GeocodeSetup.php',3,'');
INSERT INTO `scripts` VALUES ('geocode_genxml_customers.php',3,'');
INSERT INTO `scripts` VALUES ('geocode_genxml_suppliers.php',3,'');
INSERT INTO `scripts` VALUES ('geo_displaymap_customers.php',3,'');
INSERT INTO `scripts` VALUES ('geo_displaymap_suppliers.php',3,'');
INSERT INTO `scripts` VALUES ('GetStockImage.php',1,'');
INSERT INTO `scripts` VALUES ('GLAccountCSV.php',8,'Produces a CSV of the GL transactions for a particular range of periods and GL account');
INSERT INTO `scripts` VALUES ('GLAccountInquiry.php',8,'Shows the general ledger transactions for a specified account over a specified range of periods');
INSERT INTO `scripts` VALUES ('GLAccountReport.php',8,'Produces a report of the GL transactions for a particular account');
INSERT INTO `scripts` VALUES ('GLAccounts.php',10,'Defines the general ledger accounts');
INSERT INTO `scripts` VALUES ('GLBalanceSheet.php',8,'Shows the balance sheet for the company as at a specified date');
INSERT INTO `scripts` VALUES ('GLBudgets.php',10,'Defines GL Budgets');
INSERT INTO `scripts` VALUES ('GLCodesInquiry.php',8,'Shows the list of general ledger codes defined with account names and groupings');
INSERT INTO `scripts` VALUES ('GLJournal.php',10,'Entry of general ledger journals, periods are calculated based on the date entered here');
INSERT INTO `scripts` VALUES ('GLJournalInquiry.php',15,'General Ledger Journal Inquiry');
INSERT INTO `scripts` VALUES ('GLProfit_Loss.php',8,'Shows the profit and loss of the company for the range of periods entered');
INSERT INTO `scripts` VALUES ('GLTagProfit_Loss.php',8,'');
INSERT INTO `scripts` VALUES ('GLTags.php',10,'Allows GL tags to be defined');
INSERT INTO `scripts` VALUES ('GLTransInquiry.php',8,'Shows the general ledger journal created for the sub ledger transaction specified');
INSERT INTO `scripts` VALUES ('GLTrialBalance.php',8,'Shows the trial balance for the month and the for the period selected together with the budgeted trial balances');
INSERT INTO `scripts` VALUES ('GLTrialBalance_csv.php',8,'Produces a CSV of the Trial Balance for a particular period');
INSERT INTO `scripts` VALUES ('GoodsReceived.php',11,'Entry of items received against purchase orders');
INSERT INTO `scripts` VALUES ('GoodsReceivedButNotInvoiced.php',2,'Shows the list of Goods Received Not Yet Invoiced, both in supplier currency and home currency. Total in home curency should match the GL Account for Goods received not invoiced. Any discrepancy is due to multicurrency errors.');
INSERT INTO `scripts` VALUES ('GoodsReceivedControlled.php',11,'Entry of the serial numbers or batch references for controlled items received against purchase orders');
INSERT INTO `scripts` VALUES ('index.php',1,'The main menu from where all functions available to the user are accessed by clicking on the links');
INSERT INTO `scripts` VALUES ('InternalStockCategoriesByRole.php',15,'Maintains the stock categories to be used as internal for any user security role');
INSERT INTO `scripts` VALUES ('InternalStockRequest.php',1,'Create an internal stock request');
INSERT INTO `scripts` VALUES ('InternalStockRequestAuthorisation.php',1,'Authorise internal stock requests');
INSERT INTO `scripts` VALUES ('InternalStockRequestFulfill.php',1,'Fulfill an internal stock request');
INSERT INTO `scripts` VALUES ('InventoryPlanning.php',2,'Creates a pdf report showing the last 4 months use of items including as a component of assemblies together with stock quantity on hand, current demand for the item and current quantity on sales order.');
INSERT INTO `scripts` VALUES ('InventoryPlanningPrefSupplier.php',2,'Produces a report showing the inventory to be ordered by supplier');
INSERT INTO `scripts` VALUES ('InventoryQuantities.php',2,'');
INSERT INTO `scripts` VALUES ('InventoryValuation.php',2,'Creates a pdf report showing the value of stock at standard cost for a range of product categories selected');
INSERT INTO `scripts` VALUES ('ItemsWithoutPicture.php',15,'Shows the list of curent items without picture in KwaMoja');
INSERT INTO `scripts` VALUES ('Labels.php',15,'Produces item pricing labels in a pdf from a range of selected criteria');
INSERT INTO `scripts` VALUES ('Locations.php',11,'Defines the inventory stocking locations or warehouses');
INSERT INTO `scripts` VALUES ('Logout.php',1,'Shows when the user logs out of KwaMoja');
INSERT INTO `scripts` VALUES ('MailInventoryValuation.php',1,'Meant to be run as a scheduled process to email the stock valuation off to a specified person. Creates the same stock valuation report as InventoryValuation.php');
INSERT INTO `scripts` VALUES ('ManualContents.php',1,'');
INSERT INTO `scripts` VALUES ('MenuAccess.php',15,'');
INSERT INTO `scripts` VALUES ('MRP.php',9,'');
INSERT INTO `scripts` VALUES ('MRPCalendar.php',9,'');
INSERT INTO `scripts` VALUES ('MRPCreateDemands.php',9,'');
INSERT INTO `scripts` VALUES ('MRPDemands.php',9,'');
INSERT INTO `scripts` VALUES ('MRPDemandTypes.php',9,'');
INSERT INTO `scripts` VALUES ('MRPPlannedPurchaseOrders.php',2,'');
INSERT INTO `scripts` VALUES ('MRPPlannedWorkOrders.php',2,'');
INSERT INTO `scripts` VALUES ('MRPReport.php',2,'');
INSERT INTO `scripts` VALUES ('MRPReschedules.php',2,'');
INSERT INTO `scripts` VALUES ('MRPShortages.php',2,'');
INSERT INTO `scripts` VALUES ('NoSalesItems.php',2,'Shows the No Selling (worst) items');
INSERT INTO `scripts` VALUES ('OffersReceived.php',4,'');
INSERT INTO `scripts` VALUES ('OrderDetails.php',2,'Shows the detail of a sales order');
INSERT INTO `scripts` VALUES ('OutstandingGRNs.php',2,'Creates a pdf showing all GRNs for which there has been no purchase invoice matched off against.');
INSERT INTO `scripts` VALUES ('PageSecurity.php',15,'');
INSERT INTO `scripts` VALUES ('PaymentAllocations.php',5,'');
INSERT INTO `scripts` VALUES ('PaymentMethods.php',15,'');
INSERT INTO `scripts` VALUES ('Payments.php',5,'Entry of bank account payments either against an AP account or a general ledger payment - if the AP-GL link in company preferences is set');
INSERT INTO `scripts` VALUES ('PaymentTerms.php',10,'Defines the payment terms records, these can be expressed as either a number of days credit or a day in the following month. All customers and suppliers must have a corresponding payment term recorded against their account');
INSERT INTO `scripts` VALUES ('PcAssignCashToTab.php',6,'');
INSERT INTO `scripts` VALUES ('PcAuthorizeExpenses.php',6,'');
INSERT INTO `scripts` VALUES ('PcClaimExpensesFromTab.php',6,'');
INSERT INTO `scripts` VALUES ('PcExpenses.php',15,'');
INSERT INTO `scripts` VALUES ('PcExpensesTypeTab.php',15,'');
INSERT INTO `scripts` VALUES ('PcReportTab.php',6,'');
INSERT INTO `scripts` VALUES ('PcTabs.php',15,'');
INSERT INTO `scripts` VALUES ('PcTypeTabs.php',15,'');
INSERT INTO `scripts` VALUES ('PDFBankingSummary.php',3,'Creates a pdf showing the amounts entered as receipts on a specified date together with references for the purposes of banking');
INSERT INTO `scripts` VALUES ('PDFChequeListing.php',3,'Creates a pdf showing all payments that have been made from a specified bank account over a specified period. This can be emailed to an email account defined in config.php - ie a financial controller');
INSERT INTO `scripts` VALUES ('PDFCustomerList.php',2,'Creates a report of the customer and branch information held. This report has options to print only customer branches in a specified sales area and sales person. Additional option allows to list only those customers with activity either under or over a specified amount, since a specified date.');
INSERT INTO `scripts` VALUES ('PDFCustTransListing.php',3,'');
INSERT INTO `scripts` VALUES ('PDFDeliveryDifferences.php',3,'Creates a pdf report listing the delivery differences from what the customer requested as recorded in the order entry. The report calculates a percentage of order fill based on the number of orders filled in full on time');
INSERT INTO `scripts` VALUES ('PDFDIFOT.php',3,'Produces a pdf showing the delivery in full on time performance');
INSERT INTO `scripts` VALUES ('PDFGLJournal.php',15,'General Ledger Journal Print');
INSERT INTO `scripts` VALUES ('PDFGrn.php',2,'Produces a GRN report on the receipt of stock');
INSERT INTO `scripts` VALUES ('PDFLowGP.php',2,'Creates a pdf report showing the low gross profit sales made in the selected date range. The percentage of gp deemed acceptable can also be entered');
INSERT INTO `scripts` VALUES ('PDFOrdersInvoiced.php',3,'Produces a pdf of orders invoiced based on selected criteria');
INSERT INTO `scripts` VALUES ('PDFOrderStatus.php',3,'Reports on sales order status by date range, by stock location and stock category - producing a pdf showing each line items and any quantites delivered');
INSERT INTO `scripts` VALUES ('PDFPeriodStockTransListing.php',3,'Allows stock transactions of a specific transaction type to be listed over a single day or period range');
INSERT INTO `scripts` VALUES ('PDFPickingList.php',2,'');
INSERT INTO `scripts` VALUES ('PDFPriceList.php',2,'Creates a pdf of the price list applicable to a given sales type and customer. Also allows the listing of prices specific to a customer');
INSERT INTO `scripts` VALUES ('PDFPrintLabel.php',10,'');
INSERT INTO `scripts` VALUES ('PDFQuotation.php',2,'');
INSERT INTO `scripts` VALUES ('PDFQuotationPortrait.php',2,'Portrait quotation');
INSERT INTO `scripts` VALUES ('PDFReceipt.php',2,'');
INSERT INTO `scripts` VALUES ('PDFRemittanceAdvice.php',2,'');
INSERT INTO `scripts` VALUES ('PDFStockCheckComparison.php',2,'Creates a pdf comparing the quantites entered as counted at a given range of locations against the quantity stored as on hand as at the time a stock check was initiated.');
INSERT INTO `scripts` VALUES ('PDFStockLocTransfer.php',1,'Creates a stock location transfer docket for the selected location transfer reference number');
INSERT INTO `scripts` VALUES ('PDFStockNegatives.php',1,'Produces a pdf of the negative stocks by location');
INSERT INTO `scripts` VALUES ('PDFStockTransfer.php',2,'Produces a report for stock transfers');
INSERT INTO `scripts` VALUES ('PDFSuppTransListing.php',3,'');
INSERT INTO `scripts` VALUES ('PDFTopItems.php',2,'Produces a pdf report of the top items sold');
INSERT INTO `scripts` VALUES ('PeriodsInquiry.php',2,'Shows a list of all the system defined periods');
INSERT INTO `scripts` VALUES ('POReport.php',2,'');
INSERT INTO `scripts` VALUES ('PO_AuthorisationLevels.php',15,'');
INSERT INTO `scripts` VALUES ('PO_AuthoriseMyOrders.php',4,'');
INSERT INTO `scripts` VALUES ('PO_Header.php',4,'Entry of a purchase order header record - date, references buyer etc');
INSERT INTO `scripts` VALUES ('PO_Items.php',4,'Entry of a purchase order items - allows entry of items with lookup of currency cost from Purchasing Data previously entered also allows entry of nominal items against a general ledger code if the AP is integrated to the GL');
INSERT INTO `scripts` VALUES ('PO_OrderDetails.php',2,'Purchase order inquiry shows the quantity received and invoiced of purchase order items as well as the header information');
INSERT INTO `scripts` VALUES ('PO_PDFPurchOrder.php',2,'Creates a pdf of the selected purchase order for printing or email to one of the supplier contacts entered');
INSERT INTO `scripts` VALUES ('PO_SelectOSPurchOrder.php',2,'Shows the outstanding purchase orders for selecting with links to receive or modify the purchase order header and items');
INSERT INTO `scripts` VALUES ('PO_SelectPurchOrder.php',2,'Allows selection of any purchase order with links to the inquiry');
INSERT INTO `scripts` VALUES ('Prices.php',9,'Entry of prices for a selected item also allows selection of sales type and currency for the price');
INSERT INTO `scripts` VALUES ('PricesBasedOnMarkUp.php',11,'');
INSERT INTO `scripts` VALUES ('PricesByCost.php',11,'Allows prices to be updated based on cost');
INSERT INTO `scripts` VALUES ('Prices_Customer.php',11,'Entry of prices for a selected item and selected customer/branch. The currency and sales type is defaulted from the customer\'s record');
INSERT INTO `scripts` VALUES ('PrintCheque.php',5,'');
INSERT INTO `scripts` VALUES ('PrintCustOrder.php',2,'Creates a pdf of the dispatch note - by default this is expected to be on two part pre-printed stationery to allow pickers to note discrepancies for the confirmer to update the dispatch at the time of invoicing');
INSERT INTO `scripts` VALUES ('PrintCustOrder_generic.php',2,'Creates two copies of a laser printed dispatch note - both copies need to be written on by the pickers with any discrepancies to advise customer of any shortfall and on the office copy to ensure the correct quantites are invoiced');
INSERT INTO `scripts` VALUES ('PrintCustStatements.php',2,'Creates a pdf for the customer statements in the selected range');
INSERT INTO `scripts` VALUES ('PrintCustTrans.php',1,'Creates either a html invoice or credit note or a pdf. A range of invoices or credit notes can be selected also.');
INSERT INTO `scripts` VALUES ('PrintCustTransPortrait.php',1,'');
INSERT INTO `scripts` VALUES ('PrintSalesOrder_generic.php',2,'');
INSERT INTO `scripts` VALUES ('PurchData.php',4,'Entry of supplier purchasing data, the suppliers part reference and the suppliers currency cost of the item');
INSERT INTO `scripts` VALUES ('RecurringSalesOrders.php',1,'');
INSERT INTO `scripts` VALUES ('RecurringSalesOrdersProcess.php',1,'Process Recurring Sales Orders');
INSERT INTO `scripts` VALUES ('ReorderLevel.php',2,'Allows reorder levels of inventory to be updated');
INSERT INTO `scripts` VALUES ('ReorderLevelLocation.php',2,'');
INSERT INTO `scripts` VALUES ('ReportBug.php',15,'');
INSERT INTO `scripts` VALUES ('ReportCreator.php',13,'Report Writer and Form Creator script that creates templates for user defined reports and forms');
INSERT INTO `scripts` VALUES ('ReportletContainer.php',1,'');
INSERT INTO `scripts` VALUES ('ReportMaker.php',1,'Produces reports from the report writer templates created');
INSERT INTO `scripts` VALUES ('reportwriter/admin/ReportCreator.php',15,'Report Writer');
INSERT INTO `scripts` VALUES ('ReprintGRN.php',11,'Allows selection of a goods received batch for reprinting the goods received note given a purchase order number');
INSERT INTO `scripts` VALUES ('ReverseGRN.php',11,'Reverses the entry of goods received - creating stock movements back out and necessary general ledger journals to effect the reversal');
INSERT INTO `scripts` VALUES ('SalesAnalReptCols.php',2,'Entry of the definition of a sales analysis report\'s columns.');
INSERT INTO `scripts` VALUES ('SalesAnalRepts.php',2,'Entry of the definition of a sales analysis report headers');
INSERT INTO `scripts` VALUES ('SalesAnalysis_UserDefined.php',2,'Creates a pdf of a selected user defined sales analysis report');
INSERT INTO `scripts` VALUES ('SalesByTypePeriodInquiry.php',2,'Shows sales for a selected date range by sales type/price list');
INSERT INTO `scripts` VALUES ('SalesCategories.php',11,'');
INSERT INTO `scripts` VALUES ('SalesCategoryPeriodInquiry.php',2,'Shows sales for a selected date range by stock category');
INSERT INTO `scripts` VALUES ('SalesGLPostings.php',10,'Defines the general ledger accounts used to post sales to based on product categories and sales areas');
INSERT INTO `scripts` VALUES ('SalesGraph.php',6,'');
INSERT INTO `scripts` VALUES ('SalesInquiry.php',2,'');
INSERT INTO `scripts` VALUES ('SalesPeople.php',3,'Defines the sales people of the business');
INSERT INTO `scripts` VALUES ('SalesTopItemsInquiry.php',2,'Shows the top item sales for a selected date range');
INSERT INTO `scripts` VALUES ('SalesTypes.php',15,'Defines the sales types - prices are held against sales types they can be considered price lists. Sales analysis records are held by sales type too.');
INSERT INTO `scripts` VALUES ('SecurityTokens.php',15,'Administration of security tokens');
INSERT INTO `scripts` VALUES ('SelectAsset.php',2,'Allows a fixed asset to be selected for modification or viewing');
INSERT INTO `scripts` VALUES ('SelectCompletedOrder.php',1,'Allows the selection of completed sales orders for inquiries - choices to select by item code or customer');
INSERT INTO `scripts` VALUES ('SelectContract.php',6,'Allows a contract costing to be selected for modification or viewing');
INSERT INTO `scripts` VALUES ('SelectCreditItems.php',3,'Entry of credit notes from scratch, selecting the items in either quick entry mode or searching for them manually');
INSERT INTO `scripts` VALUES ('SelectCustomer.php',2,'Selection of customer - from where all customer related maintenance, transactions and inquiries start');
INSERT INTO `scripts` VALUES ('SelectGLAccount.php',8,'Selection of general ledger account from where all general ledger account maintenance, or inquiries are initiated');
INSERT INTO `scripts` VALUES ('SelectOrderItems.php',1,'Entry of sales order items with both quick entry and part search functions');
INSERT INTO `scripts` VALUES ('SelectProduct.php',2,'Selection of items. All item maintenance, transactions and inquiries start with this script');
INSERT INTO `scripts` VALUES ('SelectRecurringSalesOrder.php',2,'');
INSERT INTO `scripts` VALUES ('SelectSalesOrder.php',2,'Selects a sales order irrespective of completed or not for inquiries');
INSERT INTO `scripts` VALUES ('SelectSupplier.php',2,'Selects a supplier. A supplier is required to be selected before any AP transactions and before any maintenance or inquiry of the supplier');
INSERT INTO `scripts` VALUES ('SelectWorkOrder.php',2,'');
INSERT INTO `scripts` VALUES ('ShipmentCosting.php',11,'Shows the costing of a shipment with all the items invoice values and any shipment costs apportioned. Updating the shipment has an option to update standard costs of all items on the shipment and create any general ledger variance journals');
INSERT INTO `scripts` VALUES ('Shipments.php',11,'Entry of shipments from outstanding purchase orders for a selected supplier - changes in the delivery date will cascade into the different purchase orders on the shipment');
INSERT INTO `scripts` VALUES ('Shippers.php',15,'Defines the shipping methods available. Each customer branch has a default shipping method associated with it which must match a record from this table');
INSERT INTO `scripts` VALUES ('ShiptsList.php',2,'Shows a list of all the open shipments for a selected supplier. Linked from POItems.php');
INSERT INTO `scripts` VALUES ('Shipt_Select.php',11,'Selection of a shipment for displaying and modification or updating');
INSERT INTO `scripts` VALUES ('SMTPServer.php',15,'');
INSERT INTO `scripts` VALUES ('SpecialOrder.php',4,'Allows for a sales order to be created and an indent order to be created on a supplier for a one off item that may never be purchased again. A dummy part is created based on the description and cost details given.');
INSERT INTO `scripts` VALUES ('StockAdjustments.php',11,'Entry of quantity corrections to stocks in a selected location.');
INSERT INTO `scripts` VALUES ('StockAdjustmentsControlled.php',11,'Entry of batch references or serial numbers on controlled stock items being adjusted');
INSERT INTO `scripts` VALUES ('StockCategories.php',11,'Defines the stock categories. All items must refer to one of these categories. The category record also allows the specification of the general ledger codes where stock items are to be posted - the balance sheet account and the profit and loss effect of any adjustments and the profit and loss effect of any price variances');
INSERT INTO `scripts` VALUES ('StockCheck.php',2,'Allows creation of a stock check file - copying the current quantites in stock for later comparison to the entered counts. Also produces a pdf for the count sheets.');
INSERT INTO `scripts` VALUES ('StockCostUpdate.php',9,'Allows update of the standard cost of items producing general ledger journals if the company preferences stock GL interface is active');
INSERT INTO `scripts` VALUES ('StockCounts.php',2,'Allows entry of stock counts');
INSERT INTO `scripts` VALUES ('StockDispatch.php',2,'');
INSERT INTO `scripts` VALUES ('StockLocMovements.php',2,'Inquiry shows the Movements of all stock items for a specified location');
INSERT INTO `scripts` VALUES ('StockLocStatus.php',2,'Shows the stock on hand together with outstanding sales orders and outstanding purchase orders by stock location for all items in the selected stock category');
INSERT INTO `scripts` VALUES ('StockLocTransfer.php',11,'Entry of a bulk stock location transfer for many parts from one location to another.');
INSERT INTO `scripts` VALUES ('StockLocTransferReceive.php',11,'Effects the transfer and creates the stock movements for a bulk stock location transfer initiated from StockLocTransfer.php');
INSERT INTO `scripts` VALUES ('StockMovements.php',2,'Shows a list of all the stock movements for a selected item and stock location including the price at which they were sold in local currency and the price at which they were purchased for in local currency');
INSERT INTO `scripts` VALUES ('StockQties_csv.php',5,'Makes a comma separated values (CSV)file of the stock item codes and quantities');
INSERT INTO `scripts` VALUES ('StockQuantityByDate.php',2,'Shows the stock on hand for each item at a selected location and stock category as at a specified date');
INSERT INTO `scripts` VALUES ('StockReorderLevel.php',4,'Entry and review of the re-order level of items by stocking location');
INSERT INTO `scripts` VALUES ('Stocks.php',11,'Defines an item - maintenance and addition of new parts');
INSERT INTO `scripts` VALUES ('StockSerialItemResearch.php',3,'');
INSERT INTO `scripts` VALUES ('StockSerialItems.php',2,'Shows a list of the serial numbers or the batch references and quantities of controlled items. This inquiry is linked from the stock status inquiry');
INSERT INTO `scripts` VALUES ('StockStatus.php',2,'Shows the stock on hand together with outstanding sales orders and outstanding purchase orders by stock location for a selected part. Has a link to show the serial numbers in stock at the location selected if the item is controlled');
INSERT INTO `scripts` VALUES ('StockTransferControlled.php',11,'Entry of serial numbers/batch references for controlled items being received on a stock transfer. The script is used by both bulk transfers and point to point transfers');
INSERT INTO `scripts` VALUES ('StockTransfers.php',11,'Entry of point to point stock location transfers of a single part');
INSERT INTO `scripts` VALUES ('StockUsage.php',2,'Inquiry showing the quantity of stock used by period calculated from the sum of the stock movements over that period - by item and stock location. Also available over all locations');
INSERT INTO `scripts` VALUES ('StockUsageGraph.php',2,'');
INSERT INTO `scripts` VALUES ('SuppContractChgs.php',5,'');
INSERT INTO `scripts` VALUES ('SuppCreditGRNs.php',5,'Entry of a supplier credit notes (debit notes) against existing GRN which have already been matched in full or in part');
INSERT INTO `scripts` VALUES ('SuppFixedAssetChgs.php',5,'');
INSERT INTO `scripts` VALUES ('SuppInvGRNs.php',5,'Entry of supplier invoices against goods received');
INSERT INTO `scripts` VALUES ('SupplierAllocations.php',5,'Entry of allocations of supplier payments and credit notes to invoices');
INSERT INTO `scripts` VALUES ('SupplierBalsAtPeriodEnd.php',2,'');
INSERT INTO `scripts` VALUES ('SupplierContacts.php',5,'Entry of supplier contacts and contact details including email addresses');
INSERT INTO `scripts` VALUES ('SupplierCredit.php',5,'Entry of supplier credit notes (debit notes)');
INSERT INTO `scripts` VALUES ('SupplierInquiry.php',2,'Inquiry showing invoices, credit notes and payments made to suppliers together with the amounts outstanding');
INSERT INTO `scripts` VALUES ('SupplierInvoice.php',5,'Entry of supplier invoices');
INSERT INTO `scripts` VALUES ('SupplierPriceList.php',4,'Maintain Supplier Price Lists');
INSERT INTO `scripts` VALUES ('Suppliers.php',5,'Entry of new suppliers and maintenance of existing suppliers');
INSERT INTO `scripts` VALUES ('SupplierTenderCreate.php',4,'Create or Edit tenders');
INSERT INTO `scripts` VALUES ('SupplierTenders.php',9,'');
INSERT INTO `scripts` VALUES ('SupplierTransInquiry.php',2,'');
INSERT INTO `scripts` VALUES ('SupplierTypes.php',4,'');
INSERT INTO `scripts` VALUES ('SuppLoginSetup.php',15,'');
INSERT INTO `scripts` VALUES ('SuppPaymentRun.php',5,'Automatic creation of payment records based on calculated amounts due from AP invoices entered');
INSERT INTO `scripts` VALUES ('SuppPriceList.php',2,'');
INSERT INTO `scripts` VALUES ('SuppShiptChgs.php',5,'Entry of supplier invoices against shipments as charges against a shipment');
INSERT INTO `scripts` VALUES ('SuppTransGLAnalysis.php',5,'Entry of supplier invoices against general ledger codes');
INSERT INTO `scripts` VALUES ('SystemCheck.php',10,'');
INSERT INTO `scripts` VALUES ('SystemParameters.php',15,'');
INSERT INTO `scripts` VALUES ('Tax.php',2,'Creates a report of the ad-valoerm tax - GST/VAT - for the period selected from accounts payable and accounts receivable data');
INSERT INTO `scripts` VALUES ('TaxAuthorities.php',15,'Entry of tax authorities - the state intitutions that charge tax');
INSERT INTO `scripts` VALUES ('TaxAuthorityRates.php',11,'Entry of the rates of tax applicable to the tax authority depending on the item tax level');
INSERT INTO `scripts` VALUES ('TaxCategories.php',15,'Allows for categories of items to be defined that might have different tax rates applied to them');
INSERT INTO `scripts` VALUES ('TaxGroups.php',15,'Allows for taxes to be grouped together where multiple taxes might apply on sale or purchase of items');
INSERT INTO `scripts` VALUES ('TaxProvinces.php',15,'Allows for inventory locations to be defined so that tax applicable from sales in different provinces can be dealt with');
INSERT INTO `scripts` VALUES ('TopItems.php',2,'Shows the top selling items');
INSERT INTO `scripts` VALUES ('UnitsOfMeasure.php',15,'Allows for units of measure to be defined');
INSERT INTO `scripts` VALUES ('UpgradeDatabase.php',15,'Allows for the database to be automatically upgraded based on currently recorded DBUpgradeNumber config option');
INSERT INTO `scripts` VALUES ('UserSettings.php',0,'Allows the user to change system wide defaults for the theme - appearance, the number of records to show in searches and the language to display messages in');
INSERT INTO `scripts` VALUES ('WhereUsedInquiry.php',2,'Inquiry showing where an item is used ie all the parents where the item is a component of');
INSERT INTO `scripts` VALUES ('WorkCentres.php',9,'Defines the various centres of work within a manufacturing company. Also the overhead and labour rates applicable to the work centre and its standard capacity');
INSERT INTO `scripts` VALUES ('WorkOrderCosting.php',11,'');
INSERT INTO `scripts` VALUES ('WorkOrderEntry.php',10,'Entry of new work orders');
INSERT INTO `scripts` VALUES ('WorkOrderIssue.php',11,'Issue of materials to a work order');
INSERT INTO `scripts` VALUES ('WorkOrderReceive.php',11,'Allows for receiving of works orders');
INSERT INTO `scripts` VALUES ('WorkOrderStatus.php',11,'Shows the status of works orders');
INSERT INTO `scripts` VALUES ('WOSerialNos.php',10,'');
INSERT INTO `scripts` VALUES ('WWW_Access.php',15,'');
INSERT INTO `scripts` VALUES ('WWW_Users.php',15,'Entry of users and security settings of users');
INSERT INTO `scripts` VALUES ('Z_BottomUpCosts.php',15,'');
INSERT INTO `scripts` VALUES ('Z_ChangeBranchCode.php',15,'Utility to change the branch code of a customer that cascades the change through all the necessary tables');
INSERT INTO `scripts` VALUES ('Z_ChangeCustomerCode.php',15,'Utility to change a customer code that cascades the change through all the necessary tables');
INSERT INTO `scripts` VALUES ('Z_ChangeLocationCode.php',15,'Change a locations code and in all tables where the old code was used to the new code');
INSERT INTO `scripts` VALUES ('Z_ChangeStockCategory.php',15,'');
INSERT INTO `scripts` VALUES ('Z_ChangeStockCode.php',15,'Utility to change an item code that cascades the change through all the necessary tables');
INSERT INTO `scripts` VALUES ('Z_ChangeSupplierCode.php',15,'Script to change a supplier code accross all tables necessary');
INSERT INTO `scripts` VALUES ('Z_CheckAllocationsFrom.php',15,'');
INSERT INTO `scripts` VALUES ('Z_CheckAllocs.php',2,'');
INSERT INTO `scripts` VALUES ('Z_CheckDebtorsControl.php',15,'Inquiry that shows the total local currency (functional currency) balance of all customer accounts to reconcile with the general ledger debtors account');
INSERT INTO `scripts` VALUES ('Z_CheckGLTransBalance.php',15,'Checks all GL transactions balance and reports problem ones');
INSERT INTO `scripts` VALUES ('Z_CreateChartDetails.php',9,'Utility page to create chart detail records for all general ledger accounts and periods created - needs expert assistance in use');
INSERT INTO `scripts` VALUES ('Z_CreateCompany.php',15,'Utility to insert company number 1 if not already there - actually only company 1 is used - the system is not multi-company');
INSERT INTO `scripts` VALUES ('Z_CreateCompanyTemplateFile.php',15,'');
INSERT INTO `scripts` VALUES ('Z_CurrencyDebtorsBalances.php',15,'Inquiry that shows the total foreign currency together with the total local currency (functional currency) balances of all customer accounts to reconcile with the general ledger debtors account');
INSERT INTO `scripts` VALUES ('Z_CurrencySuppliersBalances.php',15,'Inquiry that shows the total foreign currency amounts and also the local currency (functional currency) balances of all supplier accounts to reconcile with the general ledger creditors account');
INSERT INTO `scripts` VALUES ('Z_DataExport.php',15,'');
INSERT INTO `scripts` VALUES ('Z_DeleteCreditNote.php',15,'Utility to reverse a customer credit note - a desperate measure that should not be used except in extreme circumstances');
INSERT INTO `scripts` VALUES ('Z_DeleteInvoice.php',15,'Utility to reverse a customer invoice - a desperate measure that should not be used except in extreme circumstances');
INSERT INTO `scripts` VALUES ('Z_DeleteOldPrices.php',15,'Deletes all old prices');
INSERT INTO `scripts` VALUES ('Z_DeleteSalesTransActions.php',15,'Utility to delete all sales transactions, sales analysis the lot! Extreme care required!!!');
INSERT INTO `scripts` VALUES ('Z_DescribeTable.php',11,'');
INSERT INTO `scripts` VALUES ('Z_ImportChartOfAccounts.php',11,'');
INSERT INTO `scripts` VALUES ('Z_ImportFixedAssets.php',15,'Allow fixed assets to be imported from a csv');
INSERT INTO `scripts` VALUES ('Z_ImportGLAccountGroups.php',11,'');
INSERT INTO `scripts` VALUES ('Z_ImportGLAccountSections.php',11,'');
INSERT INTO `scripts` VALUES ('Z_ImportPartCodes.php',11,'Allows inventory items to be imported from a csv');
INSERT INTO `scripts` VALUES ('Z_ImportStocks.php',15,'');
INSERT INTO `scripts` VALUES ('Z_index.php',15,'Utility menu page');
INSERT INTO `scripts` VALUES ('Z_ItemsWithoutPicture.php',15,'Shows the list of curent items without picture in webERP');
INSERT INTO `scripts` VALUES ('Z_MakeNewCompany.php',15,'');
INSERT INTO `scripts` VALUES ('Z_MakeStockLocns.php',15,'Utility to make LocStock records for all items and locations if not already set up.');
INSERT INTO `scripts` VALUES ('Z_poAddLanguage.php',15,'Allows a new language po file to be created');
INSERT INTO `scripts` VALUES ('Z_poAdmin.php',15,'Allows for a gettext language po file to be administered');
INSERT INTO `scripts` VALUES ('Z_poEditLangHeader.php',15,'');
INSERT INTO `scripts` VALUES ('Z_poEditLangModule.php',15,'');
INSERT INTO `scripts` VALUES ('Z_poEditLangRemaining.php',15,'');
INSERT INTO `scripts` VALUES ('Z_poRebuildDefault.php',15,'');
INSERT INTO `scripts` VALUES ('Z_PriceChanges.php',15,'Utility to make bulk pricing alterations to selected sales type price lists or selected customer prices only');
INSERT INTO `scripts` VALUES ('Z_ReApplyCostToSA.php',15,'Utility to allow the sales analysis table to be updated with the latest cost information - the sales analysis takes the cost at the time the sale was made to reconcile with the enteries made in the gl.');
INSERT INTO `scripts` VALUES ('Z_RePostGLFromPeriod.php',15,'Utility to repost all general ledger transaction commencing from a specified period. This can take some time in busy environments. Normally GL transactions are posted automatically each time a trial balance or profit and loss account is run');
INSERT INTO `scripts` VALUES ('Z_ReverseSuppPaymentRun.php',15,'Utility to reverse an entire Supplier payment run');
INSERT INTO `scripts` VALUES ('Z_SalesIntegrityCheck.php',15,'');
INSERT INTO `scripts` VALUES ('Z_UpdateChartDetailsBFwd.php',15,'Utility to recalculate the ChartDetails table B/Fwd balances - extreme care!!');
INSERT INTO `scripts` VALUES ('Z_Upgrade3.10.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.01-3.02.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.04-3.05.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.05-3.06.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.07-3.08.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.08-3.09.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.09-3.10.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.10-3.11.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.11-4.00.php',15,'');
INSERT INTO `scripts` VALUES ('Z_UploadForm.php',15,'Utility to upload a file to a remote server');
INSERT INTO `scripts` VALUES ('Z_UploadResult.php',15,'Utility to upload a file to a remote server');

--
-- Dumping data for table `securitygroups`
--

INSERT INTO `securitygroups` VALUES (1,0);
INSERT INTO `securitygroups` VALUES (1,1);
INSERT INTO `securitygroups` VALUES (1,2);
INSERT INTO `securitygroups` VALUES (2,0);
INSERT INTO `securitygroups` VALUES (2,1);
INSERT INTO `securitygroups` VALUES (2,2);
INSERT INTO `securitygroups` VALUES (2,11);
INSERT INTO `securitygroups` VALUES (3,0);
INSERT INTO `securitygroups` VALUES (3,1);
INSERT INTO `securitygroups` VALUES (3,2);
INSERT INTO `securitygroups` VALUES (3,3);
INSERT INTO `securitygroups` VALUES (3,4);
INSERT INTO `securitygroups` VALUES (3,5);
INSERT INTO `securitygroups` VALUES (3,11);
INSERT INTO `securitygroups` VALUES (4,0);
INSERT INTO `securitygroups` VALUES (4,1);
INSERT INTO `securitygroups` VALUES (4,2);
INSERT INTO `securitygroups` VALUES (4,5);
INSERT INTO `securitygroups` VALUES (5,0);
INSERT INTO `securitygroups` VALUES (5,1);
INSERT INTO `securitygroups` VALUES (5,2);
INSERT INTO `securitygroups` VALUES (5,3);
INSERT INTO `securitygroups` VALUES (5,11);
INSERT INTO `securitygroups` VALUES (6,0);
INSERT INTO `securitygroups` VALUES (6,1);
INSERT INTO `securitygroups` VALUES (6,2);
INSERT INTO `securitygroups` VALUES (6,3);
INSERT INTO `securitygroups` VALUES (6,4);
INSERT INTO `securitygroups` VALUES (6,5);
INSERT INTO `securitygroups` VALUES (6,6);
INSERT INTO `securitygroups` VALUES (6,7);
INSERT INTO `securitygroups` VALUES (6,8);
INSERT INTO `securitygroups` VALUES (6,9);
INSERT INTO `securitygroups` VALUES (6,10);
INSERT INTO `securitygroups` VALUES (6,11);
INSERT INTO `securitygroups` VALUES (7,0);
INSERT INTO `securitygroups` VALUES (7,1);
INSERT INTO `securitygroups` VALUES (8,0);
INSERT INTO `securitygroups` VALUES (8,1);
INSERT INTO `securitygroups` VALUES (8,2);
INSERT INTO `securitygroups` VALUES (8,3);
INSERT INTO `securitygroups` VALUES (8,4);
INSERT INTO `securitygroups` VALUES (8,5);
INSERT INTO `securitygroups` VALUES (8,6);
INSERT INTO `securitygroups` VALUES (8,7);
INSERT INTO `securitygroups` VALUES (8,8);
INSERT INTO `securitygroups` VALUES (8,9);
INSERT INTO `securitygroups` VALUES (8,10);
INSERT INTO `securitygroups` VALUES (8,11);
INSERT INTO `securitygroups` VALUES (8,12);
INSERT INTO `securitygroups` VALUES (8,13);
INSERT INTO `securitygroups` VALUES (8,14);
INSERT INTO `securitygroups` VALUES (8,15);
INSERT INTO `securitygroups` VALUES (8,1000);
INSERT INTO `securitygroups` VALUES (9,0);
INSERT INTO `securitygroups` VALUES (9,9);

--
-- Dumping data for table `securitytokens`
--

INSERT INTO `securitytokens` VALUES (0,'Main Index Page');
INSERT INTO `securitytokens` VALUES (1,'Order Entry/Inquiries customer access only');
INSERT INTO `securitytokens` VALUES (2,'Basic Reports and Inquiries with selection options');
INSERT INTO `securitytokens` VALUES (3,'Credit notes and AR management');
INSERT INTO `securitytokens` VALUES (4,'Purchasing data/PO Entry/Reorder Levels');
INSERT INTO `securitytokens` VALUES (5,'Accounts Payable');
INSERT INTO `securitytokens` VALUES (6,'Petty Cash');
INSERT INTO `securitytokens` VALUES (7,'Bank Reconciliations');
INSERT INTO `securitytokens` VALUES (8,'General ledger reports/inquiries');
INSERT INTO `securitytokens` VALUES (9,'Supplier centre - Supplier access only');
INSERT INTO `securitytokens` VALUES (10,'General Ledger Maintenance, stock valuation & Configuration');
INSERT INTO `securitytokens` VALUES (11,'Inventory Management and Pricing');
INSERT INTO `securitytokens` VALUES (12,'Unknown');
INSERT INTO `securitytokens` VALUES (13,'Unknown');
INSERT INTO `securitytokens` VALUES (14,'Unknown');
INSERT INTO `securitytokens` VALUES (15,'User Management and System Administration');
INSERT INTO `securitytokens` VALUES (1000,'User can view and alter sales prices');
INSERT INTO `securitytokens` VALUES (1001,'User can bypass purchasing security and go straight from order to invoice');

--
-- Dumping data for table `securityroles`
--

INSERT INTO `securityroles` VALUES (1,'Inquiries/Order Entry');
INSERT INTO `securityroles` VALUES (2,'Manufac/Stock Admin');
INSERT INTO `securityroles` VALUES (3,'Purchasing Officer');
INSERT INTO `securityroles` VALUES (4,'AP Clerk');
INSERT INTO `securityroles` VALUES (5,'AR Clerk');
INSERT INTO `securityroles` VALUES (6,'Accountant');
INSERT INTO `securityroles` VALUES (7,'Customer Log On Only');
INSERT INTO `securityroles` VALUES (8,'System Administrator');
INSERT INTO `securityroles` VALUES (9,'Supplier Log On Only');

--
-- Dumping data for table `accountsection`
--

INSERT INTO `accountsection` VALUES (1,'Income');
INSERT INTO `accountsection` VALUES (2,'Cost Of Sales');
INSERT INTO `accountsection` VALUES (5,'Overheads');
INSERT INTO `accountsection` VALUES (10,'Fixed Assets');
INSERT INTO `accountsection` VALUES (20,'Amounts Receivable');
INSERT INTO `accountsection` VALUES (30,'Amounts Payable');
INSERT INTO `accountsection` VALUES (50,'Financed By');
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-01-25 10:39:53
SET FOREIGN_KEY_CHECKS = 1;
UPDATE systypes SET typeno=0;
INSERT INTO shippers VALUES (1,'Default Shipper',0);
UPDATE config SET confvalue='1' WHERE confname='Default_Shipper';
