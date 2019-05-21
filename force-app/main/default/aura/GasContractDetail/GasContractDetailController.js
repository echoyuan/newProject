({
    init : function(component, event, helper) {
        //ガス契約情報API、支払情報API、お客さま情報API、ガスメータ設置場所情報API
        helper.getSyncGasContractInfo(component, event);
        //電気料金合算パターン情報API
        helper.getGasElectricAddInfo(component, event);
        //お客さま情報API
        helper.getGasAccountInfo(component, event);
        //接客履歴情報API
        helper.getGasReceiveHistoryListInfo(component, event);
        //警報器機器情報API
        helper.getKhKikiInfo(component, event); 
    },
    // ポップアップ画面閉じる処理
    popClose: function(component, event, helper) {
        component.set("v.isGasDetailOpen", false);
    }
})