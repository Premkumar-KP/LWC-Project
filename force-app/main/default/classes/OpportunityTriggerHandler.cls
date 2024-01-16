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
                onAfterDelete();
            }
            
            when AFTER_UNDELETE
            {
                onAfterDelete();
            }
        }
    }
    
    public void onAfterInsert()
    {
        countNoOfOpportunity(triggerNew,null);
    }
    
    public void onAfterUpdate()
    {  
        countNoOfOpportunity(triggerNew,triggerOldMap);
    }

    public void onAfterDelete()
    {
        countNoOfOpportunity(triggerOld,null);
    }

    public void onAfterDelete()
    {
        countNoOfOpportunity(triggerNew,null);
    }

     public static void countNoOfOpportunity(List<Opportunity> triggerNew, Map<Id,Opportunity> triggerOldMap){
        Set<Id> accIds = new Set<Id>();
        for(Opportunity oppRec:TriggerNew){
            if(Trigger.isUpdate && oppRec.AccountId!=triggerOldMap.get(oppRec.Id).AccountId){
                accIds.add(oppRec.AccountId);
                accIds.add(triggerOldMap.get(oppRec.Id).AccountId);
            } else{
                accIds.add(oppRec.AccountId);
            }
        }
        
        if(!accIds.isEmpty()){
            
            List<Account> accList = [SELECT Id,Total_No_Of_Opportunity__C,
                                     (SELECT Id FROM Opportunities)
                                     FROM Account
                                     WHERE Id=:accIds];
            if(!accList.isEmpty()){
                for(Account accRec:accList){
                    accRec.Total_No_Of_Opportunity__C=accRec.Opportunities.size();
                }
                Database.update(accList,false);
            }
            
        }
    }
    
    public static void checkProductAvailable(List<Opportunity> triggerNew,Map<Id,Opportunity> triggerOldMap){
        
        set<Id> opportunityIds = new Set<Id>();
        
        for(Opportunity oppRec: triggerNew){
            if(oppRec.StageName=='Closed Won' && triggerOldMap.get(oppRec.Id).StageName!='Closed Won'){
                opportunityIds.add(oppRec.Id);
            } 
        }
        
        Map<Id,Decimal> oppoCheck = new Map<Id,Decimal>();
        
        List<Opportunity> opportunityList =[Select id,
                                           (select id from OpportunityLineItems)
                                           from opportunity
                                           where id=:opportunityIds];
                
        for(opportunity opprec : opportunityList){
            oppoCheck.put(opprec.Id,opprec.opportunityLineItems.Size());
        }
        
        for(Opportunity oppRec: triggerNew){
            if(oppoCheck.get(opprec.Id)<=0){
                oppRec.StageName.addError('No product available. Please add the product');
            }
        }
    }
    
}