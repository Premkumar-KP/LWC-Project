trigger ContactTrigger on Contact (before insert,before delete,after insert,after delete, after update, after undelete) {

    ContactTriggerHandler con = new ContactTriggerHandler();
    con.doAction();
    
}