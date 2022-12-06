public with sharing class CaseLearningTriggerController {
   public static void beforeInsert(List<Case> newCases) {
      for (Case c : newCases) {
         c.Status = 'New';
         c.Priority = 'Medium';
      }   
   }
   public static void afterInsert(List<Case> newCases) {
    Set<id> ids = new Set<id>();
      for (Case c : newCases) {
        ids.add(c.ContactId);
      }   
        List<Contact> contacts = [SELECT Id, Name, Email,Has_Case__c FROM Contact WHERE Id IN :ids];
        for(Contact con : contacts){
            if(con.Has_Case__c == false){
                con.Has_Case__c = true;
            }
           
        }
        update contacts;
   }
   public static void afterUpdate(List<Case> newCases, Map<Id, Case> oldCases) {
     Set<id> ids = new Set<id>();
      for (Case c : newCases) {
        if(c.Status == 'Completed' && oldCases.get(c.Id).Status != 'Completed'){
           ids.add(c.ContactId);
        }
      }  
      //AggregateResult[] results = [SELECT ContactId, COUNT(Id) FROM Case WHERE ContactId IN :ids AND Status != 'Completed' GROUP BY ContactId];
        List<Case> leftCases = [SELECT ContactId FROM Case WHERE ContactId IN :ids AND Status != 'completed']; 
       List<Contact> contacts = new List<Contact>();
       Set<id> leftids = new Set<id>();
       for(Case c : leftCases){
           leftids.add(c.ContactId);
       }
       for(Id id1:ids){
        if(!leftids.contains(id1)){
            Contact con = new Contact(id=id1,Has_Case__c=false);
            contacts.add(con);
        }
       }
      update contacts;
     }
    
}