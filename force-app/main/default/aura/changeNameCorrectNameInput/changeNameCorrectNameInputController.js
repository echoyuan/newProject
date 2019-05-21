({
    // 初期化で権限チェック、レコードタイプの取得、コピー用の顧客情報の取得
	init : function(component, event, helper) {
        helper.checkPermission(component, event)
    },
    
    // 画面選択有無チェック
    validationCheck : function(component, event, helper) {
        component.set("v.errorMessage", "");
        if ($A.util.isEmpty(component.get("v.value"))) {
            component.set("v.errorMessage", "選択肢を一つ選んでください。");
        } else {
            helper.caseCreate(component, event);
        }
    },
    //ラジオボタン処理
    onGroup: function(component, event) {
        var option = event.getSource().get("v.text");
        component.set("v.value", option);
    }
})