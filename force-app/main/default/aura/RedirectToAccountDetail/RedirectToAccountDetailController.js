({
    doInit : function(component, event, helper) {
        //ガスメーター設置場所番号(1x)
        var meter = component.get("v.meter");
        //お客さま番号(3x)
        var customer = component.get("v.customer");
        //ガス使用契約番号(4x)
        var gascontract = component.get("v.gascontract");
        var reg = /^\d{11}$/;
        
        if (!meter && !customer && !gascontract) {
            //helper.gotoURL(false, true, 'パラメータが不正なためエラーが発生しました。');
            component.set("v.infoFlg", true);
            component.set("v.infoMsg", 'パラメータが不正なためエラーが発生しました。');
        } else {
            if ((meter && !reg.test(meter))
                || (customer && !reg.test(customer))
                || (gascontract && !reg.test(gascontract))) {
                component.set("v.infoFlg", true);
            	component.set("v.infoMsg", 'パラメータが不正なためエラーが発生しました。');
                //helper.gotoURL(false, true, 'パラメータが不正なためエラーが発生しました。');
            } else {
                helper.getAccountInfo(component, event);
            }
        }
    },
    goAccountSearch : function(component, event, helper) {
        debugger;
        var url = "/lightning/n/Tab";
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/lightning/n/Tab"
        });
        urlEvent.fire();
         //window.open(url, '_self','');
    }
})