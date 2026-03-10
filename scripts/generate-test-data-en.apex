// ============================================================
// KSeF Test Data Generator (EN)
// Deletes old data, creates invoices for all 10 types.
// Seller data comes from KSeF_Seller__mdt — not set here.
// Uses Date.today() so dates are never in the future.
// Random invoice numbers to avoid KSeF duplicate rejection.
// Seller NIP for KSeF refs: 9223073555
// ============================================================

delete [SELECT Id FROM Invoice_Line__c];
delete [SELECT Id FROM Invoice__c];

Date today = Date.today();

// Unique 4-digit seed so invoice numbers never collide with previous runs
Integer seed = Math.mod(Math.abs(Crypto.getRandomInteger()), 9000) + 1000;
String s = String.valueOf(seed);

// --- 1. VAT — standard, full payment info ---
Invoice__c inv1 = new Invoice__c(
    Invoice_Number__c = 'FV/' + s + '/01',
    Seller_NIP__c = '9223073555',
    Invoice_Type__c = 'VAT',
    Issue_Date__c = today,
    Sale_Date__c = today,
    Currency_Code__c = 'PLN',
    Buyer_NIP__c = '9252657506',
    Buyer_Name__c = 'Test Group Sp. z o.o.',
    Buyer_ID_Type__c = 'NIP',
    Buyer_Country__c = 'PL',
    Buyer_Address_L1__c = 'Aleje Jerozolimskie 1',
    Buyer_Address_L2__c = '02-305 Warszawa',
    Payment_Method__c = '6',
    Payment_Due_Date__c = today.addDays(7),
    Bank_Account_Number__c = '50114025340000350282727732',
    Bank_Name__c = 'mBank',
    Bank_SWIFT__c = 'BREXPLPWMBK',
    Is_Own_Bank_Account__c = true,
    Bank_Account_Description__c = 'Main company account'
);
insert inv1;

insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv1.Id, Line_Number__c = 1,
        Description__c = 'Software development services', Unit__c = 'h',
        Quantity__c = 186, Unit_Price_Net__c = 142, Net_Amount__c = 26412,
        VAT_Rate__c = '23', VAT_Amount__c = 6074.76, Gross_Amount__c = 32486.76,
        PKWiU__c = '62.01.11.0')
};

// --- 2. VAT — EU buyer (NrVatUE), reverse charge ---
Invoice__c inv2 = new Invoice__c(
    Invoice_Number__c = 'FV/' + s + '/02',
    Seller_NIP__c = '9223073555',
    Invoice_Type__c = 'VAT',
    Issue_Date__c = today,
    Sale_Date__c = today,
    Currency_Code__c = 'EUR',
    Buyer_NIP__c = 'DE123456789',
    Buyer_Name__c = 'Deutsche GmbH',
    Buyer_ID_Type__c = 'NrVatUE',
    Buyer_Country__c = 'DE',
    Buyer_Address_L1__c = 'Berliner Str. 10',
    Buyer_Address_L2__c = '10115 Berlin',
    Payment_Method__c = '6',
    Payment_Due_Date__c = today.addDays(14),
    Bank_Account_Number__c = '50114020140000350282727731',
    Bank_Name__c = 'mBank'
);
insert inv2;

insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv2.Id, Line_Number__c = 1,
        Description__c = 'Consulting services', Unit__c = 'h',
        Quantity__c = 40, Unit_Price_Net__c = 100, Net_Amount__c = 4000,
        VAT_Rate__c = 'oo', VAT_Amount__c = 0, Gross_Amount__c = 4000)
};

// --- 3. VAT — split payment (MPP) ---
Invoice__c inv3 = new Invoice__c(
    Invoice_Number__c = 'FV/' + s + '/03',
    Seller_NIP__c = '9223073555',
    Invoice_Type__c = 'VAT',
    Issue_Date__c = today,
    Sale_Date__c = today,
    Currency_Code__c = 'PLN',
    Is_Split_Payment__c = true,
    Buyer_NIP__c = '1232657031',
    Buyer_Name__c = 'Budimex S.A.',
    Buyer_ID_Type__c = 'NIP',
    Buyer_Country__c = 'PL',
    Buyer_Address_L1__c = 'ul. Stawki 40',
    Buyer_Address_L2__c = '01-040 Warszawa',
    Payment_Method__c = '6',
    Payment_Due_Date__c = today.addDays(14),
    Bank_Account_Number__c = '50114020040030350282727732',
    Bank_Name__c = 'Santa Bank'
);
insert inv3;

insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv3.Id, Line_Number__c = 1,
        Description__c = 'Computer equipment delivery', Unit__c = 'pcs',
        Quantity__c = 5, Unit_Price_Net__c = 4000, Net_Amount__c = 20000,
        VAT_Rate__c = '23', VAT_Amount__c = 4600, Gross_Amount__c = 24600,
        PKWiU__c = '26.20.11.1')
};

// --- 4. KOR — correction with KSeF ref (corrects inv1 buyer) ---
Invoice__c inv4 = new Invoice__c(
    Invoice_Number__c = 'KOR/' + s + '/04',
    Seller_NIP__c = '9223073555',
    Invoice_Type__c = 'KOR',
    Issue_Date__c = today,
    Sale_Date__c = today.addDays(-7),
    Currency_Code__c = 'PLN',
    Buyer_NIP__c = '9252657506',
    Buyer_Name__c = 'Test Group Sp. z o.o.',
    Buyer_ID_Type__c = 'NIP',
    Buyer_Country__c = 'PL',
    Buyer_Address_L1__c = 'Aleje Jerozolimskie 1',
    Buyer_Address_L2__c = '02-305 Warszawa',
    Correction_Reason__c = 'Hours quantity correction — 186h to 180h',
    Correction_Type__c = '1',
    Corrected_Invoice_Number__c = 'FV/' + s + '/01',
    Corrected_Invoice_Date__c = today.addDays(-7),
    Corrected_Invoice_KSeF_Ref__c = '9223073555-20260303-A1B2C3-D4E5F6-01',
    Payment_Method__c = '6',
    Payment_Due_Date__c = today.addDays(7),
    Bank_Account_Number__c = '50114025340000350282727732',
    Bank_Name__c = 'mBank'
);
insert inv4;

insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv4.Id, Line_Number__c = 1,
        Description__c = 'Software development services', Unit__c = 'h',
        Quantity__c = 180, Unit_Price_Net__c = 142, Net_Amount__c = 25560,
        VAT_Rate__c = '23', VAT_Amount__c = 5878.80, Gross_Amount__c = 31438.80,
        PKWiU__c = '62.01.11.0')
};

// --- 5. KOR — correction without KSeF ref (pre-KSeF invoice) ---
Invoice__c inv5 = new Invoice__c(
    Invoice_Number__c = 'KOR/' + s + '/05',
    Seller_NIP__c = '9223073555',
    Invoice_Type__c = 'KOR',
    Issue_Date__c = today,
    Sale_Date__c = today.addDays(-10),
    Currency_Code__c = 'PLN',
    Buyer_NIP__c = '1252657506',
    Buyer_Name__c = 'Alfa Consulting Sp. z o.o.',
    Buyer_ID_Type__c = 'NIP',
    Buyer_Country__c = 'PL',
    Buyer_Address_L1__c = 'ul. Marszalkowska 55',
    Buyer_Address_L2__c = '00-676 Warszawa',
    Correction_Reason__c = 'Change of buyer data',
    Correction_Type__c = '3',
    Corrected_Invoice_Number__c = 'FV/2025/001',
    Corrected_Invoice_Date__c = Date.newInstance(2025, 1, 15)
);
insert inv5;

insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv5.Id, Line_Number__c = 1,
        Description__c = 'Software development services', Unit__c = 'h',
        Quantity__c = 160, Unit_Price_Net__c = 130, Net_Amount__c = 20800,
        VAT_Rate__c = '23', VAT_Amount__c = 4784, Gross_Amount__c = 25584,
        PKWiU__c = '62.01.11.0')
};

