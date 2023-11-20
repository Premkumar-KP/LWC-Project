public class ContactRelationshipTriggerHandler {
    
    List<Contact_RelationShip__c> triggerNew;
    List<Contact_RelationShip__c> triggerOld;
    Map<Id,Contact_RelationShip__c> triggerNewMap;
    Map<Id,Contact_RelationShip__c> triggerOldMap;
    
    public ContactRelationshipTriggerHandler()
    {
        
        triggerNew=(List<Contact_RelationShip__c>)Trigger.New; 
        triggerOld=(List<Contact_RelationShip__c>)Trigger.Old;
        triggerNewMap=(Map<Id,Contact_RelationShip__c>) Trigger.NewMap;
        triggerOldMap=(Map<Id,Contact_RelationShip__c>) Trigger.OldMap;
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
                onBeforeupdate();
            }
            
            when AFTER_UPDATE
            {
                
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
    
    public void onBeforeupdate()
    {
       
    }
    
    public void onBeforeDelete()
    {
        
    }
}