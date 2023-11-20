public class MarketBatch implements Database.Batchable <sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext bc) 
    {
        String query='Select Id,Market_Code__c,Market__c From Store__c Where Market_Code__c!=Null and Market__c=Null';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Store__c> storeQueryList)
    {
        Set<string> marketCodeslist = new Set<string>();
        
        for(Store__c record:storeQueryList){ 
            marketCodeslist.add(record.Market_Code__c);
        }
        List<Market__c> marketList =new List<Market__c>([SELECT Name FROM Market__c WHERE Name IN :marketCodeslist]);
        
        Map<String, Id> marketMap = new Map<String,Id>();
        Map<Id,Store__c> updateMap=new Map<Id,Store__c>();
        
        for(Market__c record:marketList){
            marketMap.put(record.Name,record.Id);
        }
        List<Store__c> storeList=new List<Store__c>();    
        List<Market__c> newMarketList = new List<Market__c>();
        
        for (Store__c record:storeQueryList) {
            if (marketMap.keySet().contains(record.Market_Code__c)){
                record.Market__c = marketMap.get(record.Market_Code__c); 
                updateMap.put(record.Id,record);
            }                   
            else 
                newMarketList.add(new Market__c(Name = record.Market_Code__c));
            storeList.add(record);
        }
        if (!newMarketList.isEmpty())
        {
            insert newMarketList;
            for (Store__c store :storeList){
                for(Market__c market : newMarketList){
                    if (store.Market_Code__c == market.Name)
                        store.Market__c = market.Id;
                    updateMap.put(store.Id,store);
                }                   
            }
        }
        Database.update(updateMap.values(),false);
    }
    
    public void finish(Database.BatchableContext bc)
    {
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email 
                            FROM AsyncApexJob 
                            WHERE Id = :bc.getJobId()]; 
        //EmailHelper.sendEmailNotification(job.CreatedBy.Email,job.Status,'Record Processed: ' + job.JobItemsProcessed);
    } 
}