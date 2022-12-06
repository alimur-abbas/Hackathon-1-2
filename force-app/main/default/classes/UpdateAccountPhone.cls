public with sharing class UpdateAccountPhone {
    public void updateAccount(){
        List<Account> accounts = [SELECT Id, Phone FROM Account Limit 5];
        System.debug('accounts: ' + accounts);
         for (Account a : accounts) {
             a.Phone = '1234567897';
         }
         System.debug(' After accounts: ' + accounts);
         update accounts;
    }
  
}