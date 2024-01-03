public with sharing class LeadController {
   @AuraEnabled(cacheable=true)
    public static List<Lead> getLeadRecords(){

        return [SELECT Id,Name,Email,Rating,Status FROM Lead WHERE Rating!=null];
    }
}