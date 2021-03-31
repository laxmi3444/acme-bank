trigger ACMEAccountTrigger on ACME_Account__c (before insert, before update) {
    if(Trigger.isInsert && Trigger.isBefore){
        for(ACME_Account__c acmeAcc : Trigger.new){
            String abId = ACMEAccountClass.generateRandomString();
            acmeAcc.ABID__c = abId;
        }
    }
}