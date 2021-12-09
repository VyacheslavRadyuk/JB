public class PrivateObjectTriggerHandler {
    public static void onAfterInsert(List<PrivateObject__c> privateObjects) {
        List<PrivateObject__c> privateObjectsToInsert = new List<PrivateObject__c>();
        List<PrivateObject__Share> jobShares  = new List<PrivateObject__Share>();
        User newOwner = [SELECT Id FROM USER WHERE Name = 'Nushi Davoud'][0];
        User oldOwner = [SELECT Id FROM USER WHERE Name = 'Vyacheslav Radyuk' LIMIT 1];
        
        for(PrivateObject__c privateObject : privateObjects) {
            privateObjectsToInsert.add(new PrivateObject__c(Id = privateObject.Id, OwnerId = newOwner.Id));
            
            PrivateObject__Share jobShr  = new PrivateObject__Share();
            jobShr.ParentId = privateObject.Id;
            jobShr.UserOrGroupId = oldOwner.Id;
            jobShr.AccessLevel = 'edit';
            jobShr.RowCause = Schema.PrivateObject__Share.RowCause.Manual;
            jobShares.add(jobShr);            
        }
        update privateObjectsToInsert;
        insert jobShares;
    }
}