// ============================================================
// KSeF Test Data Generator — Execute Anonymous Apex
// Creates all invoice types with various buyer IDs and flags
// ============================================================

// --- Invoice 1: VAT standard, multi-rate (23%, 8%, zw, 5%) ---
Invoice__c inv1 = new Invoice__c(
        Invoice_Number__c = 'FV/2026/02/001',
        Invoice_Type__c = 'VAT',
        Seller_NIP__c = '1111111111',
        Seller_Name__c = 'Test Sp. z o.o.',
        Seller_Address__c = 'ul. Testowa 1, 00-001 Warszawa',
        Buyer_NIP__c = '2222222222',
        Buyer_Name__c = 'Klient S.A.',
        Buyer_Address__c = 'ul. Kupiecka 5, 31-001 Kraków',
        Buyer_ID_Type__c = 'NIP',
        Buyer_Country__c = 'PL',
        Issue_Date__c = Date.today(),
        Sale_Date__c = Date.today(),
        Currency_Code__c = 'PLN',
        Amount_Gross__c = 4182.00,
        Is_Self_Billing__c = false,
        Is_Split_Payment__c = false
);
insert inv1;

insert new List<Invoice_Line__c>{
        new Invoice_Line__c(Invoice__c = inv1.Id, Line_Number__c = 1,
                Description__c = 'Usługi programistyczne', Unit__c = 'godz',
                Quantity__c = 10, Unit_Price_Net__c = 200.00, Net_Amount__c = 2000.00,
                VAT_Rate__c = '23', VAT_Amount__c = 460.00, Gross_Amount__c = 2460.00),
        new Invoice_Line__c(Invoice__c = inv1.Id, Line_Number__c = 2,
                Description__c = 'Licencja na oprogramowanie', Unit__c = 'szt',
                Quantity__c = 1, Unit_Price_Net__c = 1000.00, Net_Amount__c = 1000.00,
                VAT_Rate__c = '8', VAT_Amount__c = 80.00, Gross_Amount__c = 1080.00),
        new Invoice_Line__c(Invoice__c = inv1.Id, Line_Number__c = 3,
                Description__c = 'Szkolenie online', Unit__c = 'szt',
                Quantity__c = 2, Unit_Price_Net__c = 300.00, Net_Amount__c = 600.00,
                VAT_Rate__c = 'zw', VAT_Amount__c = 0.00, Gross_Amount__c = 600.00),
        new Invoice_Line__c(Invoice__c = inv1.Id, Line_Number__c = 4,
                Description__c = 'Raport analityczny', Unit__c = 'szt',
                Quantity__c = 1, Unit_Price_Net__c = 40.00, Net_Amount__c = 40.00,
                VAT_Rate__c = '5', VAT_Amount__c = 2.00, Gross_Amount__c = 42.00)
};

// --- Invoice 2: VAT, EU buyer (NrVatUE), reverse charge (oo) ---
Invoice__c inv2 = new Invoice__c(
        Invoice_Number__c = 'FV/2026/02/002',
        Invoice_Type__c = 'VAT',
        Seller_NIP__c = '1111111111',
        Seller_Name__c = 'Test Sp. z o.o.',
        Seller_Address__c = 'ul. Testowa 1, 00-001 Warszawa',
        Buyer_NIP__c = 'DE123456789',
        Buyer_Name__c = 'Deutsche GmbH',
        Buyer_Address__c = 'Berliner Str. 10, 10115 Berlin',
        Buyer_ID_Type__c = 'NrVatUE',
        Buyer_Country__c = 'DE',
        Issue_Date__c = Date.today(),
        Sale_Date__c = Date.today(),
        Currency_Code__c = 'EUR',
        Amount_Gross__c = 5000.00,
        Is_Self_Billing__c = false,
        Is_Split_Payment__c = false
);
insert inv2;

insert new List<Invoice_Line__c>{
        new Invoice_Line__c(Invoice__c = inv2.Id, Line_Number__c = 1,
                Description__c = 'Consulting services', Unit__c = 'godz',
                Quantity__c = 50, Unit_Price_Net__c = 100.00, Net_Amount__c = 5000.00,
                VAT_Rate__c = 'oo', VAT_Amount__c = 0.00, Gross_Amount__c = 5000.00)
};

