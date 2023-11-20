public class OpportunityLineItemTriggerHandler {
    
    List<OpportunityLineItem> triggerNew;
    List<OpportunityLineItem> triggerOld;
    Map<Id,OpportunityLineItem> triggerNewMap;
    Map<Id,OpportunityLineItem> triggerOldMap;
    
    public OpportunityLineItemTriggerHandler()
    {
        triggerNew=(List<OpportunityLineItem>)Trigger.New;
        triggerOld=(List<OpportunityLineItem>)Trigger.Old;
        triggerNewMap=(Map<Id,OpportunityLineItem>) Trigger.NewMap;
        triggerOldMap=(Map<Id,OpportunityLineItem>) Trigger.OldMap;
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
                onAfterUpdate();
            }
            
            when BEFORE_DELETE
            {
                
            }
            
            when AFTER_DELETE
            {
                onAfterDelete();
            }
            
            when AFTER_UNDELETE
            {
                
            }
        }
    }
    
    public void onAfterInsert()
    {  
        
    }
    
    public void onAfterUpdate()
    {  
        
    }
    
    public void onAfterDelete()
    { 
        
    }   
}