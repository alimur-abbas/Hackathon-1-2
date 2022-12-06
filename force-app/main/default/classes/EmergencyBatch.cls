public with sharing class EmergencyBatch implements Database.Batchable<SObject>, Database.Stateful {
    public DateTime dateOfSunday = Date.today();
    DateTime sunday = date.today();
    // for(int i=0;i<7;i++){
    //     date.addDays(i);
    //     if(date.getDayOfWeek() == 0 ){
    //         break;
    //     }
    // }
    public Database.QueryLocator start(Database.BatchableContext bc) {
        for(integer i=0;i<7;i++){
           sunday= dateOfSunday.addDays(i);
            if(sunday.format('E') == 'Sun' ){
                break;
            }
        }
        System.debug('dateOfSunday'+dateOfSunday);
        return Database.getQueryLocator('Select id ,name,RideStartTime__c,RideEndTime__c from Booking__c '
        +'where RideStartTime__c>=tomorrow And RideEndTime__c<=:Sunday');
    }
    public void execute(Database.BatchableContext bc , List<Booking__c> scope) {
        System.debug('scope:'+scope);
        List<Booking__c> bookingList = new List<Booking__c>();
        for(Booking__c b : scope){
            try{
                DateTime start=b.RideStartTime__c.addDays(7);
                b.RideStartTime__c =start;
                DateTime endD=b.RideEndTime__c.addDays(7);
                b.RideEndTime__c =endD;
                bookingList.add(b);
            }Catch(Exception e){
                System.debug('Exception'+e);
            }
            // DateTime start=b.RideStartTime__c.addDays(7);
            // b.RideStartTime__c =start;
            // DateTime endD=b.RideEndTime__c.addDays(7);
            // b.RideEndTime__c =endD;
            // bookingList.add(b);
        }
        update bookingList;
    }
    public void finish(Database.BatchableContext bc) {
        System.debug('Batch completed');
    }
}