({
    init : function(component, event, helper) {
        helper.getContractList(component, event);
       // var contractListFromAccountEvent = component.getEvent("contractListFromAccountEvent");
        //contractListFromAccountEvent.setParams({ "expense": expense });
        //contractListFromAccountEvent.fire();
    },
    // 契約詳細画面を開く
    openModel: function(component, event, helper) {
      // 契約詳細画面のサービス契約種別取得
      var serviceType = event.target.getAttribute('data-service-type');
      var no = event.target.getAttribute('data-service-key');
        // ガス画面
        /*if (serviceType == '001') {
            component.set("v.nox1", "1");
            component.set("v.nox3", "3");
            component.set("v.nox4", "4");
            component.set("v.isGasDetailOpen", true);
        } else if (serviceType == '006') {
            // 電気画面
            component.set("v.nox3", "3");
            component.set("v.nox8", "8");
            component.set("v.sa", "sa");
            component.set("v.ttBn", "ttBn");
            component.set("v.isElcDetailOpen", true);
        } else if (serviceType == '012') {
            // スぺサポ画面
            component.set("v.customerNo", "customerNo");
            component.set("v.serviceNo", "serviceNo");
            component.set("v.isSpDetailOpen", true);
        } else if (serviceType == '010') {
            // 域外画面
            component.set("v.nox3", "3");
            component.set("v.isOutsideTADetailOpen", true);
        } else if (serviceType == '007') {
            // トリプル割画面
            component.set("v.pNo", "pNo");
            component.set("v.serviceId", "serviceId");
            component.set("v.isTlDetailOpen", true);
        } else if (serviceType == '004') {
            // 警報器リース画面
            component.set("v.nox4", "4");
            component.set("v.isKhDetailOpen", true);
        } else if (serviceType == '0041') {
            // 0041はテスト用のみ、削除要
            component.set("v.nox4", "3");
            component.set("v.isKhDetailOpen", true);
        }*/
    },

    handleSectionToggle: function (cmp, event, helper) {
        var openSections = event.getParam('openSections');
    },
    initSelect : function(component, event, helper) {
        helper.getContractInfo(component, event);
    },
    returnToList : function(component, event, helper) {
    	// helper.returnToList(component, event);
        var checkBackUpList = component.get("v.checkBackUpList");
        var infoFlg = component.get("v.infoFlg");
        if(!infoFlg){
            for(var ind=0; ind < checkBackUpList.length; ind++){
                if((checkBackUpList[ind] == 'ON' && !document.getElementById("cbx"+ind).checked) ||
                   (checkBackUpList[ind] == 'OFF' && document.getElementById("cbx"+ind).checked)){
                    infoFlg = true;
                    break;
                }
            }
            if(infoFlg){
                component.set("v.infoFlg", true);
                component.set("v.infoMsg", '名義変更対象契約の選択状態が変更されています。保存しないで状態を破棄する場合はもう一度「キャンセル」ボタンを押してください。');
            }else{
                component.set("v.infoFlg", false);
                component.set("v.infoMsg", null);
                component.set("v.viewModel", 'view');
                component.set("v.checkModel", '');
            }
        }else{
            for(var ind=0; ind < checkBackUpList.length; ind++){
                if(checkBackUpList[ind] == 'ON'){
                    document.getElementById("cbx"+ind).checked = true;
                }else{
                    document.getElementById("cbx"+ind).checked = false;
                }
            }
            component.set("v.infoFlg", false);
            component.set("v.viewModel", 'view');
            component.set("v.checkModel", '');
        }
    },
    changeStatus : function(component, event, helper) {
    	component.set("v.viewModel", 'edit');
        component.set("v.checkModel", 'edit');
        component.set("v.infoFlg", false);
        component.set("v.warningFlg", false);
    },
    saveChangeJson : function(component, event, helper) {
    	//helper.saveChangeJson(component, event, helper);
    	//var id = component.get("v.recordId");
    	
    	
    },
    onCheck: function(component, event, helper){
    	helper.onCheck(component, event, helper);
    } 
})