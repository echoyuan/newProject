({
    openTab : function(component, event, helper) {
        var workspaceAPI = component.find("workspace");
        debugger;
        workspaceAPI.openTab({
            url: '/lightning/o/Account/list?filterName=Recent',
            focus: true
        }).then(function(response) {
            workspaceAPI.getTabInfo({
                tabId: response
            }).then(function(tabInfo) {
            console.log("The recordId for this tab is: " + tabInfo.recordId);
            });
        }).catch(function(error) {
                console.log(error);
        });
    }
})