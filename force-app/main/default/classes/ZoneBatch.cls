/*
@Author        :Premkumar K
@Date          :01/06/2023
@Description   :Batch Class to update the zones record in the store object. 
*/
public class ZoneBatch implements Database.Batchable <sObject>,Database.stateful{
    // Variables to track success and failure records
    @TestVisible
    integer successRecordsCount=0,failedRecordsCount=0;
    Map<String,String> failedRecordsMap= new Map<String,String>();
    // Variables to store job information
    AsyncApexJob jobRecord;
    String jobId;
    
    // Start method to return the query locator for batch processing
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query='Select Id,Zone_Code__c,Zones__c From Store__c Where Zone_Code__c!=Null and Zones__c=Null';
        return Database.getQueryLocator(query);
    }
    
    // Execute method to process the batch of records
    public void execute(Database.BatchableContext bc, List<Store__c> storeList){
        updateZoneInStore(storeList);
    }
    
    // Finish method to perform post-processing tasks
    public void finish(Database.BatchableContext bc){
        
        jobRecord = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email 
                     FROM AsyncApexJob WHERE Id = :bc.getJobId()];
        JobId=bc.getJobId();
        // Start another batch job of MarketBatch
        Database.executeBatch(New MarketBatch());
        // Send email notification to the admin
        sendEmailToAdmin();
    }
    
/*
@Author       :PremKumar K
@CreatedDate  :01/06/2023
@Description  :Method to update zone in the store records.
@ModifiedDate :
@ModifiedBy   :
*/
    public void updateZoneInStore(List<Store__c> storeQueryList){
        Set<String> zoneCodesList = new Set<String>();
         // Collect unique zone codes from the store records
        for (Store__c record:storeQueryList){
            zoneCodesList.add(record.Zone_Code__c);
        }
         // Query the existing zone records based on zone codes
        List<Zones__c> zoneList =new List<Zones__c>([SELECT Name FROM Zones__c WHERE Name IN :zoneCodesList]);
        
        Map<String, Id> zoneMap = new Map<String,Id>();
        
        Map<Id,Store__c> updateMap=new Map<Id,Store__c>();
        
        for (Zones__c zone:zoneList) 
        {
            zoneMap.put(zone.Name, zone.Id);
        }
        List<Store__c> storeList=new List<Store__c>();    
        List<Zones__c> newZoneList = new List<Zones__c>();
        
        // Iterate the store records and update the zone information
        for (Store__c store:storeQueryList) {
            if (zoneMap.keySet().contains(store.Zone_Code__c)){
                store.Zones__c = zoneMap.get(store.Zone_Code__c); 
                updateMap.put(store.Id,store);
            }                   
            else{ 
                newZoneList.add(new Zones__c(Name = store.Zone_Code__c));
                storeList.add(store);
            }
        }
        // Insert new zone records
        if (!newZoneList.isEmpty()){
            insert newZoneList;
            // Update the store records with the newly created zone IDs
            for (Store__c store : storeList){
                for (Zones__c zone : newZoneList){
                    system.debug('Zone name'+zone.Name);
                    if (store.Zone_Code__c == zone.Name)
                        store.Zones__c = zone.Id;
                    updateMap.put(store.Id,store);
                }                   
            }
        }
        // Update the store records
        List<Database.SaveResult> saveResultList=Database.update(updateMap.values(),false);
        For(Database.SaveResult saveResult:saveResultList){
            If(saveResult.isSuccess()){
                // Increment the count of successfully updated records
                successRecordsCount+=1;
            }
            else{
                // Increment the count of failed records and store the error message
                failedRecordsCount+=1;
                failedRecordsMap.put(saveResult.getId(),saveResult.getErrors()[0].getMessage());
            }
        }
    }
/*
@Author       :PremKumar K
@CreatedDate  :01/06/2023
@Description  :Construct email body and send email notification to the system administrator.
@ModifiedDate :
@ModifiedBy   :
*/    
    public void sendEmailToAdmin()
    {
        // Query system administrator user
        List<User> systemAdmin = [SELECT id, Email 
                                  FROM User 
                                  WHERE Profile.Name =: 'System Administrator' and IsActive=True];
        String toAddress= systemAdmin[0].Email;
        String subject='Job Status '+JobId;
        String body='Batch Job Status<br/>Total Jobs:: '+jobRecord.JobItemsProcessed;
        body+='<br/> Job Error:: '+jobRecord.NumberOfErrors;
        body+='<br/> Total Success Records Count:: '+successRecordsCount;
        body+='<br/> Total failed Records Count:: '+failedRecordsCount;
        
        // Iterate failed records and generate email body
        for(String record:failedRecordsMap.keySet()){
            body+='<br/>'+record;
            String recordLink=url.getSalesforceBaseUrl().toExternalForm()+'/'+failedRecordsMap.get(record);
            body+=recordLink;
            system.debug('Link'+recordLink);
        }
        // Send email notification to the system administrator
        EmailHelper.sendEmailNotification(toAddress, subject, body);
    }
}