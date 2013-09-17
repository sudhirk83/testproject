public class API1 implements IMessage
{
    public Map<String, String> invoke(Map<String, String> request)
    {
    	return null;
    }
     
    public Map<String, String> invoke(List<Map<String, String>> request)
    {
    	return null;
    }
    
    public List<Account> getAccounts(Set<Id> invoiceIds)
    {
        return [Select id, Name, BillingState, BillingCountry, BillingCity, AccountNumber From Account Where Id IN :invoiceIds];
    }
    
    public Set<Id> insertAccounts(List<String> accountNames)
    {
        List<Account> accounts = new List<Account>();
        for(String accName : accountNames)
        {
            accounts.add(new Account(Name = accName));
        }
        insert accounts;
        
        Set<Id> accountIds = new Set<Id>();
        for(Account acc : accounts)
            accountIds.add(acc.id);
        
        return accountIds;
    }
}