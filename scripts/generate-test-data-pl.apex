// ============================================================
// Generator danych testowych KSeF (PL)
// Usuwa stare dane, tworzy faktury dla wszystkich 10 typów.
// Dane sprzedawcy pochodzą z KSeF_Seller__mdt — nie są tu ustawiane.
// Używa Date.today() żeby daty nie były w przyszłości.
// Losowe numery faktur żeby uniknąć odrzucenia duplikatu w KSeF.
// NIP sprzedawcy dla ref. KSeF: 9223073555
// ============================================================

delete [SELECT Id FROM Invoice_Line__c];
delete [SELECT Id FROM Invoice__c];

Date today = Date.today();

// Unikalny 4-cyfrowy seed żeby numery faktur nie kolidowały z poprzednimi uruchomieniami
Integer seed = Math.mod(Math.abs(Crypto.getRandomInteger()), 9000) + 1000;
String s = String.valueOf(seed);

// --- 1. VAT — standardowa, pełne dane płatności ---
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
    Bank_Account_Description__c = 'Rachunek główny firmowy'
);
insert inv1;

insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv1.Id, Line_Number__c = 1,
        Description__c = 'Usługi programistyczne', Unit__c = 'godz',
        Quantity__c = 186, Unit_Price_Net__c = 142, Net_Amount__c = 26412,
        VAT_Rate__c = '23', VAT_Amount__c = 6074.76, Gross_Amount__c = 32486.76,
        PKWiU__c = '62.01.11.0')
};

// --- 2. VAT — nabywca UE (NrVatUE), odwrotne obciążenie ---
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
        Description__c = 'Usługi konsultingowe', Unit__c = 'godz',
        Quantity__c = 40, Unit_Price_Net__c = 100, Net_Amount__c = 4000,
        VAT_Rate__c = 'oo', VAT_Amount__c = 0, Gross_Amount__c = 4000)
};

// --- 3. VAT — mechanizm podzielonej płatności (MPP) ---
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
        Description__c = 'Dostawa sprzętu komputerowego', Unit__c = 'szt',
        Quantity__c = 5, Unit_Price_Net__c = 4000, Net_Amount__c = 20000,
        VAT_Rate__c = '23', VAT_Amount__c = 4600, Gross_Amount__c = 24600,
        PKWiU__c = '26.20.11.1')
};

// --- 4. KOR — korekta z ref. KSeF (koryguje inv1) ---
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
    Correction_Reason__c = 'Korekta ilości godzin — 186h na 180h',
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
        Description__c = 'Usługi programistyczne', Unit__c = 'godz',
        Quantity__c = 180, Unit_Price_Net__c = 142, Net_Amount__c = 25560,
        VAT_Rate__c = '23', VAT_Amount__c = 5878.80, Gross_Amount__c = 31438.80,
        PKWiU__c = '62.01.11.0')
};

// --- 5. KOR — korekta bez ref. KSeF (faktura sprzed KSeF) ---
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
    Buyer_Address_L1__c = 'ul. Marszałkowska 55',
    Buyer_Address_L2__c = '00-676 Warszawa',
    Correction_Reason__c = 'Zmiana danych nabywcy',
    Correction_Type__c = '3',
    Corrected_Invoice_Number__c = 'FV/2025/001',
    Corrected_Invoice_Date__c = Date.newInstance(2025, 1, 15)
);
insert inv5;

insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv5.Id, Line_Number__c = 1,
        Description__c = 'Usługi programistyczne', Unit__c = 'godz',
        Quantity__c = 160, Unit_Price_Net__c = 130, Net_Amount__c = 20800,
        VAT_Rate__c = '23', VAT_Amount__c = 4784, Gross_Amount__c = 25584,
        PKWiU__c = '62.01.11.0')
};

// --- 6. ZAL — faktura zaliczkowa ---
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
    Buyer_Address_L1__c = 'ul. Puławska 233',
    Buyer_Address_L2__c = '02-715 Warszawa',
    Payment_Method__c = '6',
    Payment_Due_Date__c = today.addDays(7),
    Bank_Account_Number__c = '50114012340000350282727737',
    Bank_Name__c = 'mBank'
);
insert inv6;

insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv6.Id, Line_Number__c = 1,
        Description__c = 'Zaliczka — projekt wdrożenia ERP', Unit__c = 'szt',
        Quantity__c = 1, Unit_Price_Net__c = 50000, Net_Amount__c = 50000,
        VAT_Rate__c = '23', VAT_Amount__c = 11500, Gross_Amount__c = 61500)
};

