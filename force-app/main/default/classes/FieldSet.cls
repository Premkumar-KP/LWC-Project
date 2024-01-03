public with sharing class FieldSet {

    public void candFieldSet(List<Candidate__c> contextTrigger){
        String objectAPIName = 'Candidate__c';
        String fieldSetName = 'Candidate_History';
        
        Schema.SObjectType objectType = Schema.getGlobalDescribe().get(objectAPIName);
        Schema.DescribeSObjectResult objectDescribe = objectType.getDescribe();
        Schema.FieldSet fieldSet = objectDescribe.fieldSets.getMap().get(fieldSetName);
        
        List<Schema.FieldSetMember> fieldSetMembers = fieldSet.getFields();
        Candidates_History__c candHisInsDelUnde = new Candidates_History__c ();
        List<Candidates_History__c> candHisList = new List<Candidates_History__c>();
        if(fieldSet!=Null){
            for (Candidate__c record : contextTrigger) {
                if(triggerOldMap==Null){
                    candHisInsDelUnde.Candidate_Id__c = record.Id;
                    candHisInsDelUnde.Operation_type__c = trigger.isInsert?'Insert':'Undelete';
                    candHisList.add(candHisInsDelUnde);
                }
                if(trigger.isdelete){
                    candHisInsDelUnde.Field_Name__c = record.Name;
                    candHisInsDelUnde.Operation_type__c = 'Delete';
                    candHisList.add(candHisInsDelUnde);
                }
                for (Schema.FieldSetMember fieldSetMember : fieldSetMembers) {
                    String fieldAPIName = fieldSetMember.getFieldPath();
                    Object fieldValue = record.get(fieldAPIName);
                    if(triggerOldMap!=Null && (record.get(fieldAPIName) != triggeroldMap.get(record.Id).get(fieldAPIName))){
                        System.debug('Field: ' + fieldAPIName + ', Value: ' + fieldValue);
                        Object oldFieldValue = triggeroldMap.get(record.Id).get(fieldAPIName);
                        Candidates_History__c candHisUpd = new Candidates_History__c ();
                        candHisUpd.Candidate_Id__c = record.Id;
                        candHisUpd.Field_Name__c = fieldAPIName;
                        candHisUpd.New_Value__c = String.valueOf(fieldValue)!=Null?String.valueOf(fieldValue):' ';
                        candHisUpd.Old_Value__c =  String.valueOf(oldFieldValue)!=Null?String.valueOf(oldFieldValue):' ';
                        candHisUpd.Operation_type__c = 'Update';
                        candHisList.add(candHisUpd);
                        
                    }
                }
            }
            if(!candHisList.isEmpty()){
                system.debug(candHisList);
                insert candHisList;
            }
        }
    }
}