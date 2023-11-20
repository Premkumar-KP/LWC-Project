public  class AccountController {
    @AuraEnabled(cacheable=true)
    public static List <Account>  getAccounts(){
        return [      
            Select 
            Name,rating 
            FROM 
            Account
            WHERE Phone!=Null
            LIMIT 5 
            ];
    }
    @AuraEnabled
    public static String createAccount(String name, String phone){

        Account record= new Account();
        record.Name=name;
        record.Phone=phone;
        Insert record;
        return record.Id;
    }
}