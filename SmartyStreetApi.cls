/*-------------------------------------------------------------------------------------------
Name:       SmartyStreetApi.cls
Purpose:    An Apex Class for REST Service for "SmartyStreet API" and Verify Address Logic
------------------------------History--------------------------------------------------------
Version     Author                Date                 Detail Description 
-------     ---------------       --------------       ------------------
1.0         Sourabh Naik          29th Oct 2022        Initial Development 
--------------------------------------------------------------------------------------------*/
public class SmartyStreetApi {
    /*
     * Method Name : verifyAddress
     * Return Type : void
     * Parameters : Id, String, String, String, String, String, String
     * Description : Performing Callout to SmartyStreets Api Endpoint in future context and performing verify address logic
     * */
    @future(callout=true)
	public static void verifyAddress(Id eveID, String street, String city, String state, String zipcode, String candidate, String match){
        try {
        	String URL = System.Label.SmartyStreetURL;
        	String AuthToken = System.Label.SmartyStreetAuthToken;
        	String AuthID = System.Label.SmartyStreetAuthID;
        
        	Http Http = new Http();
        	HttpRequest Request = new HttpRequest();
        	system.debug(URL+'?auth-id='+AuthID+'&auth-token='+AuthToken+'&street='+street+'&street2=&city='+city+'&state='+state+'&zipcode='+zipcode+'&candidates='+candidate+'&match='+match);
        	Request.setEndpoint(URL+'?auth-id='+AuthID+'&auth-token='+AuthToken+'&street='+street+'&street2=&city='+city+'&state='+state+'&zipcode='+zipcode+'&candidates='+candidate+'&match='+match);	
        	Request.setMethod('GET');
        	Request.setHeader('Content-Type', 'application/json');
			Request.setHeader('Accept','application/json');
        	HttpResponse Response = Http.send(Request);
        
        	Event__c even = new Event__c();
            	even.Id = eveID;
        
        	if(Response.getStatusCode()!=200){
            		system.debug(Response.getBody()+' + '+Response.getStatusCode());
                	even.Error_Description__c = 'Error Code is '+Response.getStatusCode();
                	update even;
            	}     
        
        	if(Response.getStatusCode()==200){
            	//system.debug('Response: ' + Response.getBody());
            	List<SmartyStreetsJSON> results = SmartyStreetsJSON.parse(Response.getBody());
            	system.debug('Response: ' + results);
            	
                    if(results.size() > 0) {
                        String address = results[0].Components.primary_number+'%20'+results[0].Components.street_name+'%20'+results[0].Components.street_suffix;
                        String Cityz = results[0].Components.city_name;
                        String Statez = results[0].Components.state_abbreviation;
                        String Zip = results[0].Components.zipcode;
                        System.debug('A: '+address+' C: '+Cityz+' S: '+Statez+' Z: '+Zip);
                        System.debug('A: '+street+' C: '+city+' S: '+state+' Z: '+zipcode);
                        if(address == street && Cityz == city && Statez == state && Zip == zipcode) {
                        	even.Location_Verified__c = true;
                			even.Error_Description__c = ' ';
            				update even;
                            return;
                        }
                        if((address != street || Cityz != city || Statez != state || Zip != zipcode) || 
                           (address != street && (city == NULL || state == NULL || zipcode == NULL)) ||
                           (Cityz != city && (street == NULL || state == NULL || zipcode == NULL)) ||
                           (Statez != state && (street == NULL || city == NULL || zipcode == NULL)) ||
                           (Zip != zipcode && (street == NULL || city == NULL || state == NULL)) ) {
                    		even.Error_Description__c = 'Not Proper Address Data Entered';
                            even.Location_Verified__c = false;
                        	update even;
                		}
                    }
        	}
        }
        catch(ListException lstExp) {
            System.debug(lstExp);
        }
    }
    /*
     * Method Name : updateEventCheckBox
     * Return Type : void
     * Parameters : List of Event__c
     * Description : Used in Trigger as we cannot directly call future methods and performing space logic for proper endpoint formation
     * */
    public static void updateEventCheckBox(List<Event__c> listEvent) {
        for(Event__c eve: listEvent) {
            String street = eve.Street__c;
            if(eve.Street__c != NULL) {
                street = eve.Street__c.replaceAll('\\s+', '%20');
            }    
            SmartyStreetApi.verifyAddress(eve.ID,street,eve.City__c,eve.State__c,eve.Zip_Code__c,String.valueOf(eve.Canditate__c),eve.Match__c);
        }
    }
}
