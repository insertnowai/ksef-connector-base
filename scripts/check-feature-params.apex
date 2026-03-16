System.debug('=== FEATURE PARAMETERS ===');

Boolean isProd = System.FeatureManagement.checkPackageBooleanValue('ksefconn__IsProductionEnabled');
Integer billingCycleStart = System.FeatureManagement.checkPackageIntegerValue('ksefconn__BillingCycleStart');
Integer monthlyLimit = System.FeatureManagement.checkPackageIntegerValue('ksefconn__MonthlyInvoiceLimit');
Integer invoiceCount = System.FeatureManagement.checkPackageIntegerValue('ksefconn__InvoiceCount');

System.debug('IsProductionEnabled: ' + isProd);
System.debug('BillingCycleStart:   ' + billingCycleStart);
System.debug('MonthlyInvoiceLimit: ' + monthlyLimit);
System.debug('InvoiceCount:        ' + invoiceCount);
System.debug('=== END ===');
