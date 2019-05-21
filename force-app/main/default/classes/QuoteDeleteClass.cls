public class QuoteDeleteClass
{
    @InvocableMethod
    public static void QuoteDelete(List<String> OpportunityIds)
    {
        List<account> Quotes =[select id from account];
        system.debug('Quotes='+Quotes);
        system.debug('OpportunityIds='+OpportunityIds);
   }
}