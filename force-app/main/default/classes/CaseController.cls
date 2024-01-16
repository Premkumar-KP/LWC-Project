public with sharing class CaseController {
    
    @AuraEnabled(cacheable=true)
    public static List<Case> getOpenCases(){
       
        return[SELECT Subject,Owner.Name,Age__c
        FROM Case
        WHERE Status Not IN('Closed','Resolved')
        ];
    }
}