// --- Invoice 3: VAT, split payment (MPP) ---
Invoice__c inv3 = new Invoice__c(
        Invoice_Number__c = 'FV/2026/02/003',
        Invoice_Type__c = 'VAT',
        Seller_NIP__c = '1111111111',
        Seller_Name__c = 'Test Sp. z o.o.',
        Seller_Address__c = 'ul. Testowa 1, 00-001 Warszawa',
        Buyer_NIP__c = '3333333333',
        Buyer_Name__c = 'Prosty Klient',
        Buyer_Address__c = 'ul. Prosta 3, 00-003 Warszawa',
        Buyer_ID_Type__c = 'NIP',
        Buyer_Country__c = 'PL',
        Issue_Date__c = Date.today(),
        Currency_Code__c = 'PLN',
        Amount_Gross__c = 1230.00,
        Is_Self_Billing__c = false,
        Is_Split_Payment__c = true
);
insert inv3;

insert new List<Invoice_Line__c>{
        new Invoice_Line__c(Invoice__c = inv3.Id, Line_Number__c = 1,
                Description__c = 'Usługa standardowa', Unit__c = 'szt',
                Quantity__c = 1, Unit_Price_Net__c = 1000.00, Net_Amount__c = 1000.00,
                VAT_Rate__c = '23', VAT_Amount__c = 230.00, Gross_Amount__c = 1230.00)
};

// --- Invoice 4: VAT, self-billing + BrakID buyer ---
Invoice__c inv4 = new Invoice__c(
        Invoice_Number__c = 'FV/2026/02/004',
        Invoice_Type__c = 'VAT',
        Seller_NIP__c = '1111111111',
        Seller_Name__c = 'Test Sp. z o.o.',
        Seller_Address__c = 'ul. Testowa 1, 00-001 Warszawa',
        Buyer_NIP__c = 'BRAK',
        Buyer_Name__c = 'Jan Kowalski',
        Buyer_Address__c = 'ul. Domowa 7, 00-007 Gdańsk',
        Buyer_ID_Type__c = 'BrakID',
        Buyer_Country__c = 'PL',
        Issue_Date__c = Date.today(),
        Sale_Date__c = Date.today(),
        Currency_Code__c = 'PLN',
        Amount_Gross__c = 123.00,
        Is_Self_Billing__c = true,
        Is_Split_Payment__c = false
);
insert inv4;

insert new List<Invoice_Line__c>{
        new Invoice_Line__c(Invoice__c = inv4.Id, Line_Number__c = 1,
                Description__c = 'Drobna usługa — samofakturowanie', Unit__c = 'szt',
                Quantity__c = 1, Unit_Price_Net__c = 100.00, Net_Amount__c = 100.00,
                VAT_Rate__c = '23', VAT_Amount__c = 23.00, Gross_Amount__c = 123.00)
};

// --- Invoice 5: VAT, PESEL buyer ---
Invoice__c inv5 = new Invoice__c(
        Invoice_Number__c = 'FV/2026/02/005',
        Invoice_Type__c = 'VAT',
        Seller_NIP__c = '1111111111',
        Seller_Name__c = 'Test Sp. z o.o.',
        Seller_Address__c = 'ul. Testowa 1, 00-001 Warszawa',
        Buyer_NIP__c = '82010112345',
        Buyer_Name__c = 'Anna Nowak',
        Buyer_Address__c = 'ul. Kwiatowa 3, 00-003 Poznań',
        Buyer_ID_Type__c = 'PESEL',
        Buyer_Country__c = 'PL',
        Issue_Date__c = Date.today(),
        Sale_Date__c = Date.today(),
        Currency_Code__c = 'PLN',
        Amount_Gross__c = 246.00,
        Is_Self_Billing__c = false,
        Is_Split_Payment__c = false
);
insert inv5;

