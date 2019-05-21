({
    init : function(component, event, helper) {
        //契約お客さま情報API
        helper.getElectricityAccountInfo(component, event);
        //契約情報API、ガス関連番号API
        helper.getSyncContractInfo(component, event);
        //契約支払者情報API
        helper.getElectricityPaymentInfo(component, event);
        //期間限定割情報API
        helper.getElectricityTermLimitedInfo(component, event);
        //指図情報API
        helper.getElectricityOperationOrderInfo(component, event);
        
    },
    // ポップアップ画面閉じる処理
    popClose: function(component, event, helper) {
        component.set("v.isElcDetailOpen", false);
    }
})