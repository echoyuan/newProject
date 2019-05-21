({
    createAccount : function(component, event, helper) {
        var createAccountEvent = $A.get("e.force:createRecord");
        createAccountEvent.setParams({
            "entityApiName": "Account"
        });
        createAccountEvent.fire();
    }
})