insert new List<Invoice_Line__c>{
        new Invoice_Line__c(Invoice__c = inv5.Id, Line_Number__c = 1,
                Description__c = 'Usługa dla osoby fizycznej', Unit__c = 'szt',
                Quantity__c = 2, Unit_Price_Net__c = 100.00, Net_Amount__c = 200.00,
                VAT_Rate__c = '23', VAT_Amount__c = 46.00, Gross_Amount__c = 246.00)
};

// --- Invoice 6: VAT, NrID buyer (US) ---
Invoice__c inv6 = new Invoice__c(
        Invoice_Number__c = 'FV/2026/02/006',
        Invoice_Type__c = 'VAT',
        Seller_NIP__c = '1111111111',
        Seller_Name__c = 'Test Sp. z o.o.',
        Seller_Address__c = 'ul. Testowa 1, 00-001 Warszawa',
        Buyer_NIP__c = 'US-EIN-12-3456789',
        Buyer_Name__c = 'Acme Corp USA',
        Buyer_Address__c = '123 Main St, New York, NY 10001',
        Buyer_ID_Type__c = 'NrID',
        Buyer_Country__c = 'US',
        Issue_Date__c = Date.today(),
        Sale_Date__c = Date.today(),
        Currency_Code__c = 'USD',
        Amount_Gross__c = 3000.00,
        Is_Self_Billing__c = false,
        Is_Split_Payment__c = false
);
insert inv6;

insert new List<Invoice_Line__c>{
        new Invoice_Line__c(Invoice__c = inv6.Id, Line_Number__c = 1,
                Description__c = 'Software development', Unit__c = 'godz',
                Quantity__c = 30, Unit_Price_Net__c = 100.00, Net_Amount__c = 3000.00,
                VAT_Rate__c = '0 EX', VAT_Amount__c = 0.00, Gross_Amount__c = 3000.00)
};

// --- Invoice 7: KOR (Correction) ---
Invoice__c inv7 = new Invoice__c(
        Invoice_Number__c = 'FV/2026/02/KOR/001',
        Invoice_Type__c = 'KOR',
        Seller_NIP__c = '1111111111',
        Seller_Name__c = 'Test Sp. z o.o.',
        Seller_Address__c = 'ul. Testowa 1, 00-001 Warszawa',
        Buyer_NIP__c = '2222222222',
        Buyer_Name__c = 'Klient S.A.',
        Buyer_Address__c = 'ul. Kupiecka 5, 31-001 Kraków',
        Buyer_ID_Type__c = 'NIP',
        Buyer_Country__c = 'PL',
        Issue_Date__c = Date.today(),
        Sale_Date__c = Date.today(),
        Currency_Code__c = 'PLN',
        Amount_Gross__c = 1845.00,
        Is_Self_Billing__c = false,
        Is_Split_Payment__c = false,
        Correction_Reason__c = 'Korekta ceny — błędna stawka jednostkowa',
        Correction_Type__c = '2',
        Corrected_Invoice_Number__c = 'FV/2026/02/001',
        Corrected_Invoice_Date__c = Date.today().addDays(-10),
        Corrected_Invoice_KSeF_Ref__c = '1111111111-20260206-ABC123DEF456-01'
);
insert inv7;

insert new List<Invoice_Line__c>{
        new Invoice_Line__c(Invoice__c = inv7.Id, Line_Number__c = 1,
                Description__c = 'Usługa doradcza (po korekcie)', Unit__c = 'godz',
                Quantity__c = 10, Unit_Price_Net__c = 150.00, Net_Amount__c = 1500.00,
                VAT_Rate__c = '23', VAT_Amount__c = 345.00, Gross_Amount__c = 1845.00)
};

