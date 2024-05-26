trigger HelloWorldTrigger on Account(before insert) {
  System.debug('Hello World!');
  System.debug('Operation type updated ' + Trigger.operationType);

  for (Account a : Trigger.new) {
    a.Description = 'New description';
  }
}
