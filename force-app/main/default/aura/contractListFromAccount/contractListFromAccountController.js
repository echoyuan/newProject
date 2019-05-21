({
    /*contractListFromAccountEvent : function(component, event, helper) {
		helper.getContractList(component, event);
	}
    afterScriptsLoaded : function(component, event, helper) {
        alert("i like jqury");
    },
    init : function(component, event, helper) {
        jQuery("document").ready(function(){
          console.log('loaded');
          
      });
        
        helper.getContractList(component, event);
        //var contractListFromAccountEvent = component.getEvent("contractListFromAccountEvent");
        //contractListFromAccountEvent.setParams({ "expense": expense });
        //contractListFromAccountEvent.fire();
    },
    // 契約詳細画面を開く
    openModel: function(component, event, helper) {
        // 契約詳細画面のサービス契約種別取得
        var serviceType = event.target.getAttribute('data-service-type');
        var userKey = event.target.getAttribute('data-user-key');
        var serviceKey = event.target.getAttribute('data-service-key');
        var otherKey = event.target.getAttribute('data-other-key');
        component.set("v.serviceKey", serviceKey);
        // ガス画面
        if (serviceType == '001') {
            component.set("v.userKey", userKey);
            component.set("v.otherKey", otherKey);
            component.set("v.isGasDetailOpen", true);
        } else if (serviceType == '006') {
            // 電気画面
            component.set("v.isElcDetailOpen", true);
        } else if (serviceType == '012') {
            // スぺサポ画面
            component.set("v.isSpDetailOpen", true);
        } else if (serviceType == '010') {
            // 域外画面
            component.set("v.userKey", userKey);
            component.set("v.isOutsideTADetailOpen", true);
        } else if (serviceType == '007') {
            // トリプル割画面
            component.set("v.isTlDetailOpen", true);
        } else if (serviceType == '004') {
            // 警報器リース画面
            component.set("v.userKey", userKey);
            component.set("v.isKhDetailOpen", true);
        }
    },

    handleSectionToggle: function (cmp, event, helper) {
        var openSections = event.getParam('openSections');
    },
    initSelect : function(component, event, helper) {
        helper.getContractInfo(component, event);
    },
    returnToList : function(component, event, helper) {
    	var strMsg = '選択状態が変更されています。変更を破棄する場合はもう一度「キャンセル」ボタンを押してください。';
        var checkBackUpList = component.get("v.checkBackUpList");
        var infoFlg = component.get("v.infoFlg");
        var id = component.get("v.recordId");
        component.set("v.errorFlg", false);
        if(!infoFlg){
            for(var ind=0; ind < checkBackUpList.length; ind++){
                var cbxDom = document.getElementById(id + "cbx" + ind);
                if((checkBackUpList[ind] == 'ON' && !cbxDom.checked) ||
                   (checkBackUpList[ind] == 'OFF' && cbxDom.checked)){
                    infoFlg = true;
                    break;
                }
            }
            if(infoFlg){
                component.set("v.infoFlg", true);
                component.set("v.infoMsg", strMsg);
            }else{
                component.set("v.infoFlg", false);
                component.set("v.infoMsg", null);
                component.set("v.viewModel", 'view');
                component.set("v.isDisplayForChangeNameFlg", true);
                component.set("v.checkModel", '');
            }
        }else{
            for(var ind=0; ind < checkBackUpList.length; ind++){
                var cbxDom = document.getElementById(id + "cbx" + ind);
                if(checkBackUpList[ind] == 'ON'){
                    cbxDom.checked = true;
                }else{
                    cbxDom.checked = false;
                }
            }
            component.set("v.infoFlg", false);
            component.set("v.viewModel", 'view');
            component.set("v.isDisplayForChangeNameFlg", true);
            component.set("v.checkModel", '');
        }
    },
    changeStatus : function(component, event, helper) {
    	component.set("v.viewModel", 'edit');
        component.set("v.isDisplayForChangeNameFlg", true);
        component.set("v.checkModel", 'edit');
        component.set("v.infoFlg", false);
        component.set("v.warningFlg", false);
    },
    saveChangeJson : function(component, event, helper) {
    	helper.saveChangeJson(component, event, helper);
    },
    onCheck: function(component, event, helper){
    	helper.onCheck(component, event, helper);
    } */
})