@isTest
public class Test_ZoneBatch {
    @IsTest
    static void testUpdateZoneInStore() {
        // Create test zones
        Zones__c zone1 = new Zones__c(Name='Zone A');
        Zones__c zone2 = new Zones__c(Name='Zone B');
        insert new List<Zones__c>{zone1,zone2};
            
        // Create test stores with different zone codes
        Store__c store1 = new Store__c(Name = 'Store 1', Zone_Code__c = 'Zone A');
        Store__c store2 = new Store__c(Name = 'Store 2', Zone_Code__c = 'Zone B');
        Store__c store3 = new Store__c(Name = 'Store 3', Zone_Code__c = 'Zone C'); // Zone C does not exist yet
        
        insert new List<Store__c>{store1, store2, store3};
        
        // Call the updateZoneInStore method
        ZoneBatch batch = new ZoneBatch(); // Assign the ZoneBatch instance to a variable
        Test.startTest();
        Database.executeBatch(batch); // Execute the batch using the variable
        Test.stopTest();
        
        // Verify the updated zone fields for stores
        List<Store__c> updatedStores = [SELECT Id, Zone_Code__c, Zones__c FROM Store__c];
        
        System.assertEquals(zone1.Id, updatedStores[0].Zones__c, 'Store 1 should be updated with Zone A');
        System.assertEquals(zone2.Id, updatedStores[1].Zones__c, 'Store 2 should be updated with Zone B');
        System.assertEquals(null, updatedStores[2].Zones__c, 'Store 3 should not have a zone');
        
        // Verify the counts of success and failed records
        System.assertEquals(2, batch.successRecordsCount, 'There should be 2 successfully updated records');
        System.assertEquals(1, batch.failedRecordsCount, 'There should be 1 failed record');
    }
}