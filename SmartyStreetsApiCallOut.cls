/*-------------------------------------------------------------------------------------------
Name:       SmartyStreetsApiCallOut.cls
Purpose:    An Apex Class for CallOut used in Test Class
------------------------------History--------------------------------------------------------
Version     Author                Date                 Detail Description 
-------     ---------------       --------------       ------------------
1.0         Sourabh Naik          29th Oct 2022        Initial Development 
--------------------------------------------------------------------------------------------*/
public class SmartyStreetsApiCallOut {
    /*
     * Method Name : getInfoFromExternalService
     * Return Type : HttpResponse
     * Parameters : String, String, String, String, String, String
     * Description : Http Response Method for test class callout
     * */
    public static HttpResponse getInfoFromExternalService(String street, String city, String state, String zipcode, String candidate, String match) {
        String URL = System.Label.SmartyStreetURL;
        String AuthToken = System.Label.SmartyStreetAuthToken;
        String AuthID = System.Label.SmartyStreetAuthID;
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(URL+'?auth-id='+AuthID+'&auth-token='+AuthToken+'&street='+street+'&street2=&city='+city+'&state='+state+'&zipcode='+zipcode+'&candidates='+candidate+'&match='+match);
        req.setMethod('GET');
        Http htt = new Http();
        HttpResponse res = htt.send(req);
        return res;
    }
}