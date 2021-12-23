public with sharing class SObjectFieldNamesController {
    
    @AuraEnabled(cacheable = true)
        public static List<String> getFieldNames(String objName){
            if(String.isBlank(objName)) {
                return new List<String>();
            }

            Schema.SObjectType objType = Schema.getGlobalDescribe().get(objName);
            Map<String, Schema.SObjectField> mfields = objType.getDescribe().fields.getMap();   
            List<String> fieldschema = new List<String>();

            for(Schema.SObjectField sfield : mfields.Values()) {
                fieldschema.add('' + sfield);
            }
 
            system.debug(fieldschema);
            return fieldschema;
    }

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
}