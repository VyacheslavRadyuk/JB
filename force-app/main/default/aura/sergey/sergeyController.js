({
    init: function(component, event, helper) {
        let action = component.get("c.getObjectName");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {           
                let allValues = response.getReturnValue();
                component.set("v.options", allValues);
            }                    
            else if (state === "ERROR") {
                let errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } 
                else {
                    console.log("Unknown Error");
                }
            }
        });
        $A.enqueueAction(action);
     },

    selectObject: function(component, event, helper) {
        let objectName = component.get('v.selectedValue');
        let action = component.get("c.getObjectByName");
        action.setParams({
            name: objectName
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {           
                let allValues = response.getReturnValue();
                component.set("v.data", allValues);
                console.log(component.get('v.data'));
            }                    
            else if (state === "ERROR") {
                let errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } 
                else {
                    console.log("Unknown Error");
                }
            }
        });
        $A.enqueueAction(action);
    }
})