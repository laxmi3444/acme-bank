@isTest
private class ACMEAccountClass_Test {
    
    static testMethod void acmeAccountInsertTest() {
        
        ACME_Account__c acme = new ACME_Account__c(Name = 'test',
                                                   Account_Number__c = '123456789',
                                                   Account_Type__c = 'Savings',
                                                   Currency__c = 'AUD/NZD',
                                                   Amount__c = 125.79);
        
        Test.startTest();
        
        insert acme;
        
        Transaction__c trans = new Transaction__c(Name='test Transaction',
                                                  ACME_Account__c = acme.Id,
                                                  Currency_Type__c = 'AUD/NZD',
                                                  Transaction_Amount__c = 12.11,
                                                  Type_of_Transaction__c = 'Debit');
        
        insert trans;
        
        Test.stopTest();
    }
    static testMethod void transactionCreditTest() {
        
        ACME_Account__c acme = new ACME_Account__c(Name = 'test',
                                                   Account_Number__c = '123456789',
                                                   Account_Type__c = 'Savings',
                                                   Currency__c = 'AUD/NZD',
                                                   Amount__c = 125.79);
        
        Test.startTest();
        
        insert acme;
        
        Transaction__c trans = new Transaction__c(Name='test Transaction',
                                                  ACME_Account__c = acme.Id,
                                                  Currency_Type__c = 'AUD/NZD',
                                                  Transaction_Amount__c = 12.11,
                                                  Type_of_Transaction__c = 'Credit');
        
        insert trans;
        
        Test.stopTest();
    }
    static testMethod void currencyMismatchTest() {
        
        ACME_Account__c acme = new ACME_Account__c(Name = 'test',
                                                   Account_Number__c = '123456789',
                                                   Account_Type__c = 'Savings',
                                                   Currency__c = 'EUR',
                                                   Amount__c = 125.79);
        
        Test.startTest();
        
        insert acme;
        
        Transaction__c trans = new Transaction__c(Name='test Transaction',
                                                  ACME_Account__c = acme.Id,
                                                  Currency_Type__c = 'AUD/NZD',
                                                  Transaction_Amount__c = 12.11,
                                                  Type_of_Transaction__c = 'Credit');
        
        try{        
            insert trans;
        } catch(Exception e){
        }
        
        Test.stopTest();
    }
}