public class EmailHelper {
    
    public static void sendEmailNotification(String toAddress, String subject, String body){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toaddresses=New string[]{toAddress};
        message.subject=subject;
        message.htmlbody=body;
        Messaging.SingleEmailMessage[] emailMessages = new List<Messaging.SingleEmailMessage>{message};
        Messaging.SendEmailResult[] result=Messaging.sendEmail(emailMessages);
        if(result[0].Success){
            system.debug('Mail Send Succesfully');
        }
        else{
            system.debug('Error in Sending Mail');
        }
    }
}