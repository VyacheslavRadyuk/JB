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
        String query = 'Select Id, Name FROM ' + name;
        List<SObject> records = Database.query(query);

        return records;                         
    }

    @AuraEnabled
    public static void deleteRecord(Id recordToDeleteId, String name){
        String query = 'Select Id, Name FROM ' + name + ' Where Id = \'' + recordToDeleteId + '\'' + ' limit 1';
        SObject recordToDelete = Database.query(query); 
        delete recordToDelete;              
    }
}