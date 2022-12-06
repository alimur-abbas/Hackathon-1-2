@isTest
public with sharing class EmergencyBatchTest {
  public static Boolean error1 = false;
   @TestSetup
   static void makeData(){
    List<Booking__c> bookings = new List<Booking__c>();
    Contact con = new Contact( LastName = 'Test',LicenseNo__c='1234567890',Numbers_of_Bookings__c=15,Phone='1234567890');
    try{
        insert con;
    }catch(Exception e){
        error1 = true;
    }
    //System.assert(error1,'Contact should not be inserted');
   // insert con;
    Bike__c bike = new Bike__c(VehicleNo__c='1234567890');
    insert bike;
    for(Integer i =0; i<100; i++){
       Booking__c book = new Booking__c(Customer__c=con.id,Bike__c=bike.id,RideStartTime__c=System.today()+1,StartLocation__Longitude__S=10,EndLocation__Latitude__S=10,EndLocation__Longitude__S=10,StartLocation__Latitude__S=10);
         bookings.add(book);
    }
    if(bookings.size()>0){
       insert bookings;
    }
    
    
   }
   @isTest
    static void testBatch(){
        List<Booking__c> bookings = [SELECT Id,RideStartTime__c,RideEndTime__c FROM Booking__c];
     Test.startTest();
     EmergencyBatch batch = new EmergencyBatch();
     System.debug(batch);
     Database.executeBatch(batch);
     Test.stopTest();
    //  for(Booking__c book : bookings){
    //     System.assertEquals(System.today()+7,book.RideStartTime__c);
    //     System.assertEquals(System.today()+8,book.RideEndTime__c);
    //  }
     
    }
    @isTest
    static void testAfterUpdate(){
        List<Booking__c> bookings = [SELECT Id,RideCompleted__c,RideStartTime__c,RideEndTime__c FROM Booking__c];
        for(Booking__c book : bookings){
            book.RideCompleted__c = true;
        }
        test.startTest();
        update bookings;
        Test.stopTest();
    }
}