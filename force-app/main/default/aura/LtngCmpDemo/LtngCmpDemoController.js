({
	init : function(component, event, helper) {
        var gotoRecordViewURL = helper.gotoRecordViewURL.bind(this, component);
		var tableColumn = [{ label: 'Name', fieldName: 'Name', type: 'text', sortable: true },
    	    { label: 'Amount', fieldName: 'Amount', type: 'currency', typeAttributes: { currencyCode: 'CNY'}, sortable: true },
    	    { label: 'Close Date', fieldName: 'CloseDate', type: 'date', cellAttributes: { iconName: 'utility:event' }, sortable: true },
    	    { label: 'Stage', fieldName: 'StageName', type: 'text', cellAttributes: { class: 'text-icon-acc roundedSquare forceEntityIcon uiImage' }, sortable: true },
    	    { label: 'Stage1', fieldName: 'StageName1', type: 'text', cellAttributes: { iconName: { fieldName: 'statusIconImage' }}, sortable: true },
    	    { label: 'Status', type: 'text', cellAttributes: { iconName: { fieldName: 'StatusIcon' } }, sortable: true },
            { label: 'Statusxx', fieldName: 'Statusxx', type: 'text', cellAttributes: { class: { fieldName: 'testClass' } }, sortable: true },
            { label: '氏名(カナ)', fieldName: 'name_link__c', type: 'url', data_target:'Id', sortable: true, typeAttributes: {label: { fieldName: 'Name'}}},
            {label: 'Action', type: 'button', initialWidth: 150, typeAttributes:
                { label: { fieldName: 'actionLabel'}, name: 'edit_status', class: 'btn_next',iconName: 'utility:edit'}},
            ];
    	component.set("v.tableColumn", tableColumn);
                           var tableData = [{ 'Name': 'test1', 'Amount': 1111, 'CloseDate': '2018/11/11', 'StageName': 'Qualified','id': '12314564', 'StageName1': 'Qualified', 'StatusIcon': 'action:close', 'statusIconImage': 'text-icon-acc roundedSquare forceEntityIcon uiImage','testClass':'text-icon-acc  roundedSquare forceEntityIcon uiImage','Statusxx':'Quote','actionLabel':'actionLabel','recordId':'0016F00002pB8BTQA0'}, 
                         { 'Name': 'test2', 'Amount': 2222, 'CloseDate': '2018/12/12', 'StageName': 'Quote','StageName1': 'Quote', 'StatusIcon': 'action:following', 'statusIconImage': 'text-icon-noacc roundedSquare forceEntityIcon uiImage','testClass':'text-icon-noacc  roundedSquare forceEntityIcon uiImage','Statusxx':'Qualified','actionLabel':'actionLabel','recordId':'0016F00002pB8BTQA0'}];
	    component.set("v.tableData", tableData);
	},
    getOpenedTabInfo :function(component, event, helper){
        debugger;
        var workspaceAPI = component.find("workspace");
        workspaceAPI.openTab({
            //recordId: '001xx000003DIkeAAG',
            url:'/lightning/r/Project__c/a056F00000nRSfXQAW/view',
            focus: true
        }).then(function(response) {
            debugger;
            workspaceAPI.focusTab({tabId : response});
       })
        .catch(function(error) {
            debugger;
            console.log(error);
        });
    },
    handleRowAction: function (cmp, event, helper) {
        debugger;
        var action = event.getParam('action');
         var row = event.getParam('row');
        switch (action.name) {
            case 'edit_status':
                helper.gotoRecordViewURL(row,cmp, event);
                break;
            //case 'edit_status':
            //    helper.editRowStatus(cmp, row, action);
            //    break;
            //default:
            //    helper.showRowDetails(row);
            //    break;
        }
    },
    // 参照画面に遷移する
    gotoRecordViewURL : function (component, event) {
        var navEvt = $A.get("e.force:navigateToSObject");
        var recordId = component.get("v.recordInfo.Id");
        navEvt.setParams({
            recordId : '0016F00002pB8BTQA0'
        });
        navEvt.fire();
    }
})