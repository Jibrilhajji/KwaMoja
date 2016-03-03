<?php
InsertRecord('accountsection',array('sectionid'),array(10),array('sectionid','sectionname'),array(10,'Assets'));
InsertRecord('accountsection',array('sectionid'),array(20),array('sectionid','sectionname'),array(20,'Liabilities'));
InsertRecord('accountsection',array('sectionid'),array(30),array('sectionid','sectionname'),array(30,'Income'));
InsertRecord('accountsection',array('sectionid'),array(40),array('sectionid','sectionname'),array(40,'Costs'));
InsertRecord('accountgroups',array('groupname'),array('CAPITAL ASSETS'),array('groupcode', 'groupname','sectioninaccounts','pandl','sequenceintb','parentgroupname','parentgroupcode'),array('10','CAPITAL ASSETS','10','0','1000','',''));
InsertRecord('accountgroups',array('groupname'),array('COST OF GOODS SOLD'),array('groupcode', 'groupname','sectioninaccounts','pandl','sequenceintb','parentgroupname','parentgroupcode'),array('20','COST OF GOODS SOLD','40','1','8000','',''));
InsertRecord('accountgroups',array('groupname'),array('CURRENT ASSETS'),array('groupcode', 'groupname','sectioninaccounts','pandl','sequenceintb','parentgroupname','parentgroupcode'),array('30','CURRENT ASSETS','10','0','3000','',''));
InsertRecord('accountgroups',array('groupname'),array('CURRENT LIABILITIES'),array('groupcode', 'groupname','sectioninaccounts','pandl','sequenceintb','parentgroupname','parentgroupcode'),array('40','CURRENT LIABILITIES','10','0','4000','',''));
InsertRecord('accountgroups',array('groupname'),array('GENERAL & ADMINISTRATIVE EXPEN'),array('groupcode', 'groupname','sectioninaccounts','pandl','sequenceintb','parentgroupname','parentgroupcode'),array('50','GENERAL & ADMINISTRATIVE EXPEN','40','1','10000','',''));
InsertRecord('accountgroups',array('groupname'),array('INVENTORY ASSETS'),array('groupcode', 'groupname','sectioninaccounts','pandl','sequenceintb','parentgroupname','parentgroupcode'),array('60','INVENTORY ASSETS','10','0','2000','',''));
InsertRecord('accountgroups',array('groupname'),array('LONG TERM LIABILITIES'),array('groupcode', 'groupname','sectioninaccounts','pandl','sequenceintb','parentgroupname','parentgroupcode'),array('70','LONG TERM LIABILITIES','20','0','5000','',''));
InsertRecord('accountgroups',array('groupname'),array('PAYROLL EXPENSES'),array('groupcode', 'groupname','sectioninaccounts','pandl','sequenceintb','parentgroupname','parentgroupcode'),array('80','PAYROLL EXPENSES','40','1','9000','',''));
InsertRecord('accountgroups',array('groupname'),array('SALES REVENUE'),array('groupcode', 'groupname','sectioninaccounts','pandl','sequenceintb','parentgroupname','parentgroupcode'),array('90','SALES REVENUE','30','1','7000','',''));
InsertRecord('accountgroups',array('groupname'),array('SHARE CAPITAL'),array('groupcode', 'groupname','sectioninaccounts','pandl','sequenceintb','parentgroupname','parentgroupcode'),array('100','SHARE CAPITAL','20','0','6000','',''));
InsertRecord('chartmaster',array('accountcode'),array('0010'),array('accountcode','accountname','group_'),array('0010','Freehold Property','CAPITAL ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('0011'),array('accountcode','accountname','group_'),array('0011','Goodwill','CAPITAL ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('0012'),array('accountcode','accountname','group_'),array('0012','Goodwill Amortisation','CAPITAL ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('0020'),array('accountcode','accountname','group_'),array('0020','Plant and Machinery','CAPITAL ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('0021'),array('accountcode','accountname','group_'),array('0021','Plant/Machinery Depreciation','CAPITAL ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('0030'),array('accountcode','accountname','group_'),array('0030','Office Equipment','CAPITAL ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('0031'),array('accountcode','accountname','group_'),array('0031','Office Equipment Depreciation','CAPITAL ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('0040'),array('accountcode','accountname','group_'),array('0040','Furniture and Fixtures','CAPITAL ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('0041'),array('accountcode','accountname','group_'),array('0041','Furniture/Fixture Depreciation','CAPITAL ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('0050'),array('accountcode','accountname','group_'),array('0050','Motor Vehicles','CAPITAL ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('0051'),array('accountcode','accountname','group_'),array('0051','Motor Vehicles Depreciation','CAPITAL ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('1001'),array('accountcode','accountname','group_'),array('1001','Stock','INVENTORY ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('1002'),array('accountcode','accountname','group_'),array('1002','Work in Progress','INVENTORY ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('1100'),array('accountcode','accountname','group_'),array('1100','Debtors Control Account','CURRENT ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('1102'),array('accountcode','accountname','group_'),array('1102','Other Debtors','CURRENT ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('1103'),array('accountcode','accountname','group_'),array('1103','Prepayments','CURRENT ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('1200'),array('accountcode','accountname','group_'),array('1200','Bank Current Account','CURRENT ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('1210'),array('accountcode','accountname','group_'),array('1210','Bank Deposit Account','CURRENT ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('1220'),array('accountcode','accountname','group_'),array('1220','Building Society Account','CURRENT ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('1230'),array('accountcode','accountname','group_'),array('1230','Petty Cash','CURRENT ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('1240'),array('accountcode','accountname','group_'),array('1240','Company Credit Card','CURRENT ASSETS'));
InsertRecord('chartmaster',array('accountcode'),array('2100'),array('accountcode','accountname','group_'),array('2100','Creditors Control Account','CURRENT LIABILITIES'));
InsertRecord('chartmaster',array('accountcode'),array('2102'),array('accountcode','accountname','group_'),array('2102','Other Creditors','CURRENT LIABILITIES'));
InsertRecord('chartmaster',array('accountcode'),array('2109'),array('accountcode','accountname','group_'),array('2109','Accruals','CURRENT LIABILITIES'));
InsertRecord('chartmaster',array('accountcode'),array('2200'),array('accountcode','accountname','group_'),array('2200','VAT (17.5%)','CURRENT LIABILITIES'));
InsertRecord('chartmaster',array('accountcode'),array('2205'),array('accountcode','accountname','group_'),array('2205','VAT (5%)','CURRENT LIABILITIES'));
InsertRecord('chartmaster',array('accountcode'),array('2210'),array('accountcode','accountname','group_'),array('2210','P.A.Y.E. & National Insurance','CURRENT LIABILITIES'));
InsertRecord('chartmaster',array('accountcode'),array('2220'),array('accountcode','accountname','group_'),array('2220','Net Wages','CURRENT LIABILITIES'));
InsertRecord('chartmaster',array('accountcode'),array('2250'),array('accountcode','accountname','group_'),array('2250','Corporation Tax','CURRENT LIABILITIES'));
InsertRecord('chartmaster',array('accountcode'),array('2300'),array('accountcode','accountname','group_'),array('2300','Bank Loan','LONG TERM LIABILITIES'));
InsertRecord('chartmaster',array('accountcode'),array('2305'),array('accountcode','accountname','group_'),array('2305','Directors loan account','LONG TERM LIABILITIES'));
InsertRecord('chartmaster',array('accountcode'),array('2310'),array('accountcode','accountname','group_'),array('2310','Hire Purchase','LONG TERM LIABILITIES'));
InsertRecord('chartmaster',array('accountcode'),array('2330'),array('accountcode','accountname','group_'),array('2330','Mortgages','LONG TERM LIABILITIES'));
InsertRecord('chartmaster',array('accountcode'),array('3000'),array('accountcode','accountname','group_'),array('3000','Ordinary Shares','SHARE CAPITAL'));
InsertRecord('chartmaster',array('accountcode'),array('3010'),array('accountcode','accountname','group_'),array('3010','Preference Shares','SHARE CAPITAL'));
InsertRecord('chartmaster',array('accountcode'),array('3100'),array('accountcode','accountname','group_'),array('3100','Share Premium Account','SHARE CAPITAL'));
InsertRecord('chartmaster',array('accountcode'),array('3200'),array('accountcode','accountname','group_'),array('3200','Profit and Loss Account','SHARE CAPITAL'));
InsertRecord('chartmaster',array('accountcode'),array('4000'),array('accountcode','accountname','group_'),array('4000','Sales','SALES REVENUE'));
InsertRecord('chartmaster',array('accountcode'),array('4009'),array('accountcode','accountname','group_'),array('4009','Discounts Allowed','SALES REVENUE'));
InsertRecord('chartmaster',array('accountcode'),array('4010'),array('accountcode','accountname','group_'),array('4010','Export Sales','SALES REVENUE'));
InsertRecord('chartmaster',array('accountcode'),array('4900'),array('accountcode','accountname','group_'),array('4900','Miscellaneous Income','SALES REVENUE'));
InsertRecord('chartmaster',array('accountcode'),array('4904'),array('accountcode','accountname','group_'),array('4904','Rent Income','SALES REVENUE'));
InsertRecord('chartmaster',array('accountcode'),array('4906'),array('accountcode','accountname','group_'),array('4906','Interest received','SALES REVENUE'));
InsertRecord('chartmaster',array('accountcode'),array('4920'),array('accountcode','accountname','group_'),array('4920','Foreign Exchange Gain','SALES REVENUE'));
InsertRecord('chartmaster',array('accountcode'),array('5000'),array('accountcode','accountname','group_'),array('5000','Materials Purchased','COST OF GOODS SOLD'));
InsertRecord('chartmaster',array('accountcode'),array('5001'),array('accountcode','accountname','group_'),array('5001','Materials Imported','COST OF GOODS SOLD'));
InsertRecord('chartmaster',array('accountcode'),array('5002'),array('accountcode','accountname','group_'),array('5002','Opening Stock','COST OF GOODS SOLD'));
InsertRecord('chartmaster',array('accountcode'),array('5003'),array('accountcode','accountname','group_'),array('5003','Closing Stock','COST OF GOODS SOLD'));
InsertRecord('chartmaster',array('accountcode'),array('5200'),array('accountcode','accountname','group_'),array('5200','Packaging','COST OF GOODS SOLD'));
InsertRecord('chartmaster',array('accountcode'),array('5201'),array('accountcode','accountname','group_'),array('5201','Discounts Taken','COST OF GOODS SOLD'));
InsertRecord('chartmaster',array('accountcode'),array('5202'),array('accountcode','accountname','group_'),array('5202','Carriage','COST OF GOODS SOLD'));
InsertRecord('chartmaster',array('accountcode'),array('5203'),array('accountcode','accountname','group_'),array('5203','Import Duty','COST OF GOODS SOLD'));
InsertRecord('chartmaster',array('accountcode'),array('5204'),array('accountcode','accountname','group_'),array('5204','Transport Insurance','COST OF GOODS SOLD'));
InsertRecord('chartmaster',array('accountcode'),array('5205'),array('accountcode','accountname','group_'),array('5205','Equipment Hire','COST OF GOODS SOLD'));
InsertRecord('chartmaster',array('accountcode'),array('5220'),array('accountcode','accountname','group_'),array('5220','Foreign Exchange Loss','COST OF GOODS SOLD'));
InsertRecord('chartmaster',array('accountcode'),array('6000'),array('accountcode','accountname','group_'),array('6000','Productive Labour','PAYROLL EXPENSES'));
InsertRecord('chartmaster',array('accountcode'),array('6001'),array('accountcode','accountname','group_'),array('6001','Cost of Sales Labour','PAYROLL EXPENSES'));
InsertRecord('chartmaster',array('accountcode'),array('6002'),array('accountcode','accountname','group_'),array('6002','Sub-Contractors','PAYROLL EXPENSES'));
InsertRecord('chartmaster',array('accountcode'),array('7000'),array('accountcode','accountname','group_'),array('7000','Staff wages & salaries','PAYROLL EXPENSES'));
InsertRecord('chartmaster',array('accountcode'),array('7002'),array('accountcode','accountname','group_'),array('7002','Directors Remuneration','PAYROLL EXPENSES'));
InsertRecord('chartmaster',array('accountcode'),array('7006'),array('accountcode','accountname','group_'),array('7006','Employers N.I.','PAYROLL EXPENSES'));
InsertRecord('chartmaster',array('accountcode'),array('7007'),array('accountcode','accountname','group_'),array('7007','Employers Pensions','PAYROLL EXPENSES'));
InsertRecord('chartmaster',array('accountcode'),array('7008'),array('accountcode','accountname','group_'),array('7008','Recruitment Expenses','PAYROLL EXPENSES'));
InsertRecord('chartmaster',array('accountcode'),array('7100'),array('accountcode','accountname','group_'),array('7100','Rent','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7102'),array('accountcode','accountname','group_'),array('7102','Water Rates','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7103'),array('accountcode','accountname','group_'),array('7103','General Rates','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7104'),array('accountcode','accountname','group_'),array('7104','Premises Insurance','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7200'),array('accountcode','accountname','group_'),array('7200','Light & heat','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7300'),array('accountcode','accountname','group_'),array('7300','Motor expenses','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7350'),array('accountcode','accountname','group_'),array('7350','Travelling','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7400'),array('accountcode','accountname','group_'),array('7400','Advertising','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7402'),array('accountcode','accountname','group_'),array('7402','P.R. (Literature & Brochures)','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7403'),array('accountcode','accountname','group_'),array('7403','U.K. Entertainment','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7404'),array('accountcode','accountname','group_'),array('7404','Overseas Entertainment','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7500'),array('accountcode','accountname','group_'),array('7500','Postage and Carriage','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7501'),array('accountcode','accountname','group_'),array('7501','Office Stationery','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7502'),array('accountcode','accountname','group_'),array('7502','Telephone','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7506'),array('accountcode','accountname','group_'),array('7506','Web Site costs','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7600'),array('accountcode','accountname','group_'),array('7600','Legal Fees','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7601'),array('accountcode','accountname','group_'),array('7601','Audit and Accountancy Fees','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7603'),array('accountcode','accountname','group_'),array('7603','Professional Fees','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7701'),array('accountcode','accountname','group_'),array('7701','Office Machine Maintenance','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7710'),array('accountcode','accountname','group_'),array('7710','Computer expenses','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7800'),array('accountcode','accountname','group_'),array('7800','Repairs and Renewals','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7801'),array('accountcode','accountname','group_'),array('7801','Cleaning','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7802'),array('accountcode','accountname','group_'),array('7802','Laundry','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7900'),array('accountcode','accountname','group_'),array('7900','Bank Interest Paid','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7901'),array('accountcode','accountname','group_'),array('7901','Bank Charges','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7903'),array('accountcode','accountname','group_'),array('7903','Loan Interest Paid','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('7904'),array('accountcode','accountname','group_'),array('7904','H.P. Interest','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('8000'),array('accountcode','accountname','group_'),array('8000','Depreciation','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('8005'),array('accountcode','accountname','group_'),array('8005','Goodwill Amortisation','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('8100'),array('accountcode','accountname','group_'),array('8100','Bad Debt Write Off','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('8201'),array('accountcode','accountname','group_'),array('8201','Subscriptions','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('8202'),array('accountcode','accountname','group_'),array('8202','Clothing Costs','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('8203'),array('accountcode','accountname','group_'),array('8203','Training Costs','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('8204'),array('accountcode','accountname','group_'),array('8204','Insurance','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('8205'),array('accountcode','accountname','group_'),array('8205','Refreshments','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('8500'),array('accountcode','accountname','group_'),array('8500','Dividends','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('8600'),array('accountcode','accountname','group_'),array('8600','Corporation Tax','GENERAL & ADMINISTRATIVE EXPEN'));
InsertRecord('chartmaster',array('accountcode'),array('9999'),array('accountcode','accountname','group_'),array('9999','Suspense Account','GENERAL & ADMINISTRATIVE EXPEN'));
?>