({
    // 初期化
    initHandler: function(component, event, helper) {
        helper.initHandler(component, event, helper);
    },
    // キャンセルボタン押下
    cancelHandler : function(component, event, helper) {
        // 画面遷移
        helper.gotoViewListURL(component, event, helper);
    },
    // 保存ボタン押下
    checkHandler : function(component, event, helper) {
        // 入力値チェック
        helper.checkHandler(component, event, helper);
    }
})