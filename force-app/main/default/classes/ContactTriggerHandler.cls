public class ContactTriggerHandler {
    
    static List<Contact_RelationShip__c> conRelationshipList = new List<Contact_RelationShip__c>();
    List<Contact> triggerNew;
    List<Contact> triggerOld;
    Map<Id,Contact> triggerNewMap;
    Map<Id,Contact> triggerOldMap;
    
    public ContactTriggerHandler()
    {
        triggerNew=(List<Contact>)Trigger.New;
        triggerOld=(List<Contact>)Trigger.Old;
        triggerNewMap=(Map<Id,Contact>) Trigger.NewMap;
        triggerOldMap=(Map<Id,Contact>) Trigger.OldMap;
    } 
    
    public void doAction()
    {
        Switch on Trigger.OperationType
        {
            when BEFORE_INSERT
            {
                onBeforeInsert();
            }
            
            when AFTER_INSERT
            {
                onAfterInsert();
            }
            
            when BEFORE_UPDATE
            {
                
            }
            
            when AFTER_UPDATE
            {
                onAfterUpdate();
            }
            
            when BEFORE_DELETE
            {
                onBeforeDelete();
            }
            
            when AFTER_DELETE
            {
                onAfterDelete();
            }
            
            when AFTER_UNDELETE
            {
                onAfterUnDelete();
            }
        }
    }
    
    public void onBeforeInsert()
    {
        uniqueAccountAsAParent();   
    }
    
    public void onAfterInsert()
    {
        //String jsonString= JSON.serialize(TriggerNew);
        //ContactFutureHandler.countNumberOfContact(jsonString);
        //countActiveContact(triggerNew);
        //countInactiveContact(triggerNew);
        //countContactWithSingleQuery(triggerNew);
    }
    
    public void onAfterUpdate()
    {
        //String jsonString= JSON.serialize(TriggerNew);
        //ContactFutureHandler.countNumberOfContact(jsonString);
        //countActiveContact(triggerNew);
        //countInactiveContact(triggerNew);
        //countContactWithSingleQuery(triggerNew);
    }
    
    public void onBeforeDelete()
    {  
        
    }
    
    public void onAfterDelete()
    {
        //String jsonString= JSON.serialize(TriggerOld);
        //ContactFutureHandler.countNumberOfContact(jsonString);
        //countActiveContact(triggerOld);
        //countInactiveContact(triggerOld);
        //countContactWithSingleQuery(triggerOld);
    }
    
    public void onAfterUnDelete()
    {
        //String jsonString= JSON.serialize(TriggerNew);
        //ContactFutureHandler.countNumberOfContact(jsonString);
        //countActiveContact(triggerNew);
        //countInactiveContact(triggerNew);
        //countContactWithSingleQuery(triggerNew);
    }
    
    public void uniqueAccountAsAParent(){
        Set<Id> accountIds = new Set<Id>();
        for(contact conRecord:triggerNew){
            if(conRecord.AccountId!=Null){
                accountIds.add(conRecord.AccountId);
            }
            
            List<Contact> contactList=[SELECT Id FROM Contact
                                       WHERE accountId=:accountIds];
            for(contact contactRecord:triggerNew){
                if(contactList.size()>0){
                    contactRecord.AccountId.addError('Account already associated with another contact record');
                }
            }
        }
    }
    
    //Contact object have a field called status with values Active and Inactive.
    
    //Update no of active contact in and no of Inactive in related parent account object.
    
    Public void countActiveContact(List<Contact> contactList)
    {
        Set<Id> accountIds= new Set<Id>();
        
        For(Contact record:contactList)
        {
            if(record.AccountId!=Null)
            {
                if(Trigger.isUpdate)
                {
                    if(triggerOldMap.get(record.Id).Status__c!=record.Status__c)
                        accountIds.add(record.AccountId);
                }
                else
                {
                    accountIds.add(record.AccountId);
                }
            }
        }
        
        List<Account> accountList = new List<Account>();
        
        if(accountIds.size()>0)
        {
            List<Account> activeList = [SELECT Id, No_Of_Active_Contact__c,
                                        (SELECT id, AccountId, Status__c FROM Contacts WHERE Status__c ='Active')
                                        FROM Account WHERE Id IN :accountIds];
            
            for(Account activeRecord:activeList)
            {
                Account accountRecord =new Account();
                accountRecord.Id= activeRecord.Id;
                accountRecord.No_Of_Active_Contact__c=activeRecord.Contacts.size();
                accountList.add(accountRecord);
            }
        }
        
        if(accountList.size()>0)
        {
            update accountList;
        }
    }
    
    public void countInactiveContact(List<Contact> contactList)
    {
        Set<Id> accountIds= new Set<Id>();
        
        For(Contact record:contactList)
        {
            if(record.AccountId!=Null)
            {
                if(Trigger.isUpdate)
                {
                    if(triggerOldMap.get(record.Id).Status__c!=record.Status__c)
                        accountIds.add(record.AccountId);
                }
                else
                {
                    accountIds.add(record.AccountId);
                }
            }
        }
        
        List<Account> accountList = new List<Account>();
        
        if(accountIds.size()>0)
        {
            List<Account> inactiveList = [SELECT Id, No_Of_Inactive_Contact__c,
                                          (SELECT id, AccountId, Status__c FROM Contacts WHERE Status__c ='Inactive')
                                          FROM Account WHERE Id IN :accountIds];
            
            for(Account inactiveRecord:inactiveList)
            {
                Account accountRecord =new Account();
                accountRecord.Id= inactiveRecord.Id;
                accountRecord.No_Of_Inactive_Contact__c=inactiveRecord.Contacts.size();
                accountList.add(accountRecord);
            }
        }
        
        if(accountList.size()>0)
        {
            update accountList;
        }
    }
    
    Public void countContactWithSingleQuery(List<Contact> contactList)
    {
        integer count =1;
        
        Set<Id> accountIds= new Set<Id>();
        
        For(Contact record:contactList)
        { 
            if(record.AccountId!=Null)
            {
                if(Trigger.isUpdate)
                {
                    if(triggerOldMap.get(record.Id).AccountId!=record.AccountId)
                    {
                        accountIds.add(triggerOldMap.get(record.Id).AccountId);
                        accountIds.add(record.AccountId);
                    }
                    if(triggerOldMap.get(record.Id).Status__c!=record.Status__c)
                        accountIds.add(record.AccountId);
                }
                else
                {
                    accountIds.add(record.AccountId);
                }
            }
        }
        
        if(accountIds.size()>0)
        {
            List<Account> accountList = [SELECT Id, No_Of_Active_Contact__c,No_Of_Inactive_Contact__c,
                                         (SELECT id, AccountId, Status__c FROM Contacts)
                                         FROM Account WHERE Id IN :accountIds];
            
            for(Account record:accountList)
            {
                record.No_Of_Active_Contact__c=0;
                record.No_Of_Inactive_Contact__c=0;
                
                for(Contact contactRecord:record.Contacts)
                {
                    if(contactRecord.Status__c=='Active') 
                    {
                        record.No_Of_Active_Contact__c+=Count;
                    }
                    else  if(contactRecord.Status__c=='Inactive')
                    {
                        record.No_Of_Inactive_Contact__c+=count;
                    }
                }
            }
            
            if(accountList.size()>0)
            {
                system.debug(accountList);
                update accountList;
            }
        }
    }
}