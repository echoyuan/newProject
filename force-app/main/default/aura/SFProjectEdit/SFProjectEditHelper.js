({
    // 保存処理
    savePj: function(component, Project__c, callback) {
        var action = component.get("c.updatePj");
        action.setParams({
            pj : Project__c
        });
        if (callback) {
            action.setCallback(this, callback);
        }
        // アクションを行う
        $A.enqueueAction(action);
    },
    
    // 保存時チェック処理に対して、エラー情報等がない場合に呼び出す
    upsertHandler: function(component, event, helper) {
        var pj = component.get("v.recordInfo");
        event.getSource().set("v.disabled","true");
        this.savePj(component, pj, function(response){
            var state = response.getState();
            if (state == "SUCCESS") {
                var cmpView = response.getReturnValue();
                // 新規登録完了（保存ボタンのみ）後、
                // 詳細画面に遷移の時に登録された情報のレコードIDが必要となるため、下記一行の設定が必要となる
                component.set("v.recordInfo", cmpView.recordInfo);
                // エラーなし場合
                var acctionStr = "作成";
                if (component.get("v.successAction") == 1){
                    acctionStr = "保存";
                }
                var title = "項目名 \""+ cmpView.recordInfo.Name + "\" が" + acctionStr + "されました。";
                this.handleShowToast(component, title, "success");
                var buttonId = event.getSource().getLocalId();
                if (buttonId == 'saveAndNew') {
                    this.gotoViewListURLToNew(component, event);
                } else {
                    this.gotoRecordViewURL(component, event);                        
                }
            } else if (state === "ERROR") {
                 // 想定外エラー
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        component.set("v.errorMsg", errors[0].message);
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            } else {
                component.set("v.errorMsg", state);
            }
            event.getSource().set("v.disabled","false");
        });
    },

    // 結果メッセージ表示
    handleShowToast : function(component, title, variant) {
        component.find('notifLib').showToast({
            "title": title,
            "variant": variant,
            "mode": "dismissable"
        });
    },
    
    // 保存時チェック処理（新規・編集画面で保存ボタン押下）
    checkHandler: function(component, event, helper) {
        var pj = component.get("v.recordInfo");
        if (pj.Name == null || pj.Name == '') {
            this.handleShowToast(component, "項目１を有効な値に選択しなければ、実行できません。", "error");
            //return;
        }
        var errflg = false;
        component.set("v.errorMsg", null);
        var action = component.get("c.checkRecordInfo");
        action.setParams({
            'pj' : pj
        });
        event.getSource().set("v.disabled","true");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == "SUCCESS") {
                var cmpView = response.getReturnValue();
                if(!errflg && (cmpView.errorMsg == '' || cmpView.errorMsg == null || cmpView.errorMsg.length == 0)){
                    this.upsertHandler(component, event, helper);
                } else {
                    component.set("v.errorMsg", cmpView.errorMsg);
                    errflg = true;
                }
            } else if (state === "ERROR") {
                // 想定外エラー
                errflg = true;
                var errors = response.getError();
                
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        component.set("v.errorMsg", errors[0].message);
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            } else {
                errflg = true;
                component.set("v.errorMsg", state);
            }
            if (errflg) {
                // チェックエラーがある場合、スクロールを一番上まで戻す
                window.scrollTo(0,0);
            }
            event.getSource().set("v.disabled","false");
        });
        // アクションを行う
        $A.enqueueAction(action);
    },
    
    // 新規・編集画面初期化処理
    initHandler: function(component, event, helper) {
        component.set("v.errorMsg", null);
        var action = component.get("c.initCmpView");
        var recordId = component.get("v.recordId");
        action.setParams({
            recordId : recordId
        });
    
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == "SUCCESS") {
                var cmpView = response.getReturnValue()
                if(cmpView.recordInfo.Id != null){
                    component.set("v.successAction", 1);
                } else {
                    component.set("v.successAction", 0);
                }
                component.set("v.cmpView", cmpView);
                component.set("v.recordInfo", cmpView.recordInfo);
                component.set("v.errorMsg", cmpView.errorMsg);
            } else if (state === "ERROR") {
                // 想定外エラー
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        component.set("v.errorMsg", errors[0].message);
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            } else {
                component.set("v.errorMsg", state);
            }
        });
        // アクションを行う
        $A.enqueueAction(action);
    },
    
    // キャンセルボタン
    gotoViewListURL : function (component, event, helper) {
        var homeEvent = $A.get("e.force:navigateToObjectHome");
        homeEvent.setParams({
            "scope": "Project__c"
        });
        homeEvent.fire();
    },
    
    // 新規画面に遷移
    gotoViewListURLToNew : function (component, event, helper) {
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:SFProjectEdit"
        });
        evt.fire();
    },
    
    // 参照画面に遷移する
    gotoRecordViewURL : function (component, event) {
        var navEvt = $A.get("e.force:navigateToSObject");
        var recordId = component.get("v.recordInfo.Id");
        navEvt.setParams({
            recordId : recordId
        });
        navEvt.fire();
    }
})