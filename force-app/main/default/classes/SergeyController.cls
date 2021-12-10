public class SergeyController {

    @AuraEnabled(cacheable = true)
        public static List<String> getObjectName(){
            List<String> objects = new List<String>();
            List<Schema.SObjectType> allObjectTypes = Schema.getGlobalDescribe().Values(); 

            for(SObjectType objectType : allObjectTypes){
               objects.add(objectType.getDescribe().getName());
               objects.sort();  
            }

            return objects;
    }

    @AuraEnabled(cacheable = true)
    public static List<SObject> getObjectByName(String name){
        system.debug(name);
        String query = 'Select Id, Name FROM ' + name;
        system.debug(query);
        List<SObject> records = Database.query(query);
        system.debug(records);

        return records;                         
    }
}