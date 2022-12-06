public with sharing class BookingTriggerHandler {
    public static void updateBike(List<Booking__c> bookingsFromNew,Map<id,Booking__c> bookingMaps){
        Map<id,Booking__c> mapOfBookings = new Map<id,Booking__c>();
        List<Booking__c> bookings =[SELECT ID,DistanceKMs__c FROM Booking__c WHERE ID IN :trigger.new AND RecordType.name = 'Personal'];
        for(Booking__c b : bookings)
        {
            // if(b.DistanceKMs__c>75){
            // Booking__c booking = bookingMaps.get(b.Id);
            // booking.addError('You cannot insert  when Distance is more than 75 kms');
            // }
            }
    
            
            for(Booking__c b :bookingsFromNew){
            //bikeIds.add(b.Bike__c);
            mapOfBookings.put(b.Bike__c, b);
            }
            System.debug('mapOfBookings'+mapOfBookings);
            List<Bike__c> bikes = [SELECT ID FROM Bike__c  where id in :mapOfBookings.keySet()];
            for(Bike__c bike : bikes){
            
            bike.Hub__c = mapOfBookings.get(bike.Id).EndHub__c;
            }
            update bikes;
            }


            public static void sendEmailNotification(List<Contact> customerList, String Vocher) {
                List<Messaging.Email> emailList = new List<Messaging.Email>();
                for (Contact con : customerList) {
                    if(con.Email!=null)
                    {Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    String[] toAddresses = new String[] { con.Email };
                    email.setToAddresses(toAddresses);
                    email.setSubject('Wooh! The ride has been Completed.');                    
                    String body = 'Hi ' + con.Name + ',<br/><br/>' + 'Thank you for using vogo ride,. <br/><br/>' + 'Earned Points:-'+con.Earned_Points__c+'<br/>'
                     + 'Use the code'+vocher+' For your next ride.'+'<br/><br/>' + 'Thank You,<br/>' + 'Vogo Team';
                     
                   email.setHtmlBody(body);
                   // email.setSenderDisplayName(con.owner.name);
                    emailList.add(email);
                    }
                }
                Messaging.sendEmail(emailList);
            }
    }