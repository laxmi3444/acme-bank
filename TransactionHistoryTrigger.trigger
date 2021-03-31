trigger TransactionHistoryTrigger on Transaction__c (before insert) {
    if(Trigger.isInsert && Trigger.isBefore){
        ACMEAccountClass.accountBalanceUpdate(Trigger.new);
    }
}