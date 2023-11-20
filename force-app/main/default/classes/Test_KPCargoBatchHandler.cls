@isTest
public class Test_KPCargoBatchHandler {
    
    @isTest
    private static void testBatch()
    {
        List<User> userList =[SELECT Id, Email, Profile.Name 
                              FROM User 
                              where Profile.Name IN ('System Administrator','Standard User')
                             ];
        //system.debug('userrrrr'+userList);
        List<Branch__c> branchList=new List<Branch__c>();
        
        Branch__c branch1= new Branch__c(Branch_Manager__c=userList[0].Id, Name='ABC', Total_Delivery_pending__c=NULL);
        Branch__c branch2= new Branch__c(Branch_Manager__c=userList[0].Id, Name='DEF', Total_Delivery_pending__c=NULL);
        Branch__c branch3= new Branch__c(Branch_Manager__c=userList[1].Id, Name='GHI', Total_Delivery_pending__c=NULL);
        
        branchList.add(branch1);
        branchList.add(branch2);
        branchList.add(branch3);
        
        insert branchList;
        
        List<Delivery__c> deliveryList=new List<Delivery__c>();
        
        Delivery__c delivery1=new Delivery__c(Delivery_Status__c='Not Started',Branch_Name__c=branch1.Id);
        Delivery__c delivery2=new Delivery__c(Delivery_Status__c='Out For Delivery	',Branch_Name__c=branch1.Id);
        Delivery__c delivery3=new Delivery__c(Delivery_Status__c='Out For Delivery	',Branch_Name__c=branch2.Id);
        Delivery__c delivery4=new Delivery__c(Delivery_Status__c='Not Started',Branch_Name__c=branch2.Id);
        Delivery__c delivery5=new Delivery__c(Delivery_Status__c='Out For Delivery	',Branch_Name__c=branch3.Id);
        
        deliveryList.add(delivery1);
        deliveryList.add(delivery2);
        deliveryList.add(delivery3);
        deliveryList.add(delivery4);
        deliveryList.add(delivery5);
        
        insert deliveryList;
        
        Test.startTest();
        Database.executeBatch(new KPCargoBatchHandler());
        Test.stopTest();
        
        List<Branch__c> updatedBranches = [SELECT Total_Delivery_pending__c FROM Branch__c WHERE Id =:branch1.Id];
        //system.debug(updatedBranches[0].Total_Delivery_pending__c);
        System.assertEquals(2,updatedBranches[0].Total_Delivery_pending__c);
        // system.assertEquals(expected, actual, msg)
        List<EmailMessage> sentEmails = [SELECT Subject FROM EmailMessage];
        //system.debug('@@ '+sentEmails.size());
        System.assertEquals(3, sentEmails.size());
    }
}