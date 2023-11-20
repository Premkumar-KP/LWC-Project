public class KaniContactHandler {
    
    List<Contact>triggerNew;
    List<Contact>triggerOld;
    Map<Id,Contact>triggerNewMap;
    Map<Id,Contact>triggerOldMap;
    
    public KaniContactHandler()
    {
        triggerNew = (List<Contact>)Trigger.New;
        triggerOld = (List<Contact>)Trigger.Old;
        triggerNewMap = (Map<Id,Contact>)Trigger.NewMap;
        triggerOldMap = (Map<Id,Contact>)Trigger.OldMap;
    }
    
    public void doAction()
    {
        switch on Trigger.operationType
        {
            when BEFORE_INSERT
            {
                
            }
            when BEFORE_UPDATE
            {
                
            }
            when BEFORE_DELETE
            {
                CountOfActiveAndInactive(triggerOld,true);
            }
            when AFTER_INSERT
            {
                System.debug('New List '+triggerNew);
                
                CountOfActiveAndInactive(triggerNew,false);
            }
            when AFTER_UPDATE
            { 
                System.debug('New List '+triggerNew);
                updateCountOfActiveAndInactive(triggerNew,triggerOldMap);
            }
            when AFTER_DELETE
            {
                
            }
            when AFTER_UNDELETE
            {
                CountOfActiveAndInactive(triggerNew,false);
            }
            
        }
    }
    public static void CountOfActiveAndInactive(List<Contact>ContactList,Boolean isDelete)
    {
        Integer sub=1;
        if(isDelete)
        {
            sub=-1;
        }
        Set<Id>accIds = new Set<Id>();
        
        for(Contact con :ContactList)
        {
            accIds.add(con.AccountId);                      
        }
        
        Map<Id,Account> accMap = new Map<Id,Account>( [Select Id,No_Of_Inactive_Contact__c,No_Of_Active_Contact__c 
                                                      from Account Where Id in : accIds ]);
        for(Contact con : ContactList)
        {
            if(con.Status__c=='Active')
            {
                accMap.get(con.AccountId).No_Of_Active_Contact__c+=sub;
            }
            else{
                accMap.get(con.AccountId).No_Of_Inactive_Contact__c+=sub;
            }
        } 
        update accMap.Values();
    }
    
    public static void updateCountOfActiveAndInactive(List<Contact>ContactList,Map<Id,Contact>conOldMap){
        Integer subAct=1;
        Integer subInact=1;
        
        Set<Id>accIds = new Set<Id>();
        
        for(Contact con :ContactList)
        {
            accIds.add(con.AccountId);                      
        }
        
        Map<Id,Account>accMap = new Map<Id,Account>( [Select Id,No_Of_Inactive_Contact__c,No_Of_Active_Contact__c 
                                                      from Account Where Id IN : accIds ]);
        for(Contact con : ContactList)
        {
            if(con.Status__c=='Active' &&conOldMap.get(con.Id).Status__c=='Inactive')
            {
                subAct=1;
                subInact=-1;
                accMap.get(con.AccountId).No_Of_Active_Contact__c+=subAct;
                accMap.get(con.AccountId).No_Of_Inactive_Contact__c+=subInact;
            }
            if(con.Status__c=='Inactive' &&conOldMap.get(con.Id).Status__c=='Active')
            {
                subAct=-1;
                subInact=1;
                accMap.get(con.AccountId).No_Of_Active_Contact__c+=subAct;
                accMap.get(con.AccountId).No_Of_Inactive_Contact__c+=subInact;
            }
        } 
        update accMap.Values();
    }
}