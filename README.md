# acme-bank
Config files for my GitHub profile.
public class ACMEAccountClass {
    
    public static String generateRandomString() {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        final String numbers = '0123456789';
        String randStr = '';
        while (randStr.length() < 3) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx+1);
        }
        while (randStr.length() < 12) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), numbers.length());
            randStr += numbers.substring(idx, idx+1);
        }
        return randStr; 
    }
    
    public static void accountBalanceUpdate(List<Transaction__c> transList){
        List<ACME_Account__c> acmeList = new List<ACME_Account__c>();
        
        for(Transaction__c trans : transList){
            ACME_Account__c acme = [SELECT ABID__c,Account_Number__c,Amount__c,Currency__c,Email__c,Id,Name,OwnerId,Owner_Address__c,Phone__c,Account_Type__c 
                                    FROM ACME_Account__c WHERE Id =:trans.ACME_Account__c LIMIT 1];
            
            if(trans.Type_of_Transaction__c == 'Credit' && trans.Currency_Type__c == acme.Currency__c){
                acme.Amount__c = acme.Amount__c - trans.Transaction_Amount__c;
                acmeList.add(acme);
            } else if(trans.Type_of_Transaction__c == 'Debit' && trans.Currency_Type__c == acme.Currency__c){
                acme.Amount__c = acme.Amount__c + trans.Transaction_Amount__c;
                acmeList.add(acme);
            } else if(trans.Currency_Type__c != acme.Currency__c){
                throw new mismatchedCurrencyException('Transaction History is having currency mismatch');
            } else{
                continue;
            }
        }
        
        if(!acmeList.isEmpty()){
            update acmeList;
        }
    }
    
    public class mismatchedCurrencyException extends Exception {}  
}
