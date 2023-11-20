public class ContactFutureHandler {
    
    @future
    Public static void countNumberOfContact(String contactListJson){
        
        List<Contact> contactList = (List<Contact>) Json.deserialize(contactListJson, List<Contact>.Class);
        Set<Id> accountIds = new Set<Id>();
        for(Contact record:contactList){
            if(record.AccountId!=Null){ 
                accountIds.add(record.AccountId);
            } 
        }        
        List<AggregateResult> aggregateList =[SELECT count(Id) contactCount,AccountId 
                                              FROM Contact 
                                              WHERE AccountId IN:accountIds
                                              GROUP BY AccountId];
        List<Account> accountList = new List<Account>();
        for(AggregateResult record:aggregateList){
            Account acc = new Account();
            acc.Id=(Id)record.get('AccountId');
            acc.Count_Of_Contact__c= (Decimal)record.get('contactCount');
            accountList.add(acc);
        }
        update accountList;
    }
}