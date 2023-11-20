public class CustomerTriggerHandler {
    
    List<Customer__c> triggerNew;
    List<Customer__c> triggerOld;
    Map<Id,Customer__c> triggerNewMap;
    Map<Id,Customer__c> triggerOldMap;
    
    public CustomerTriggerHandler()
    {
        
        triggerNew=(List<Customer__c>)Trigger.New; 
        triggerOld=(List<Customer__c>)Trigger.Old;
        triggerNewMap=(Map<Id,Customer__c>) Trigger.NewMap;
        triggerOldMap=(Map<Id,Customer__c>) Trigger.OldMap;
    }
    
    public void doAction()
    {
        Switch on Trigger.OperationType
        {
            when BEFORE_INSERT
            {
                
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
                onAfterupdate();
            }
            
            when BEFORE_DELETE
            {
                onBeforeDelete();
            }
            
            when AFTER_DELETE
            {
                
            }
            
            when AFTER_UNDELETE
            {
                
            }
        }
    }
    
    public void onAfterInsert()
    {
        
    }
    
    public void onAfterupdate()
    {
        
    }
    
    public void onBeforeDelete()
    {
        
    }    
}