// --- 6. ZAL — advance payment ---
Invoice__c inv6 = new Invoice__c(
    Invoice_Number__c = 'ZAL/' + s + '/06',
    Seller_NIP__c = '9223073555',
    Invoice_Type__c = 'ZAL',
    Issue_Date__c = today,
    Currency_Code__c = 'PLN',
    Buyer_NIP__c = '2252657506',
    Buyer_Name__c = 'Nova Systems Sp. z o.o.',
    Buyer_ID_Type__c = 'NIP',
    Buyer_Country__c = 'PL',
    Buyer_Address_L1__c = 'ul. Pulawska 233',
    Buyer_Address_L2__c = '02-715 Warszawa',
    Payment_Method__c = '6',
    Payment_Due_Date__c = today.addDays(7),
    Bank_Account_Number__c = '50114012340000350282727737',
    Bank_Name__c = 'mBank'
);
insert inv6;

insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv6.Id, Line_Number__c = 1,
        Description__c = 'Advance payment — ERP implementation project', Unit__c = 'pcs',
        Quantity__c = 1, Unit_Price_Net__c = 50000, Net_Amount__c = 50000,
        VAT_Rate__c = '23', VAT_Amount__c = 11500, Gross_Amount__c = 61500)
};

// --- 7. ROZ — settlement with KSeF ref to advance ---
Invoice__c inv7 = new Invoice__c(
    Invoice_Number__c = 'ROZ/' + s + '/07',
    Seller_NIP__c = '9223073555',
    Invoice_Type__c = 'ROZ',
    Issue_Date__c = today,
    Sale_Date__c = today,
    Currency_Code__c = 'PLN',
    Buyer_NIP__c = '2252657506',
    Buyer_Name__c = 'Nova Systems Sp. z o.o.',
    Buyer_ID_Type__c = 'NIP',
    Buyer_Country__c = 'PL',
    Buyer_Address_L1__c = 'ul. Pulawska 233',
    Buyer_Address_L2__c = '02-715 Warszawa',
    Advance_Invoice_Number__c = 'ZAL/' + s + '/06',
    Advance_Invoice_KSeF_Ref__c = '9223073555-20260301-D4E5F6-A0B1C2-02',
    Payment_Method__c = '6',
    Payment_Due_Date__c = today.addDays(14),
    Bank_Account_Number__c = '50114012340000350282727737',
    Bank_Name__c = 'mBank'
);
insert inv7;

// Line items = total contract minus advance (art. 106f ust. 3)
// Full contract: 150,000 net. Advance (inv6): 50,000 net. Remaining: 100,000 net.
insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv7.Id, Line_Number__c = 1,
        Description__c = 'ERP implementation — final settlement (after advance deduction)', Unit__c = 'pcs',
        Quantity__c = 1, Unit_Price_Net__c = 100000, Net_Amount__c = 100000,
        VAT_Rate__c = '23', VAT_Amount__c = 23000, Gross_Amount__c = 123000)
};

// --- 8. UPR — simplified (<=450 PLN, single-line from gross) ---
Invoice__c inv8 = new Invoice__c(
    Invoice_Number__c = 'UPR/' + s + '/08',
    Seller_NIP__c = '9223073555',
    Invoice_Type__c = 'UPR',
    Issue_Date__c = today,
    Currency_Code__c = 'PLN',
    Buyer_NIP__c = '9252657506',
    Buyer_Name__c = 'Test Group Sp. z o.o.',
    Buyer_ID_Type__c = 'NIP',
    Buyer_Country__c = 'PL',
    Buyer_Address_L1__c = 'Aleje Jerozolimskie 1',
    Buyer_Address_L2__c = '02-305 Warszawa'
);
insert inv8;

insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv8.Id, Line_Number__c = 1,
        Description__c = 'Technical consultation', Unit__c = 'pcs',
        Quantity__c = 1, Unit_Price_Net__c = 300, Net_Amount__c = 300,
        VAT_Rate__c = '23', VAT_Amount__c = 69, Gross_Amount__c = 369)
};

// --- 9. KOR_ZAL — correction of advance (corrects inv6 buyer) ---
Invoice__c inv9 = new Invoice__c(
    Invoice_Number__c = 'KOR_ZAL/' + s + '/09',
    Seller_NIP__c = '9223073555',
    Invoice_Type__c = 'KOR_ZAL',
    Issue_Date__c = today,
    Currency_Code__c = 'PLN',
    Buyer_NIP__c = '2252657506',
    Buyer_Name__c = 'Nova Systems Sp. z o.o.',
    Buyer_ID_Type__c = 'NIP',
    Buyer_Country__c = 'PL',
    Buyer_Address_L1__c = 'ul. Pulawska 233',
    Buyer_Address_L2__c = '02-715 Warszawa',
    Correction_Reason__c = 'Advance amount change — 10% reduction',
    Correction_Type__c = '2',
    Corrected_Invoice_Number__c = 'ZAL/' + s + '/06',
    Corrected_Invoice_Date__c = today.addDays(-5)
);
insert inv9;

insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv9.Id, Line_Number__c = 1,
        Description__c = 'Advance payment — ERP implementation project (after correction)', Unit__c = 'pcs',
        Quantity__c = 1, Unit_Price_Net__c = 45000, Net_Amount__c = 45000,
        VAT_Rate__c = '23', VAT_Amount__c = 10350, Gross_Amount__c = 55350)
};

// --- 10. KOR_ROZ — correction of settlement (corrects inv7 buyer) ---
Invoice__c inv10 = new Invoice__c(
    Invoice_Number__c = 'KOR_ROZ/' + s + '/10',
    Seller_NIP__c = '9223073555',
    Invoice_Type__c = 'KOR_ROZ',
    Issue_Date__c = today,
    Currency_Code__c = 'PLN',
    Buyer_NIP__c = '2252657506',
    Buyer_Name__c = 'Nova Systems Sp. z o.o.',
    Buyer_ID_Type__c = 'NIP',
    Buyer_Country__c = 'PL',
    Buyer_Address_L1__c = 'ul. Pulawska 233',
    Buyer_Address_L2__c = '02-715 Warszawa',
    Correction_Reason__c = 'Change of work scope — additional module',
    Correction_Type__c = '1',
    Corrected_Invoice_Number__c = 'ROZ/' + s + '/07',
    Corrected_Invoice_Date__c = today.addDays(-3),
    Corrected_Invoice_KSeF_Ref__c = '9223073555-20260228-A7B8C9-E0F1D2-01',
    Payment_Method__c = '6',
    Payment_Due_Date__c = today.addDays(14),
    Bank_Account_Number__c = '50114012340000350282727737',
    Bank_Name__c = 'mBank'
);
insert inv10;

// Correction of ROZ — remaining after advance deduction, plus extra module
// Original remaining: 100,000 net -> corrected to 115,000 net (added module)
insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv10.Id, Line_Number__c = 1,
        Description__c = 'ERP implementation — final settlement (after correction, after advance deduction)', Unit__c = 'pcs',
        Quantity__c = 1, Unit_Price_Net__c = 115000, Net_Amount__c = 115000,
        VAT_Rate__c = '23', VAT_Amount__c = 26450, Gross_Amount__c = 141450)
};

System.debug('════════════════════════════════════════════════');
System.debug('  Created 10 test invoices (seed=' + s + ')');
System.debug('════════════════════════════════════════════════');
System.debug(' 1. VAT standard:         ' + inv1.Invoice_Number__c + ' → ' + inv1.Id);
System.debug(' 2. VAT EU (NrVatUE/oo):  ' + inv2.Invoice_Number__c + ' → ' + inv2.Id);
System.debug(' 3. VAT split payment:    ' + inv3.Invoice_Number__c + ' → ' + inv3.Id);
System.debug(' 4. KOR + KSeF ref:       ' + inv4.Invoice_Number__c + ' → ' + inv4.Id);
System.debug(' 5. KOR no KSeF ref:      ' + inv5.Invoice_Number__c + ' → ' + inv5.Id);
System.debug(' 6. ZAL (advance):        ' + inv6.Invoice_Number__c + ' → ' + inv6.Id);
System.debug(' 7. ROZ (settlement):     ' + inv7.Invoice_Number__c + ' → ' + inv7.Id);
System.debug(' 8. UPR (simplified):     ' + inv8.Invoice_Number__c + ' → ' + inv8.Id);
System.debug(' 9. KOR_ZAL:              ' + inv9.Invoice_Number__c + ' → ' + inv9.Id);
System.debug('10. KOR_ROZ:              ' + inv10.Invoice_Number__c + ' → ' + inv10.Id);
System.debug('════════════════════════════════════════════════');
