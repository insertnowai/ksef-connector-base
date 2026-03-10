// List ALL custom objects
for (String key : Schema.getGlobalDescribe().keySet()) {
    if (key.contains('invoice') || key.contains('__c')) {
        Schema.DescribeSObjectResult d = Schema.getGlobalDescribe().get(key).getDescribe();
        if (d.isCustom()) {
            Integer cnt = 0;
            for (Schema.SObjectField f : d.fields.getMap().values()) {
                if (f.getDescribe().isCustom()) cnt++;
            }
            System.debug('CUSTOM OBJ: ' + d.getName() + ' (' + cnt + ' custom fields)');
        }
    }
}