// --- 7. ROZ — rozliczenie z ref. KSeF do zaliczki ---
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
    Buyer_Address_L1__c = 'ul. Puławska 233',
    Buyer_Address_L2__c = '02-715 Warszawa',
    Advance_Invoice_Number__c = 'ZAL/' + s + '/06',
    Advance_Invoice_KSeF_Ref__c = '9223073555-20260301-D4E5F6-A0B1C2-02',
    Payment_Method__c = '6',
    Payment_Due_Date__c = today.addDays(14),
    Bank_Account_Number__c = '50114012340000350282727737',
    Bank_Name__c = 'mBank'
);
insert inv7;

// Pozycje = cała umowa minus zaliczka (art. 106f ust. 3)
// Cała umowa: 150 000 netto. Zaliczka (inv6): 50 000 netto. Pozostało: 100 000 netto.
insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv7.Id, Line_Number__c = 1,
        Description__c = 'Wdrożenie ERP — rozliczenie końcowe (po odliczeniu zaliczki)', Unit__c = 'szt',
        Quantity__c = 1, Unit_Price_Net__c = 100000, Net_Amount__c = 100000,
        VAT_Rate__c = '23', VAT_Amount__c = 23000, Gross_Amount__c = 123000)
};

// --- 8. UPR — uproszczona (≤450 PLN, jedna pozycja z brutto) ---
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
        Description__c = 'Konsultacja techniczna', Unit__c = 'szt',
        Quantity__c = 1, Unit_Price_Net__c = 300, Net_Amount__c = 300,
        VAT_Rate__c = '23', VAT_Amount__c = 69, Gross_Amount__c = 369)
};

// --- 9. KOR_ZAL — korekta zaliczki (koryguje inv6) ---
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
    Buyer_Address_L1__c = 'ul. Puławska 233',
    Buyer_Address_L2__c = '02-715 Warszawa',
    Correction_Reason__c = 'Zmiana kwoty zaliczki — obniżenie o 10%',
    Correction_Type__c = '2',
    Corrected_Invoice_Number__c = 'ZAL/' + s + '/06',
    Corrected_Invoice_Date__c = today.addDays(-5)
);
insert inv9;

insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv9.Id, Line_Number__c = 1,
        Description__c = 'Zaliczka — projekt wdrożenia ERP (po korekcie)', Unit__c = 'szt',
        Quantity__c = 1, Unit_Price_Net__c = 45000, Net_Amount__c = 45000,
        VAT_Rate__c = '23', VAT_Amount__c = 10350, Gross_Amount__c = 55350)
};

// --- 10. KOR_ROZ — korekta rozliczenia (koryguje inv7) ---
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
    Buyer_Address_L1__c = 'ul. Puławska 233',
    Buyer_Address_L2__c = '02-715 Warszawa',
    Correction_Reason__c = 'Zmiana zakresu prac — dodatkowy moduł',
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

// Korekta ROZ — pozostałość po odliczeniu zaliczki plus dodatkowy moduł
// Pierwotnie: 100 000 netto → po korekcie: 115 000 netto (dodany moduł)
insert new List<Invoice_Line__c>{
    new Invoice_Line__c(Invoice__c = inv10.Id, Line_Number__c = 1,
        Description__c = 'Wdrożenie ERP — rozliczenie końcowe (po korekcie, po odliczeniu zaliczki)', Unit__c = 'szt',
        Quantity__c = 1, Unit_Price_Net__c = 115000, Net_Amount__c = 115000,
        VAT_Rate__c = '23', VAT_Amount__c = 26450, Gross_Amount__c = 141450)
};

System.debug('════════════════════════════════════════════════');
System.debug('  Utworzono 10 faktur testowych (seed=' + s + ')');
System.debug('════════════════════════════════════════════════');
System.debug(' 1. VAT standardowa:      ' + inv1.Invoice_Number__c + ' → ' + inv1.Id);
System.debug(' 2. VAT UE (NrVatUE/oo):  ' + inv2.Invoice_Number__c + ' → ' + inv2.Id);
System.debug(' 3. VAT MPP:              ' + inv3.Invoice_Number__c + ' → ' + inv3.Id);
System.debug(' 4. KOR + ref. KSeF:      ' + inv4.Invoice_Number__c + ' → ' + inv4.Id);
System.debug(' 5. KOR bez ref. KSeF:    ' + inv5.Invoice_Number__c + ' → ' + inv5.Id);
System.debug(' 6. ZAL (zaliczka):       ' + inv6.Invoice_Number__c + ' → ' + inv6.Id);
System.debug(' 7. ROZ (rozliczenie):    ' + inv7.Invoice_Number__c + ' → ' + inv7.Id);
System.debug(' 8. UPR (uproszczona):    ' + inv8.Invoice_Number__c + ' → ' + inv8.Id);
System.debug(' 9. KOR_ZAL:              ' + inv9.Invoice_Number__c + ' → ' + inv9.Id);
System.debug('10. KOR_ROZ:              ' + inv10.Invoice_Number__c + ' → ' + inv10.Id);
System.debug('════════════════════════════════════════════════');
