({
	
    // 参照画面に遷移する
    gotoRecordViewURL : function (row,component, event) {
        var navEvt = $A.get("e.force:navigateToSObject");
        var recordId = row.recordId;
        navEvt.setParams({
            recordId : recordId
        });
        navEvt.fire();
    }
})