public class OpportunityTriggerHandler {
    
    List<Opportunity> triggerNew;
    List<Opportunity> triggerOld;
    Map<Id,Opportunity> triggerNewMap;
    Map<Id,Opportunity> triggerOldMap;
    
    public OpportunityTriggerHandler()
    {
        triggerNew=(List<Opportunity>)Trigger.New;
        triggerOld=(List<Opportunity>)Trigger.Old;
        triggerNewMap=(Map<Id,Opportunity>) Trigger.NewMap;
        triggerOldMap=(Map<Id,Opportunity>) Trigger.OldMap;
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
    
}