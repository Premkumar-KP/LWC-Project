public with sharing class ContractSearch {
    @AuraEnabled(cacheable=true)
    public static List<Lease_Contract__c> searchContractsByTenant(String tenantName) {
        return [SELECT Building_Name__c,Contract_End_Date__c,Contract_Start_Date__c,Customer_Phone_Number__c,Customer_Signed_By__c,Flat_Number__c,Lease_Amount__c 
                FROM Lease_Contract__c 
                WHERE Customer_Signed_By__c LIKE :'%' + tenantName + '%'];
    }

    @AuraEnabled(cacheable=true)
    public static List<Lease_Contract__c> searchContractsByBuilding(String buildingName) {
        return [SELECT Building_Name__c,Contract_End_Date__c,Contract_Start_Date__c,Customer_Phone_Number__c,Customer_Signed_By__c,Flat_Number__c,Lease_Amount__c 
                FROM Lease_Contract__c 
                WHERE Building_Name__c LIKE :'%' + buildingName + '%'];
    }
}