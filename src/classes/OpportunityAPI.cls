/**
    This API creates the Opportunity
**/
public class OpportunityAPI 
{
    static final Map<String, String> nameVsAPIName;
    
    static
    {
        nameVsAPIName = new Map<String, String>{
                                                'Name'=>'Name', 
                                                'Stage'=>'StageName',
                                                'AccountId' => 'AccountId', 
                                                'CloseDate' => 'CloseDate',
                                                'Description' => 'Description',
                                                'Type' => 'Type',
                                                'Quantity' => 'TotalOpportunityQuantity',
                                                'Amount' => 'Amount',
                                                'ExpectedRevenue' => 'ExpectedRevenue',
                                                'ForecastCategory' => 'ForecastCategoryName',
                                                'LeadSource' => 'LeadSource',
                                                'NextStep' => 'NextStep',
                                                'IsPrivate' => 'IsPrivate',
                                                'CurrentGenerators' => 'CurrentGenerators__c',
                                                'DeliveryInstallationStatus' => 'DeliveryInstallationStatus__c',
                                                'MainCompetitors' => 'MainCompetitors__c',
                                                'OrderNumber' => 'OrderNumber__c',
                                                'TrackingNumber' => 'TrackingNumber__c'
                                            };
    }   
     
    public class CreateOpportunity implements IMessage
    {
        public Map<String, String> invoke(List<Map<String, String>> requests)
        {
            Map<String, String> result = new Map<String, String>();
            
            try
            {
                List<Opportunity> opportunities = new List<Opportunity>();
                
                for(Map<String, String> request : requests)
                {
                    Opportunity opp = new Opportunity();
                     
                    if(request.containsKey('Name')) opp.Name = request.get('Name');
                    if(request.containsKey('AccountId')) opp.AccountId = request.get('AccountId');
                    if(request.containsKey('Stage')) opp.StageName = request.get('Stage');
                    if(request.containsKey('CloseDate')) opp.CloseDate = date.valueOf(request.get('CloseDate'));
                    if(request.containsKey('Description')) opp.Description = request.get('Description');
                    if(request.containsKey('Type')) opp.Type = request.get('Type');
                    if(request.containsKey('Quantity')) opp.TotalOpportunityQuantity = Decimal.ValueOf(request.get('Quantity'));
                    if(request.containsKey('Amount')) opp.Amount = Decimal.ValueOf(request.get('Amount'));
                    if(request.containsKey('ForecastCategory')) opp.ForecastCategoryName = request.get('ForecastCategory');
                    if(request.containsKey('LeadSource')) opp.LeadSource = request.get('LeadSource');
                    if(request.containsKey('NextStep')) opp.NextStep = request.get('NextStep');
                    if(request.containsKey('IsPrivate')) opp.IsPrivate = Boolean.ValueOf(request.get('IsPrivate'));
                    if(request.containsKey('CurrentGenerators')) opp.CurrentGenerators__c = request.get('CurrentGenerators');
                    if(request.containsKey('DeliveryInstallationStatus')) opp.DeliveryInstallationStatus__c = request.get('DeliveryInstallationStatus');
                    if(request.containsKey('MainCompetitors')) opp.MainCompetitors__c = request.get('MainCompetitors');
                    if(request.containsKey('OrderNumber')) opp.OrderNumber__c = request.get('OrderNumber');
                    if(request.containsKey('TrackingNumber')) opp.TrackingNumber__c = request.get('TrackingNumber');
                    opportunities.add(opp);
                }
                
                insert opportunities;
                
                List<Id> oppIds = new List<Id>();
                for(Opportunity opp : opportunities)
                    oppIds.add(opp.Id);
                    
                result.put('Ids' , JSON.serialize(oppIds));
                result.put('Status' , 'Success');
            }
            catch(Exception e)
            {
                result.put('Status' , 'Failure');
                result.put('Error',e.getMessage());
            }
            return result;
        }
    }
    
    public class UpdateOpportunity implements IMessage
    {
        public Map<String, String> invoke(List<Map<String, String>> requests)
        {
            Map<String, String> result = new Map<String, String>();
            
            try
            {
                List<Opportunity> opportunities = new List<Opportunity>();
                
                for(Map<String, String> request : requests)
                {
                    Opportunity opp = new Opportunity(Id = request.get('Id'));
                    if(request.containsKey('Name')) opp.Name = request.get('Name');
                    if(request.containsKey('AccountId')) opp.AccountId = request.get('AccountId');
                    if(request.containsKey('Stage')) opp.StageName = request.get('Stage');
                    if(request.containsKey('CloseDate')) opp.CloseDate = date.valueOf(request.get('CloseDate'));
                    
                    opportunities.add(opp);
                }
                update opportunities;
                
                result.put('Status' , 'Success');
            }
            catch(Exception e)
            {
                result.put('Status' , 'Failure');
                result.put('Error',e.getMessage());
            }
            return result;
        }
    }
}