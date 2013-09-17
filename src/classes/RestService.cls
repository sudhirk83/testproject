@RestResource(urlMapping='/RestPOC/*') 
global with sharing class RestService 
{ 
    @HttpGet
    global static String doGet() 
    {
        RestRequest req = RestContext.request;
        
        String apiName = req.params.get('api');
        Type t = Type.forName(apiName );
        if(t == null)
        {
            throw new classNotFoundException('Class not found');
        }
        IMessage classInstance = (IMessage)t.newInstance();
        
        String requestString = req.params.get('request');
        List<Map<String, String>> request = (List<Map<String, String>>)JSON.deserialize(requestString, List<Map<String, String>>.Class);
        
        Map<String, String> result = classInstance.invoke(request);
        String jsonString = JSON.serialize(result);
        String responseString = '{"result":'+jsonString+',"limitsJsonAfter" : {'+ getLimits() +'}';
        return responseString ;
    }
    
    public static String getLimits()
    {
        String jsonString = '';
        jsonString += '"SOQlQueries" : "'+Limits.getQueries()+'",';
        jsonString += '"QueryRows" : "'+Limits.getQueryRows()+'",';
        jsonString += '"SoslQueries" : "'+Limits.getSoslQueries()+'",';
        jsonString += '"DMLStatements" : "'+Limits.getDMLStatements()+'",';
        jsonString += '"DMLRows" : "'+Limits.getDMLRows()+'",';
        jsonString += '"getScriptStatements" : "'+Limits.getScriptStatements()+'",';
        jsonString += '"HeapSize" : "'+Limits.getHeapSize()+'",';
        jsonString += '"Callouts" : "'+Limits.getCallouts()+'",';
        jsonString += '"EmailInvocations" : "'+Limits.getEmailInvocations()+'",';
        jsonString += '"FieldsDescribes" : "'+Limits.getFieldsDescribes()+'",';
        jsonString += '"RecordTypesDescribes" : "'+Limits.getRecordTypesDescribes()+'",';
        jsonString += '"ChildRelationshipsDescribes" : "'+Limits.getChildRelationshipsDescribes()+'",';
        jsonString += '"PicklistDescribes" : "'+Limits.getPicklistDescribes()+'",';
        jsonString += '"FutureCalls" : "'+Limits.getFutureCalls()+'"';
        jsonString += '}';
        return jsonString;
    } 
}