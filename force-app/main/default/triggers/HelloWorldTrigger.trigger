trigger HelloWorldTrigger on Account(after insert, after update) {
  System.debug('Hello World!');
  System.debug('Operation type updated ' + Trigger.operationType);

  List<Opportunity> oppList = new List<Opportunity>();
  // Get the related opportunities for the accounts in this trigger
  Map<Id, Account> acctsWithOpps = new Map<Id, Account>(
    [
      SELECT Id, (SELECT Id FROM Opportunities)
      FROM Account
      WHERE Id IN :Trigger.new
    ]
  );
  System.debug('Accs with opps ' + acctsWithOpps);
  // Add an opportunity for each account if it doesn't already have one.
  // Iterate through each account.
  for (Account a : Trigger.new) {
    System.debug(
      'acctsWithOpps.get(a.Id).Opportunities.size()=' +
      acctsWithOpps.get(a.Id).Opportunities.size()
    );
    // Check if the account already has a related opportunity.
    if (acctsWithOpps.get(a.Id).Opportunities.size() == 0) {
      // If it doesn't, add a default opportunity
      oppList.add(
        new Opportunity(
          Name = a.Name + ' Opportunity',
          StageName = 'Prospecting',
          CloseDate = System.today().addMonths(1),
          AccountId = a.Id
        )
      );
    }
  }
  if (oppList.size() > 0) {
    insert oppList;
  }
}
