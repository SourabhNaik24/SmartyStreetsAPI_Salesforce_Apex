/*-------------------------------------------------------------------------------------------
Name:       SmartyStreetApi_Test.cls
Purpose:    An Apex Test Class for SmartyStreetApi
------------------------------History--------------------------------------------------------
Version     Author                Date                 Detail Description 
-------     ---------------       --------------       ------------------
1.0         Sourabh Naik         29th Oct 2022        Initial Development 
--------------------------------------------------------------------------------------------*/
@IsTest
public class SmartyStreetApi_Test {
    /*
     * Method Name : positiveScenario
     * Return Type : void
     * Parameters : 
     * Description : To test the positive test case
     * */
    @IsTest
    public static void positiveScenario() {
        try {
            Test.setMock(HttpCalloutMock.class, new SmartyStreetsApiMock());
            
            List<Event__c> even = new List<Event__c>();
            
            Event__c eve = new Event__c();
        	eve.Event_Name__c  = 'Test';
            eve.Street__c = '142 Park Rd';
            eve.City__c = 'Pittsford';
            eve.State__c = 'NY';
            eve.Zip_Code__c = '14534';
           	eve.Canditate__c = 10;
            eve.Match__c = 'invalid';
            eve.Location_Verified__c = false;
            eve.Error_Description__c = '';
        	even.add(eve);
            
        	Event__c eve1 = new Event__c();
        	eve1.Event_Name__c  = 'Test1';
        	eve1.Street__c = '142 Park Rd';
            eve1.City__c = 'Pittsford';
            eve1.State__c = 'NY';
            eve1.Zip_Code__c = '14534';
            eve1.Canditate__c = 10;
            eve1.Match__c = 'invalid';
            eve1.Location_Verified__c = false;
            eve1.Error_Description__c = '';
            even.add(eve1);
            
            HttpResponse res = SmartyStreetsApiCallOut.getInfoFromExternalService('142 Park Rd','Pittsford','NY','14534','10','invalid');
            
            SmartyStreetApi.updateEventCheckBox(even);
            //SmartyStreetApi.verifyAddress(even[0].Id, even[0].Street__c, even[0].City__c, even[0].State__c, even[0].Zip_Code__c, String.ValueOf(even[0].Canditate__c), even[0].Match__c);
        }
        catch(Exception exp) {
            system.debug(exp);
        }
    }
}