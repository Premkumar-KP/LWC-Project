public with sharing class TaskManagerController {
    @AuraEnabled(cacheable=true)
    public static List<Task_Manager__c> getIncompletedTask(){
            return[SELECT Id,Name,Start_Date__c
                   FROM Task_Manager__c
                   WHERE Is_Completed__c=false AND OwnerId=:userInfo.getUserId()
                   WITH USER_MODE
                   ORDER BY Start_Date__c
                   ];
    }


    @AuraEnabled(cacheable=true)
    public static List<Task_Manager__c> getcompletedTask(){
            return[SELECT Id,Name,Start_Date__c
                   FROM Task_Manager__c
                   WHERE Is_Completed__c=true AND OwnerId=:userInfo.getUserId()
                   WITH USER_MODE
                   ORDER BY Completed_Date__c DESC
                   ];
    }
}
