({
    // 権限チェック、レコードタイプの取得、コピー用の顧客情報の取得
    checkPermission : function(component, event) {
        var action = component.get("c.checkPermission");
        var accountId = component.get("v.recordId");
        action.setParams({
            "accountId": accountId
        });
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                var displayInfo = response.displayInfo;
                if (response.code == 0) {
                    component.set("v.meigiteiseiRecTypeId", displayInfo.meigiteiseiRecTypeId);
                    component.set("v.meigihenkouRecTypeId", displayInfo.meigihenkouRecTypeId);
                    component.set("v.recordInfo", displayInfo.recordInfo);
                } else if (response.code == 40) {
                    component.set("v.permissionMessage", response.message);
                }
            } else {
                // 顧客情報がない場合もシステムエラーとする
                component.set("v.isOpen", false);
                component.set("v.popFlg", true);
            }
        });
        $A.enqueueAction(action);
    },
    // ケース新規画面を立ち上げる
    caseCreate : function(component, event) {
        var meigiteiseiRecTypeId = component.get("v.meigiteiseiRecTypeId");
        var meigihenkouRecTypeId = component.get("v.meigihenkouRecTypeId");
        var selectedOption = component.get("v.value");
        var recordInfo = component.get("v.recordInfo");
        
        var createCaseOfChangeNameEvent = $A.get("e.force:createRecord");
        if (selectedOption == "option1") {
            createCaseOfChangeNameEvent.setParams({
                "entityApiName": "Case",
                "recordTypeId": meigiteiseiRecTypeId,
                "defaultFieldValues": { //初期セットするものの定義
                    'BeforeCorrectNameOfKana__c' : recordInfo.Id,　
                    'BeforeCorrectNameOfKanji__c' : recordInfo.NameOfKanji__c,　
                    'BeforeCorrectPhoneNumber__c' : recordInfo.PhoneNumber1__c,　
                    'BeforeCorrectPhoneNumber2__c' : recordInfo.PhoneNumber2__c,　
                    'BeforeCorrectAddressState__c' : recordInfo.BillingState,　
                    'BeforeCorrectAddressCity__c' : recordInfo.BillingCity,　
                    'BeforeCorrectAddressStreet__c' : recordInfo.BillingStreet,
                    'BeforeCorrectAddressBuilding__c' : recordInfo.BuildingName__c,
                    'BeforeCorrectAddressBuildingNumber__c' : recordInfo.BuildingNumber__c,
                    'BeforeCorrectAddressRoomNumber__c' : recordInfo.RoomNumber__c
                }
            });
            createCaseOfChangeNameEvent.fire();
        } else {
            //ボタン制御
            event.getSource().set("v.disabled", true);
            
            var action = component.get("c.createNewCase");
            action.setParams({
                "accountId" : recordInfo.Id,
                "recordTypeId" : meigihenkouRecTypeId
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var storeResponse = response.getReturnValue();
                    this.gotoRecordViewURL(storeResponse);
                } else {
                    console.error("error: " + response.message);
                }
            });
            // アクションを行う
            $A.enqueueAction(action);
            /*
            createCaseOfChangeNameEvent.setParams({
                "entityApiName": "Case",
                "recordTypeId": meigihenkouRecTypeId,
                "defaultFieldValues": { //初期セットするものの定義
                    'FormerContractor__c' : recordInfo.Id
                }
            });*/
        }
        //createCaseOfChangeNameEvent.fire();
    },
    
    // 参照画面に遷移する
    gotoRecordViewURL : function (recordId) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            recordId : recordId
        });
        navEvt.fire();
    }
})