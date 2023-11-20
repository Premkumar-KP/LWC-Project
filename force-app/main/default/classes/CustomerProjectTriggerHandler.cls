public class CustomerProjectTriggerHandler {
    
    
    List<Customer_Project__c> triggerNew;
    List<Customer_Project__c> triggerOld;
    Map<Id,Customer_Project__c> triggerNewMap;
    Map<Id,Customer_Project__c> triggerOldMap;
    
    public 	CustomerProjectTriggerHandler()
    {
        
        triggerNew=(List<Customer_Project__c>)Trigger.New; 
        triggerOld=(List<Customer_Project__c>)Trigger.Old;
        triggerNewMap=(Map<Id,Customer_Project__c>) Trigger.NewMap;
        triggerOldMap=(Map<Id,Customer_Project__c>) Trigger.OldMap;
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