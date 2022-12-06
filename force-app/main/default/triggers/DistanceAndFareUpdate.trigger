trigger DistanceAndFareUpdate on Booking__c (before insert,after insert,after update) {
if(Trigger.isbefore&&Trigger.isInsert)
{
    Map<id,Booking__c> mapOfBookings = new Map<id,Booking__c>();
for(Booking__c b :trigger.new)
{
    System.debug('b'+b);

    try{
        Double Slog = b.StartLocation__Longitude__S;
        // System.debug('Slog'+Slog);
        //System.debug('loc'+loc);
        
        Double Slat = b.EndLocation__Latitude__S;
        //loc = b.EndLocation__c;
        Double Elog = b.EndLocation__Longitude__S;
        Double Elat = b.EndLocation__Latitude__S;    
        Location locStart =Location.newInstance(slat,slog);
        Location locEnd =Location.newInstance(elat,eLog);
        System.debug('locStart'+locStart);
        System.debug('locEnd'+locEnd);
        Double dist = Location.getDistance(locStart, locEnd,'km');
        System.debug('dist'+dist);
        integer dividedByAvgSpeed=(integer)dist/50;
        integer modValue=Math.mod((integer)dist,50);
    
    // Location loc = b.StartLocation__c;
    // Double Slog = b.StartLocation__Longitude__S;
    // // System.debug('Slog'+Slog);
    // //System.debug('loc'+loc);
    
    // Double Slat = b.EndLocation__Latitude__S;
    // //loc = b.EndLocation__c;
    // Double Elog = b.EndLocation__Longitude__S;
    // Double Elat = b.EndLocation__Latitude__S;    
    // Location locStart =Location.newInstance(slat,slog);
    // Location locEnd =Location.newInstance(elat,eLog);
    // System.debug('locStart'+locStart);
    // System.debug('locEnd'+locEnd);
    // Double dist = Location.getDistance(locStart, locEnd,'km');
    // System.debug('dist'+dist);
    // integer dividedByAvgSpeed=(integer)dist/50;
    // integer modValue=Math.mod((integer)dist,50);
    decimal fare =0;
    //Decimal timeDiff = (b.EndTime__c - b.StartTime__c)/60;
    if(dividedByAvgSpeed !=null ) {
        
        if(dist > 15){
            fare = dividedByAvgSpeed*537;
            if(modValue >15){
                fare = fare +15*1+(modValue-15)*12;
            }
            else{

                fare = fare + modValue*1;
            }
        }else{
            if(modValue >15){
                fare = 15*1+(modValue-15)*12;
            }
            else{

                fare = modValue*1;
            }
        }
    }
    b.DistanceKMs__c = dist;
    b.ExpectedFare__c=fare;
    b.ActualFare__c=fare+fare*0.09;

    mapOfBookings.put(b.Id, b);
    
}
catch(Exception e){
    System.debug('Exception'+e);
}
}
    update mapOfBookings.values();
}




if(Trigger.isAfter&&Trigger.isInsert)
{
    //String Vocher ='';
    BookingTriggerHandler.updateBike(Trigger.new,Trigger.newMap);
    // Map<id,Decimal> mapOfIdAndDistance = new Map<id,Decimal>();
    // for(Booking__c b :trigger.new){
    //     if(b.Customer__c!=null&&b.RideEndTime__c!=null){
    //         mapOfIdAndDistance.put(b.Customer__c,b.DistanceKMs__c);
    //     }
    // }
    // List<Contact> cusList = [select Id,Name,Total_Km_s__c,Earned_Points__c,Numbers_of_Bookings__c,Email from Contact where Id in :mapOfIdAndDistance.keySet()];
    // for(Contact c : cusList){
    //     if(c.numbers_of_bookings__c>8){
    //         c.Total_Km_s__c = mapOfIdAndDistance.get(c.Id);
    //         if(c.Total_Km_s__c>100){
    //             c.Earned_Points__c = 10*0.6+(c.Total_Km_s__c-10)*01.2;
    //         }
    //         else{
    //             c.Earned_Points__c = c.Total_Km_s__c*0.6;
    //         }
        
    //     if(c.Earned_Points__c>90){
    //         Vocher = 'VOGOSUPERRIDE90';
    //     }
    //     else if(c.Earned_Points__c>60 && c.Earned_Points__c<90){
    //         Vocher = 'VOGOSUPERRIDE60';
    //     }
    //     else {
    //         Vocher = 'VOGOSUPERRIDE30';
    //     }
    //     BookingTriggerHandler.sendEmailNotification(cusList, Vocher);
    //     }
        
    // }
    // update cusList;
    

    }
    if(Trigger.isUpdate&& trigger.isAfter){
        String Vocher ='';
    //BookingTriggerHandler.updateBike(Trigger.new,Trigger.newMap);
    Map<id,Decimal> mapOfIdAndDistance = new Map<id,Decimal>();
    for(Booking__c b :trigger.new){
        if(b.Customer__c!=null&&b.RideCompleted__c==true){
            mapOfIdAndDistance.put(b.Customer__c,b.DistanceKMs__c);
        }
    }
    List<Contact> cusList = [select Id,Name,Total_Km_s__c,Earned_Points__c,Numbers_of_Bookings__c,Email from Contact where Id in :mapOfIdAndDistance.keySet()];
    for(Contact c : cusList){
        if(c.numbers_of_bookings__c>8){
            c.Total_Km_s__c = mapOfIdAndDistance.get(c.Id);
            if(c.Total_Km_s__c>100){
                c.Earned_Points__c = 10*0.6+(c.Total_Km_s__c-10)*01.2;
            }
            else{
                c.Earned_Points__c = c.Total_Km_s__c*0.6;
            }
        
        if(c.Earned_Points__c>90){
            Vocher = 'VOGOSUPERRIDE90';
        }
        else if(c.Earned_Points__c>60 && c.Earned_Points__c<90){
            Vocher = 'VOGOSUPERRIDE60';
        }
        else {
            Vocher = 'VOGOSUPERRIDE30';
        }
        BookingTriggerHandler.sendEmailNotification(cusList, Vocher);
        }
        
    }
    try{
        update cusList;
    }Catch (Exception e){
        System.debug('Exception'+e);
    
    }
    }
}