// --- Invoice 8: KOR bez KSeF ref (korekta faktury sprzed KSeF) ---
Invoice__c inv8 = new Invoice__c(
        Invoice_Number__c = 'FV/2026/02/KOR/002',
        Invoice_Type__c = 'KOR',
        Seller_NIP__c = '1111111111',
        Seller_Name__c = 'Test Sp. z o.o.',
        Seller_Address__c = 'ul. Testowa 1, 00-001 Warszawa',
        Buyer_NIP__c = '3333333333',
        Buyer_Name__c = 'Prosty Klient',
        Buyer_Address__c = 'ul. Prosta 3, 00-003 Warszawa',
        Buyer_ID_Type__c = 'NIP',
        Buyer_Country__c = 'PL',
        Issue_Date__c = Date.today(),
        Sale_Date__c = Date.today(),
        Currency_Code__c = 'PLN',
        Amount_Gross__c = 615.00,
        Is_Self_Billing__c = false,
        Is_Split_Payment__c = false,
        Correction_Reason__c = 'Zmiana danych nabywcy',
        Correction_Type__c = '3',
        Corrected_Invoice_Number__c = 'FV/2024/12/099',
        Corrected_Invoice_Date__c = Date.newInstance(2024, 12, 15)
        // brak Corrected_Invoice_KSeF_Ref__c → NrKSeFN=1
);
insert inv8;

insert new List<Invoice_Line__c>{
        new Invoice_Line__c(Invoice__c = inv8.Id, Line_Number__c = 1,
                Description__c = 'Usługa standardowa (dane skorygowane)', Unit__c = 'szt',
                Quantity__c = 1, Unit_Price_Net__c = 500.00, Net_Amount__c = 500.00,
                VAT_Rate__c = '23', VAT_Amount__c = 115.00, Gross_Amount__c = 615.00)
};

// --- Invoice 9: ZAL (Advance) ---
Invoice__c inv9 = new Invoice__c(
        Invoice_Number__c = 'FV/2026/02/ZAL/001',
        Invoice_Type__c = 'ZAL',
        Seller_NIP__c = '1111111111',
        Seller_Name__c = 'Test Sp. z o.o.',
        Seller_Address__c = 'ul. Testowa 1, 00-001 Warszawa',
        Buyer_NIP__c = '2222222222',
        Buyer_Name__c = 'Klient S.A.',
        Buyer_Address__c = 'ul. Kupiecka 5, 31-001 Kraków',
        Buyer_ID_Type__c = 'NIP',
        Buyer_Country__c = 'PL',
        Issue_Date__c = Date.today(),
        Sale_Date__c = Date.today(),
        Currency_Code__c = 'PLN',
        Amount_Gross__c = 6150.00,
        Is_Self_Billing__c = false,
        Is_Split_Payment__c = false
);
insert inv9;

insert new List<Invoice_Line__c>{
        new Invoice_Line__c(Invoice__c = inv9.Id, Line_Number__c = 1,
                Description__c = 'Zaliczka na projekt IT — etap 1', Unit__c = 'szt',
                Quantity__c = 1, Unit_Price_Net__c = 5000.00, Net_Amount__c = 5000.00,
                VAT_Rate__c = '23', VAT_Amount__c = 1150.00, Gross_Amount__c = 6150.00)
};

// --- Invoice 10: ROZ (Settlement) with KSeF ref ---
Invoice__c inv10 = new Invoice__c(
        Invoice_Number__c = 'FV/2026/02/ROZ/001',
        Invoice_Type__c = 'ROZ',
        Seller_NIP__c = '1111111111',
        Seller_Name__c = 'Test Sp. z o.o.',
        Seller_Address__c = 'ul. Testowa 1, 00-001 Warszawa',
        Buyer_NIP__c = '2222222222',
        Buyer_Name__c = 'Klient S.A.',
        Buyer_Address__c = 'ul. Kupiecka 5, 31-001 Kraków',
        Buyer_ID_Type__c = 'NIP',
        Buyer_Country__c = 'PL',
        Issue_Date__c = Date.today(),
        Sale_Date__c = Date.today(),
        Currency_Code__c = 'PLN',
        Amount_Gross__c = 18450.00,
        Is_Self_Billing__c = false,
        Is_Split_Payment__c = false,
        Advance_Invoice_Number__c = 'FV/2026/02/ZAL/001',
        Advance_Invoice_KSeF_Ref__c = '1111111111-20260216-DEF789GHI012-02'
);
insert inv10;

insert new List<Invoice_Line__c>{
        new Invoice_Line__c(Invoice__c = inv10.Id, Line_Number__c = 1,
                Description__c = 'Projekt IT — rozliczenie końcowe', Unit__c = 'szt',
                Quantity__c = 1, Unit_Price_Net__c = 15000.00, Net_Amount__c = 15000.00,
                VAT_Rate__c = '23', VAT_Amount__c = 3450.00, Gross_Amount__c = 18450.00)
};

