public class AccountTriggerHandler {
    
    List<Account> triggerNew;
    List<Account> triggerOld;
    Map<Id,Account> triggerNewMap;
    Map<Id,Account> triggerOldMap;
    
    public AccountTriggerHandler()
    {
        
        triggerNew=(List<Account>)Trigger.New; 
        triggerOld=(List<Account>)Trigger.Old;
        triggerNewMap=(Map<Id,Account>) Trigger.NewMap;
        triggerOldMap=(Map<Id,Account>) Trigger.OldMap;
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