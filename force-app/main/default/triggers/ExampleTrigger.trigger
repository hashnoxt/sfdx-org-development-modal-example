trigger ExampleTrigger on Contact(after insert, after delete) {
  if (Trigger.isInsert) {
    Integer recordCount = Trigger.new.size();
    // Call a utility method from another class
    System.debug('Redord count ' + recordCount);
    EmailManager.sendMail(
      'hashannalaka0123@gmail.com',
      'Trailhead Trigger Tutorial',
      recordCount + ' contact(s) were inserted.'
    );
  } else if (Trigger.isDelete) {
    // Process after delete
  }
}
