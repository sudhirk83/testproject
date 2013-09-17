@isTest
private class MessageTest
{
    static testMethod void testMessageInsert()
    {
        List<Map<String,String>> testMap = new List<Map<String,String>>{new Map<String,String>{'Name'=>'testOpp', 'CloseDate' => String.Valueof(Date.newInstance(2010,1,1)), 'Stage' => 'ABC'}, new Map<String,String>{'Name'=>'testOpp2', 'CloseDate' => String.ValueOf(Date.newInstance(2010,1,1)), 'Stage' => 'ABC'}};
        String str = JSON.serialize(testMap);

        String requestString = '{"api":"OpportunityAPI.CreateOpportunity","request":'+str+'}';
        system.debug('***'+requestString);
        Message__c msg = new Message__c(Message__c = requestString);
        insert msg;
        Message__c message = [Select Response__c From Message__c Where id = :msg.Id];
    }
}