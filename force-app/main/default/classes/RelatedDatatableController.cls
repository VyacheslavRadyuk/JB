public with sharing class RelatedDatatableController {

    @AuraEnabled(cacheable=true)
    public static List<RelatedObjectsWrapper2> getTouristsByTrip(Id selectedId) {
        List<Tourist__c> tourists = [
            SELECT Name, (SELECT Name, Trip__r.Name FROM Flights__r WHERE Trip__c != null) FROM Tourist__c WHERE Id =: selectedId
        ];

        List<RelatedObjectsWrapper2> lstObjectWrapper = new List<RelatedObjectsWrapper2>();

        for (Tourist__c tourist : tourists) {

            for (Flight__c flight : tourist.Flights__r) {
                RelatedObjectsWrapper2 wrapperObj = new RelatedObjectsWrapper2();
                wrapperObj.touristName = tourist.Name;
                wrapperObj.tripName = flight.Trip__r.Name;
                wrapperObj.flightName = flight.Name;
                lstObjectWrapper.add(wrapperObj);
            }     
        }
        return lstObjectWrapper;
    }

    public class RelatedObjectsWrapper2 {
        @AuraEnabled public String flightName;
        @AuraEnabled public String touristName;   
        @AuraEnabled public String tripName;      
    }
}