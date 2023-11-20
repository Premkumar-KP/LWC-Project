public class KPInsuranceBatch implements Database.Batchable<sObject>,Database.Stateful{

    Integer recordProcessed=0;
    
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
		string query='SELECT Id,OwnerId,Name,City FROM Lead WHERE NumberofLocations__c > 5 AND Status=\'Closed - Not Converted\'';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc,List<Lead> leadList)
    {
        set<String> userIds=new set<String>();
        List<Task> managerTask=new List<Task>();
        
        for(Lead record:leadList)
        {
            userIds.add(record.OwnerId);
        }
        Map<Id,User> userManagerId=new Map<Id,User>([SELECT ManagerId,LastName FROM User WHERE Id IN:userIds]);
        for(Lead record:leadList)
        {
            record.OwnerId=userManagerId.get(record.OwnerId).ManagerId;
            system.debug(record.OwnerId);
            
            Task newTask=new Task();
            newTask.WhoId=record.Id;
            newTask.Status='Not Started	';
            newTask.ActivityDate=system.today();
            newTask.Subject='Check lead';
            newTask.Description='Lead is not converted';
            newTask.OwnerId=record.OwnerId;
            managerTask.add(newTask);
            recordProcessed+=1;
        }
        
        if(!leadList.isEmpty())
        {
           List<Database.SaveResult> leadChange= Database.update(leadList,false);
           List<Database.SaveResult> newManagerTask= Database.insert(managerTask,false);
            system.debug('Lead'+leadList);
            system.debug('Manager'+managerTask);
        }
    }
        
    public void finish(Database.BatchableContext bc)
    {
        AsyncApexJob asyncApexjob=[SELECT Id,Status,NumberOfErrors,JobItemsProcessed,TotalJobItems,CreatedBy.Email 
                               FROM AsyncApexJob WHERE Id=:bc.getJobId()]; 
        
        //EmailHelper.sendEmailNotification(asyncApexjob.CreatedBy.Email, asyncApexjob.Status, 'Record Processed::'+recordProcessed);
    }
}