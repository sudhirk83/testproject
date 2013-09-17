trigger Message on Message__c (before Insert) 
{
    for(Message__c message : Trigger.New)
    {
        JSONParser parser = JSON.createParser(message.message__c);
        String apiName;
        List<Map<String, String>> request;
        
        while (parser.nextToken() != null) 
        {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'api')) 
            {
                parser.nextToken();
                apiName = parser.getText();
            }
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'request')) 
                
            {
        	    parser.nextToken();
        	    request = (List<Map<String,String>>)parser.readValueAs(List<Map<String,String>>.class);
        	}
        }
        
        //call api method now
        Type t = Type.forName(apiName);
        
        IMessage classInstance = (IMessage)t.newInstance();
        Map<String, String> result = classInstance.invoke(request);
        String responseString = JSON.serialize(result);
        
        message.response__c = responseString;
    }
}