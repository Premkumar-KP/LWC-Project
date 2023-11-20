public  class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> searchContact(string name) {

        return [
            SELECT
            LastName,FirstName, Phone
            FROM
            Contact
            WHERE
            LastName Like : name +'%'
        ];
    }
}