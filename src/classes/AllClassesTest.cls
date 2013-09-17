@isTest
private class AllClassesTest
{
    private static testMethod void testRestService1()
    {
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
       
        req.requestURI = 'https://ap1.salesforce.com/services/apexrest/RestPOC';  
        req.httpMethod = 'GET';
        req.addParameter('api','OpportunityAPI.CreateOpportunity');
        
        List<Map<String,Object>> testMap = new List<Map<String,Object>>{new Map<String,Object>{'Name'=>'testOpp', 'CloseDate' => (Date)Date.newInstance(2010,1,1), 'Stage' => 'ABC'}, new Map<String,Object>{'Name'=>'testOpp2', 'CloseDate' => (Date)Date.newInstance(2010,1,1), 'Stage' => 'ABC'}};
        req.addParameter('request',JSON.serialize(testMap));
        
        RestContext.request = req;
    
        RestService.doGet();
    }
    
    private static testMethod void testRestService2()
    {
        RestRequest req = new RestRequest(); 
        
        req.requestURI = 'https://ap1.salesforce.com/services/apexrest/RestPOC?api=OpportunityAPI.UpdateOpportunity&method=getAccounts&paramJson=["0019000000EGiwE"]';  
        req.httpMethod = 'GET';
        req.addParameter('api','api111');
        List<Map<String,String>> testMap = new List<Map<String,String>>{new Map<String,String>{'Name'=>'testOpp', 'CloseDate' => String.Valueof(Date.newInstance(2010,1,1)), 'Stage' => 'ABC'}, new Map<String,String>{'Name'=>'testOpp2', 'CloseDate' => String.ValueOf(Date.newInstance(2010,1,1)), 'Stage' => 'ABC'}};
        req.addParameter('request',JSON.serialize(testMap));
        RestContext.request = req;
        try
        {
            RestService.doGet();
        }
        catch(ClassNotFoundException e){}
    }
    
    private static testMethod void testOpportunityAPI()
    {
        List<Map<String,String>> testMap = new List<Map<String,String>>{new Map<String,String>{'Name'=>'testOpp', 'CloseDate' => String.Valueof(Date.newInstance(2010,1,1)), 'Stage' => 'ABC'}, new Map<String,String>{'Name'=>'testOpp2', 'CloseDate' => String.ValueOf(Date.newInstance(2010,1,1)), 'Stage' => 'ABC'}};
        OpportunityAPI app = new OpportunityAPI();
        OpportunityAPI.CreateOpportunity api1 = new OpportunityAPI.CreateOpportunity();
        Map<String, String> result = api1.invoke(testMap);
        
        Opportunity opp = new Opportunity(Name='testOpp', CloseDate = Date.newInstance(2010,1,1), StageName = 'ABC');
        insert opp;
        testMap = new List<Map<String,String>>{new Map<String,String>{'Id' => opp.Id, 'Name'=>'testOpp', 'CloseDate' => String.Valueof(Date.newInstance(2010,1,1))}};
        OpportunityAPI.UpdateOpportunity api2 = new OpportunityAPI.UpdateOpportunity();
        api2.invoke(testMap);
    }
}