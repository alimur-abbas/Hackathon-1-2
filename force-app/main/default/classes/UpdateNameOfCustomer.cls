public with sharing class UpdateNameOfCustomer implements Database.Batchable<SObject>, Database.Stateful {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String test ='%test%';
        return Database.getQueryLocator('SELECT Id, Name FROM Contact where Name like :test');
    }
    public void execute(Database.BatchableContext bc, List<Contact> scope) {
        for (Contact c : scope) {
            c.LastName = 'updatedByBatch';
           
        }
        System.debug('scope size: ' + scope.size());
        update scope;
    }
    public void finish(Database.BatchableContext bc) {
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         mail.setToAddresses(new String[] {'iamkalam17@gmail.com'});
         mail.setSubject('Batch Job Completed');
         String body ='Hi'+ UserInfo.getName()+' ,<br/>'+'Batch Job Completed';
         mail.setHtmlBody(body);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
            System.debug('Email sent');

    }
    
}