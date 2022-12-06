public with sharing class GetAccountAndContactInfo {
   @AuraEnabled(cacheable=true)
   public static List<WrapperForAccountAndContact> getData(){
    
    List<WrapperForAccountAndContact> infoList = new List<WrapperForAccountAndContact>();
    List<Account> accounts = [SELECT Id, Name, Phone, Website, BillingCity, BillingState, BillingCountry FROM Account limit 10];
    //System.debug('accounts: ' + accounts);
    List<Contact> contacts = [SELECT Id, Name, Phone, Email, AccountId FROM Contact limit 10];
   // System.debug('contacts: ' + contacts);
    for (Integer i = 0; i < accounts.size()-1; i++) {
        WrapperForAccountAndContact info = new WrapperForAccountAndContact();
        info.accountName = accounts[i].Name;
        info.billingCity = accounts[i].BillingCity;
        info.billingState = accounts[i].BillingState;
        info.email = contacts[i].Email;
        info.contactName = contacts[i].Name;
        info.Lurl = '/'+accounts[i].Id;
        //System.debug(info);
        infoList.add(info);
    }
//     for(WrapperForAccountAndContact w : infoList){
//         System.debug(w);
//     }
//     System.debug('infoList: ' +JSON.serialize(infoList) );
//    // return JSON.serialize(infoList)  ;
   return infoList;
   }
}