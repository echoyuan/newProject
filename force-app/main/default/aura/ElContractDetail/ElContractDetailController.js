({
    init : function(component, event, helper) {
        component.set("v.elContract",null);
    },
    elPopClose: function(component, event, helper) {
        component.find("overlayLib").notifyClose();
    }
})