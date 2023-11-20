public class LeadBatch implements Database.Batchable <sObject> {

    Integer NoOfLeads=0;
    Date today;
    Public Database.QueryLocator start(Database.BatchableContext bc)
    {
        today=Date.today();
        String status='Open - Not Contacted';
        return Database.getQueryLocator([SELECT Id,Status FROM Lead WHERE Status=:status AND CreatedDate=:today]);
    }
    
    public void execute(Database.BatchableContext bc,List<Lead> scope)
    {
        NoOfLeads=scope.size();
    }
    
    public void finish(Database.BatchableContext bc)
    {
        if(NoOfLeads>0)
        sendEmail();
        system.debug('Mail Caleed');
    }
    
    public void sendEmail()
    {
        String toAddress='kp.prem1002@gmail.com';
        String subject='New lead created -'+NoOfLeads;
        String body=('Dear CEO, <br><br>'
                              + 'We wanted to let you know that we have received your lead and we will be contacting you soon.<br><br>'
                              + 'Best regards,<br>ABC Home Appliances');
        
        EmailHelper.sendEmailNotification(toAddress, subject, body);
        system.debug('mail send');
    }
}