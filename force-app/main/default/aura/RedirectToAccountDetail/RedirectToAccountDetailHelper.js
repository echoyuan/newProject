({
    getAccountInfo  : function(component, event) {
        // Apex
        var action = component.get("c.getAccountInfo");
        var gascontract = component.get("v.gascontract");
        var customer = component.get("v.customer");
        var meter = component.get("v.meter");
        action.setParams({
            "gascontract": gascontract,
            "customer": customer,
            "meter": meter
        });
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                if (response.code == 0) {
                    var accountInfo = response.displayInfo;
                    this.gotoRecordViewURL(component, accountInfo.Id);
                } else if (response.code == 40) {
                    component.set("v.infoFlg", true);
                    component.set("v.infoMsg", response.message);
                    component.set("v.showButtonFlg", true);
                    
                }
            } else {
                component.set("v.errorFlg", true);
            }
        });
        $A.enqueueAction(action);
    },
    // 参照画面に遷移する
    /*gotoRecordViewURL : function (component, recordId) {
        window.open("/" + recordId, '_self','');
    }*/
    // 参照画面に遷移する
    gotoRecordViewURL : function (component, recordId) {
        var gascontract = component.get("v.gascontract");
        var customer = component.get("v.customer");
        var meter = component.get("v.meter");
        var paramUrl = '?';
        if (!$A.util.isEmpty(meter) ) {
            paramUrl = paramUrl + 'meter=' + meter + '&';
        }
        if (!$A.util.isEmpty(customer) ) {
            paramUrl = paramUrl + 'customer=' + customer + '&';
        }
        if (!$A.util.isEmpty(gascontract) ) {
            paramUrl = paramUrl + 'gascontract=' + gascontract + '&';
        }
        //var url = "/lightning/r/Account/" + recordId + "/view?meter=" + meter
        //	+ "&customer=" + customer +"&gascontract=" + gascontract;
        var url = "/lightning/r/Account/" + recordId + "/view";
        if (paramUrl.length > 1) {
            url = url + paramUrl.substring(0, paramUrl.length - 1);
        }
        window.open(url, '_self','');
    },
    gotoURL : function (errorFlg, infoFlg, infoMsg) {
    	var paramUrl = '?errorFlg=' + errorFlg + '&infoFlg=' + infoFlg + '&infoMsg=' + infoMsg;
        var url = "/lightning/n/redirectToAccountDetailError" + paramUrl;
        window.open(url, '_self','');
    }
})