// --- Invoice 11: ROZ (Settlement) without KSeF ref ---
Invoice__c inv11 = new Invoice__c(
        Invoice_Number__c = 'FV/2026/02/ROZ/002',
        Invoice_Type__c = 'ROZ',
        Seller_NIP__c = '1111111111',
        Seller_Name__c = 'Test Sp. z o.o.',
        Seller_Address__c = 'ul. Testowa 1, 00-001 Warszawa',
        Buyer_NIP__c = '3333333333',
        Buyer_Name__c = 'Prosty Klient',
        Buyer_Address__c = 'ul. Prosta 3, 00-003 Warszawa',
        Buyer_ID_Type__c = 'NIP',
        Buyer_Country__c = 'PL',
        Issue_Date__c = Date.today(),
        Sale_Date__c = Date.today(),
        Currency_Code__c = 'PLN',
        Amount_Gross__c = 2460.00,
        Is_Self_Billing__c = false,
        Is_Split_Payment__c = false,
        Advance_Invoice_Number__c = 'FV/2024/11/ZAL/099'
        // brak Advance_Invoice_KSeF_Ref__c → NrKSeFZN=2
);
insert inv11;

insert new List<Invoice_Line__c>{
        new Invoice_Line__c(Invoice__c = inv11.Id, Line_Number__c = 1,
                Description__c = 'Rozliczenie zaliczki sprzed KSeF', Unit__c = 'szt',
                Quantity__c = 1, Unit_Price_Net__c = 2000.00, Net_Amount__c = 2000.00,
                VAT_Rate__c = '23', VAT_Amount__c = 460.00, Gross_Amount__c = 2460.00)
};

// --- Invoice 12: UPR (Simplified) ---
Invoice__c inv12 = new Invoice__c(
        Invoice_Number__c = 'FV/2026/02/UPR/001',
        Invoice_Type__c = 'UPR',
        Seller_NIP__c = '1111111111',
        Seller_Name__c = 'Test Sp. z o.o.',
        Seller_Address__c = 'ul. Testowa 1, 00-001 Warszawa',
        Buyer_NIP__c = '4444444444',
        Buyer_Name__c = 'Mały Klient',
        Buyer_Address__c = 'ul. Mała 1, 00-004 Warszawa',
        Buyer_ID_Type__c = 'NIP',
        Buyer_Country__c = 'PL',
        Issue_Date__c = Date.today(),
        Currency_Code__c = 'PLN',
        Amount_Gross__c = 369.00,
        Is_Self_Billing__c = false,
        Is_Split_Payment__c = false
);
insert inv12;

insert new List<Invoice_Line__c>{
        new Invoice_Line__c(Invoice__c = inv12.Id, Line_Number__c = 1,
                Description__c = 'Drobna usługa (uproszczona)', Unit__c = 'szt',
                Quantity__c = 1, Unit_Price_Net__c = 300.00, Net_Amount__c = 300.00,
                VAT_Rate__c = '23', VAT_Amount__c = 69.00, Gross_Amount__c = 369.00)
};

// --- Invoice 13: KOR_ZAL (Correction of advance) ---
Invoice__c inv13 = new Invoice__c(
        Invoice_Number__c = 'FV/2026/02/KOR-ZAL/001',
        Invoice_Type__c = 'KOR_ZAL',
        Seller_NIP__c = '1111111111',
        Seller_Name__c = 'Test Sp. z o.o.',
        Seller_Address__c = 'ul. Testowa 1, 00-001 Warszawa',
        Buyer_NIP__c = '2222222222',
        Buyer_Name__c = 'Klient S.A.',
        Buyer_Address__c = 'ul. Kupiecka 5, 31-001 Kraków',
        Buyer_ID_Type__c = 'NIP',
        Buyer_Country__c = 'PL',
        Issue_Date__c = Date.today(),
        Sale_Date__c = Date.today(),
        Currency_Code__c = 'PLN',
        Amount_Gross__c = 4920.00,
        Is_Self_Billing__c = false,
        Is_Split_Payment__c = false,
        Correction_Reason__c = 'Zmiana kwoty zaliczki — obniżenie',
        Correction_Type__c = '2',
        Corrected_Invoice_Number__c = 'FV/2026/02/ZAL/001',
        Corrected_Invoice_Date__c = Date.today().addDays(-5)
);
insert inv13;

