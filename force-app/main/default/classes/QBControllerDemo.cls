public class QBControllerDemo {
    
    public string Code {get;set;}
    public string realmId {get;set;}
    public string accessToken {get;set;}
    
    public PageReference accessToken() {
        
        String ClientId='ABthwqAM8ahVJKcep0K4g7KHoYASeeHOnopFkV7oQrv8bXziNo';
        String Secret ='zyS50luomunyKliKKGiJYXF9tNgl7oc1vkB5bFDA';
        
        Code=ApexPAges.currentPage().getParameters().get('code');
        realmId=ApexPAges.currentPage().getParameters().get('realmid');
        system.debug('Code:: '+code);
        system.debug('RealmId:: '+realmId);
        
        String endPoint='https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer';
        //callback : https://d5i00000bxvwieat-dev-ed--c.develop.vf.force.com/apex/QBControllerUri
        //String baseUr1=System.Url.getSalesforceBaseUrl ().toExternalForm() + '/apex/QBControllerUri';
        
        String baseUrl='https://d5i00000bxvwieat-dev-ed--c.develop.vf.force.com/apex/QBControllerUri';
        //Body: grant_type=authorization_code
        String requestBody='grant_type=authorization_code&code='+Code+'&redirect_uri='+baseUrl;
        
        //encode client id and secret- ClientId : ClientSecret
        
        String b = ClientId + ':' + Secret;
        String encodedString = 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(b));
        
        system.debug(encodedString);
        
        //1. oAuth url - to get access code - vf page
        //2. access token
        //3. create a customer, getting compnay info
        // GET ACCESS TOKEN - body, headers (Accept, Authorization,Content-type), end point
        
        Http http= new Http();
        HttpRequest request = new HttpRequest();
        
        request.setHeader('Accept','application/json');
        request.setHeader('Content-Type','application/x-www-form-urlencoded') ;
        request.setHeader('Authorization',encodedString);
        request.setMethod('POST') ;
        request.setBody(requestBody) ;
        request.setEndpoint(endpoint) ;
        
        HttpResponse response = new HttpResponse();
        
        try{
            response=http.send(request);
            system.debug(response.getStatus());
            if(response.getStatusCode()==200 || response.getStatusCode()==201){
                
                String body=response.getBody();
                system.debug('Response Body:: '+body); //Access Token , Refresh Token .Data is in Key : value pair 
                Map<String,Object> responseObj=(Map<String,Object>)System.JSON.deserializeUntyped(body);
                accessToken=(String)responseObj.get('access_token');
                system.debug('Access Token :: '+accessToken);
                
                for(string key:responseObj.keyset()){
                    system.debug(key);
                }
                
                //***** get company info - resource access
                //https://sandbox-quickbooks.api.intuit.com
                http =new Http();
                request=new HttpRequest();
                request.setMethod('GET');
                string ep= 'https://sandbox-quickbooks.api.intuit.com/v3/company/' + realmId +'/companyinfo/'+ realmId;
                request.setHeader('Accept','application/json');
                request.setHeader('Content-Type','application/json');
                request.setHeader('Authorization','Bearer '+ accessToken);
                request.setEndpoint(ep);
                response=http.send(request);
                system.debug(response.getStatus());
                if(response.getStatusCode()==200 || response.getStatusCode()==201){
                    string finalResponse = response.getBody();
					system.debug('Final response:: '+finalResponse);
                }
                //***** get company info - resource access
            }
        }
        catch(Exception e){
            system.debug(e);
        }
        return null;
    }
    
}