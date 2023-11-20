public class KPCargoBatchHandler implements Database.Batchable<sObject>,Database.stateful{
    
    integer successRecordsCount=0,failedRecordsCount=0;
    String jobId;
    AsyncApexJob jobRecord;
    List<Delivery__c> deliveryList = new List<Delivery__c>();
    map<String,list<Delivery__c>> managerId=new Map<String,list<Delivery__c>>();
    list<Branch__c> updateBranch=new list<Branch__c>();
    Map<String,String> failedRecordsMap= new Map<String,String>();
    
    public Database.QueryLocator Start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id,Branch_Name__c
                                         FROM Delivery__c WHERE Delivery_Status__c IN ('Not started', 'Out For Delivery')
                                        ]);
    }
    public void execute(Database.BatchableContext bc,List<Delivery__c> scope){
        set<Id> branchId=new set<Id>();
        For(Delivery__c delivery:Scope){
            branchId.add(delivery.Branch_Name__c);
        }
        List<Branch__c> branchList=[Select Name,Total_Delivery_Pending__c,Branch_Manager__c,
                                    (Select Delivery_Status__c,Branch_Name__c,Branch_Name__r.Name 
                                     From Deliveries__r
                                     Where Delivery_Status__c IN ('Not started', 'Out For Delivery'))
                                    From Branch__c 
                                    Where Id=:branchId];
        
        For(Branch__c branch:branchList){
            branch.Total_Delivery_pending__c=branch.Deliveries__r.size();
            updateBranch.add(branch);
            If(branch.Deliveries__r.size()>0){
                For(Delivery__c delivery:branch.Deliveries__r){
                    if (!managerId.containsKey(branch.Branch_Manager__c)){
                        managerId.put(branch.Branch_Manager__c, new List<Delivery__c>());
                    }
                    managerId.get(branch.Branch_Manager__c).add(delivery);
                }
            }
        }  
        List<Database.SaveResult> saveResultList=Database.update(updateBranch,false);
        For(Database.SaveResult saveResult:saveResultList){
            If(saveResult.isSuccess()){
                successRecordsCount+=1;
            }
            else{
                failedRecordsCount+=1;
                failedRecordsMap.put(saveResult.getId(),saveResult.getErrors()[0].getMessage());  
            }
        }
    }
    public void finish(Database.BatchableContext bc){
        jobRecord =[SELECT Id, JobType, ApexClassId, Status, JobItemsProcessed, 
                    TotalJobItems, NumberOfErrors 
                    FROM AsyncApexJob
                    Where Id=:bc.getJobId()];
        JobId=bc.getJobId();
        
        Map<Id,User> managerEmail =new Map<Id,User>([SELECT Id, Email FROM User 
                                                     WHERE Id = :managerId.keySet() AND IsActive = true]);        
        For (String deliveryValue:managerId.keySet()) {
            deliveryList = managerId.get(deliveryValue);
            For(Id manId:managerEmail.keyset()){
                If(manId==deliveryValue){
                    sendEmailToManager(managerEmail.get(manId).Email);//sendemail
                }
            }
        }
        sendEmailToAdmin();
    }
    
    public void sendEmailToManager(string email)
    {
        String toAddress=email;
        String subject = 'Pending Deliveries Report';
        String body = 'Dear Manager,<br/>'+
            'The following branches have pending deliveries:<br/>';
        body += 'Total Delivery Pending -: '+deliveryList.size() + '<br/>';
        for (Delivery__c deliveryRecord : deliveryList) {
            body += 'Branch Name -: '+deliveryRecord.Branch_Name__r.Name + '<br/>';
            body += 'Delivery Record Id :- '+deliveryRecord.Id + '<br/>';
            body += 'Delivery Status -: '+deliveryRecord.Delivery_Status__c + '<br/>';
        }
        
        body += '<br/>Please take necessary action to deliver them as soon as possible.<br/>' +
            'Thank you,<br/>KP Cargo Services';
        EmailHelper.sendEmailNotification(toAddress, subject, body);
    } 
    
    public void sendEmailToAdmin()
    {
        List<User> systemAdmin = [SELECT id, Email FROM User 
                                  WHERE Profile.Name =: 'System Administrator' and IsActive=True];
        String toAddress= systemAdmin[0].Email;
        String subject='Job Status '+JobId;
        String body='Batch Job Status<br/>Total Jobs:: '+jobRecord.JobItemsProcessed;
        body+='<br/> Job Error:: '+jobRecord.NumberOfErrors;
        body+='<br/> Total Success Records Count:: '+successRecordsCount;
        body+='<br/> Total failed Records Count:: '+failedRecordsCount;
        
        for(String record:failedRecordsMap.keySet())
        {
            body+='<br/>'+record;
            // String recordLink=url.getSalesforceBaseUrl().toExternalForm()+'/'+failedRecordsMap.get();
            //body+=recordLink;
        }
        
        EmailHelper.sendEmailNotification(toAddress, subject, body);
    }
}