insert new List<Invoice_Line__c>{
        new Invoice_Line__c(Invoice__c = inv13.Id, Line_Number__c = 1,
                Description__c = 'Zaliczka na projekt IT — korekta kwoty', Unit__c = 'szt',
                Quantity__c = 1, Unit_Price_Net__c = 4000.00, Net_Amount__c = 4000.00,
                VAT_Rate__c = '23', VAT_Amount__c = 920.00, Gross_Amount__c = 4920.00)
};

// --- Invoice 14: KOR_ROZ (Correction of settlement) ---
Invoice__c inv14 = new Invoice__c(
        Invoice_Number__c = 'FV/2026/02/KOR-ROZ/001',
        Invoice_Type__c = 'KOR_ROZ',
        Seller_NIP__c = '1111111111',
        Seller_Name__c = 'Test Sp. z o.o.',
        Seller_Address__c = 'ul. Testowa 1, 00-001 Warszawa',
        Buyer_NIP__c = '2222222222',
        Buyer_Name__c = 'Klient S.A.',
        Buyer_Address__c = 'ul. Kupiecka 5, 31-001 Kraków',
        Buyer_ID_Type__c = 'NIP',
        Buyer_Country__c = 'PL',
        Issue_Date__c = Date.today(),
        Sale_Date__c = Date.today(),
        Currency_Code__c = 'PLN',
        Amount_Gross__c = 16605.00,
        Is_Self_Billing__c = false,
        Is_Split_Payment__c = false,
        Correction_Reason__c = 'Błąd w rozliczeniu zaliczki — zmiana zakresu prac',
        Correction_Type__c = '1',
        Corrected_Invoice_Number__c = 'FV/2026/02/ROZ/001',
        Corrected_Invoice_Date__c = Date.today().addDays(-3),
        Corrected_Invoice_KSeF_Ref__c = '1111111111-20260216-ROZ999-01'
);
insert inv14;

insert new List<Invoice_Line__c>{
        new Invoice_Line__c(Invoice__c = inv14.Id, Line_Number__c = 1,
                Description__c = 'Rozliczenie końcowe (po korekcie)', Unit__c = 'szt',
                Quantity__c = 1, Unit_Price_Net__c = 13500.00, Net_Amount__c = 13500.00,
                VAT_Rate__c = '23', VAT_Amount__c = 3105.00, Gross_Amount__c = 16605.00)
};

System.debug('════════════════════════════════════════════════');
System.debug('  Created 14 test invoices');
System.debug('════════════════════════════════════════════════');
System.debug(' 1. VAT multi-rate (23/8/zw/5):   ' + inv1.Id);
System.debug(' 2. VAT EU NrVatUE (oo):          ' + inv2.Id);
System.debug(' 3. VAT split payment (MPP):       ' + inv3.Id);
System.debug(' 4. VAT self-billing + BrakID:     ' + inv4.Id);
System.debug(' 5. VAT PESEL buyer:               ' + inv5.Id);
System.debug(' 6. VAT NrID buyer (US):           ' + inv6.Id);
System.debug(' 7. KOR with KSeF ref:             ' + inv7.Id);
System.debug(' 8. KOR without KSeF ref:          ' + inv8.Id);
System.debug(' 9. ZAL (Advance):                 ' + inv9.Id);
System.debug('10. ROZ with KSeF ref:             ' + inv10.Id);
System.debug('11. ROZ without KSeF ref:          ' + inv11.Id);
System.debug('12. UPR (Simplified):              ' + inv12.Id);
System.debug('13. KOR_ZAL (Correction advance):  ' + inv13.Id);
System.debug('14. KOR_ROZ (Correction settle):   ' + inv14.Id);
System.debug('════════════════════════════════════════════════');
