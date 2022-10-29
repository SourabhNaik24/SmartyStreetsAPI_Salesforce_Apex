/*-------------------------------------------------------------------------------------------
Name:       SmartyStreetsJSON.cls
Purpose:    An Apex Class for storing of data from recieved JSON response
------------------------------History--------------------------------------------------------
Version     Author                Date                 Detail Description 
-------     ---------------       --------------       ------------------
1.0         Sourabh Naik          29th Oct 2022        Initial Development 
--------------------------------------------------------------------------------------------*/
public class SmartyStreetsJSON{
    /*
     * Name : Components
     * Return Type : 
     * Parameters : 
     * Description : Wrapper Class for Components
     * */
	public class Components {
		public String primary_number;
		public String street_name;
		public String street_suffix;
		public String city_name;
		public String default_city_name;
		public String state_abbreviation;
		public String zipcode;
		public String plus4_code;
		public String delivery_point;
		public String delivery_point_check_digit;
	}

	public Integer input_index;
	public Integer candidate_index;
	public String delivery_line_1;
	public String last_line;
	public String delivery_point_barcode;
	public Components components;
	public Metadata metadata;
	public Analysis analysis;
	
    /*
     * Name : Analysis
     * Return Type : 
     * Parameters : 
     * Description : Wrapper Class for Analysis
     * */
	public class Analysis {
		public String dpv_match_code;
		public String dpv_footnotes;
		public String dpv_cmra;
		public String dpv_vacant;
		public String dpv_no_stat;
		public String active;
	}
	
    /*
     * Name : Metadata
     * Return Type : 
     * Parameters : 
     * Description : Wrapper Class for Metadata
     * */
	public class Metadata {
		public String record_type;
		public String zip_type;
		public String county_fips;
		public String county_name;
		public String carrier_route;
		public String congressional_district;
		public String rdi;
		public String elot_sequence;
		public String elot_sort;
		public Double latitude;
		public Double longitude;
		public String precision;
		public String time_zone;
		public Integer utc_offset;
		public Boolean dst;
	}

    /*
     * Method Name : parse
     * Return Type : List of SmartyStreetsJSON
     * Parameters : String
     * Description : To deserialize the json response 
     * */
	public static List<SmartyStreetsJSON> parse(String json) {
		return (List<SmartyStreetsJSON>) System.JSON.deserialize(json, List<SmartyStreetsJSON>.class);
	}
}