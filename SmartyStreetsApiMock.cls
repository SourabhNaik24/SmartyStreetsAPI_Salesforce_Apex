/*-------------------------------------------------------------------------------------------
Name:       SmartyStreetsApiMock.cls
Purpose:    An Apex Class for that implements HttpCalloutMock
------------------------------History--------------------------------------------------------
Version     Author                Date                 Detail Description 
-------     ---------------       --------------       ------------------
1.0         Sourabh Naik          29th Oct 2022        Initial Development 
--------------------------------------------------------------------------------------------*/
@isTest
global class SmartyStreetsApiMock implements HttpCalloutMock {
    /*
     * Method Name : respond
     * Return Type : HttpResponse
     * Parameters : HTTPRequest
     * Description : Http Response Method for mock callout
     * */
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertNotEquals('https://example.com/example/test', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('[{"input_index":0,"candidate_index":0,"delivery_line_1":"22 Degroat Rd",'+
                    '"last_line":"Sandyston NJ 07827-5107","delivery_point_barcode":"078275107229",'+
                    '"components":{"primary_number":"22","street_name":"Degroat","street_suffix":"Rd",'+
                    '"city_name":"Sandyston","default_city_name":"Montague","state_abbreviation":"NJ","'+
                    'zipcode":"07827","plus4_code":"5107","delivery_point":"22","delivery_point_check_digit":"9"},'+
                    '"metadata":{"record_type":"S","zip_type":"Standard","county_fips":"34037","county_name":"Sussex",'+
                    '"carrier_route":"R007","congressional_district":"05","rdi":"Residential",'+
                    '"elot_sequence":"0032","elot_sort":"A","latitude":41.251750,"longitude":-74.788350,'+
                    '"precision":"Zip9","time_zone":"Eastern","utc_offset":-5,"dst":true},'+
                    '"analysis":{"dpv_match_code":"Y","dpv_footnotes":"AABB","dpv_cmra":"N",'+
                    '"dpv_vacant":"N","dpv_no_stat":"N","active":"Y"}}]');
        res.setStatusCode(200);
        return res;
    }
}