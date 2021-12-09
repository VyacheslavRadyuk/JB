trigger PrivateObjectTrigger on PrivateObject__c (before insert, after insert) {
    switch on Trigger.operationtype {
        when AFTER_INSERT {
            PrivateObjectTriggerHandler.onAfterInsert(Trigger.new); 
        }
    }
}