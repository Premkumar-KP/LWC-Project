public class ContactQueueableHandler implements Queueable{

    public void execute(QueueableContext qc){
        QueueableFinalizer queFinalizer = new QueueableFinalizer();
        system.attachFinalizer(queFinalizer);
        deleteLastyearContact();
        system.enqueueJob(New AccountQueueableHandler());
    }
    public static void deleteLastyearContact(){
        
        List<Contact> contactList = [SELECT Id FROM Contact WHERE CreatedDate=LAST_N_MONTHS:1];
        if(contactList.size()>0){
            database.delete(contactList, false);
        }
    }
}