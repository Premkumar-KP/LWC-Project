public class AccountQueueableHandler implements Queueable{
    
    public void execute(QueueableContext qc){
        QueueableFinalizer queFinalizer = new QueueableFinalizer();
        system.attachFinalizer(queFinalizer);
        deleteLastyearAccount();   
    }
    public static void deleteLastyearAccount(){
        
        List<Account> accountList = [SELECT Id FROM Account WHERE CreatedDate=LAST_N_MONTHS:1];
        if(accountList.size()>0){
           database.delete(accountList, false);
        }
    }
}