public class TaskTriggerHandler {
    
    List<Task> triggerNew;
    List<Task> triggerOld;
    Map<Id,Task> triggerNewMap;
    Map<Id,Task> triggerOldMap;
    
    public TaskTriggerHandler()
    {
        triggerNew=(List<Task>)Trigger.New;
        triggerOld=(List<Task>)Trigger.Old;
        triggerNewMap=(Map<Id,Task>) Trigger.NewMap;
        triggerOldMap=(Map<Id,Task>) Trigger.OldMap;
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