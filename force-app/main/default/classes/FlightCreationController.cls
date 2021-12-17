public with sharing class FlightCreationController {
    public class CreateFlightException extends Exception {}
    public static final String FLIGHT_CREATION_EMPTY_NAME_ERROR = 'Fill in flight name';

    @AuraEnabled(cacheable=true)
    public static List<Countries__mdt> getCountries() {
        List<Countries__mdt> countries = [  SELECT Label 
                                    FROM Countries__mdt ];

        return countries;
    }

    @AuraEnabled(cacheable=true)
    public static List<Trip__c> getTripsByCountryName(String countryName) {
        if(String.isBlank(countryName)) {
            return new List<Trip__c>();
        }

        List<Trip__c> trips = new List<Trip__c>();

        if (countryName == 'Belarus') {
            trips = [   SELECT Name 
                        FROM Trip__c 
                        WHERE Name = 'Grodno' 
                        OR Name = 'Minsk'];
        } else if (countryName == 'Russia') {
            trips = [   SELECT Name 
                        FROM Trip__c 
                        WHERE Name = 'Moskow' 
                        OR Name = 'Smolensk'];
        }

        return trips;
    }

    @AuraEnabled
    public static void createFlightByTouristAndTripIds(Id touristId, Id tripId, String name) {
        if(String.isBlank(name)) {
            throw new CreateFlightException(FLIGHT_CREATION_EMPTY_NAME_ERROR);
        }

        Flight__c flightToInsert = new Flight__c(
            Name = name,
            Tourist__c = touristId,
            Trip__c = tripId
        );

        insert flightToInsert;
    }
}