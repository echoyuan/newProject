({
    getMemoInfo : function(component, event) {
        var action = component.get("c.getMemoInfo");
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
                if (data.getState() == "SUCCESS") {
                    if (response.code == 0) {
                        component.set("v.memoInfo", response.displayInfo);
                    } else if (response.code == 40) {
                        component.set("v.memoInfo", response.message);
                    }
                } else {
                    component.set("v.errorFlg", true);
                }
        });
        $A.enqueueAction(action);
    }
})