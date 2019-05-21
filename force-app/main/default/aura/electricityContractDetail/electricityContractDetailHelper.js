({
    getSyncContractInfo : function(component, event) {
        var thisTemp = this;
        //契約情報API
        thisTemp.getElectricityContractInfo(component, event)
        .then(function(xGas4X) {
            //ガス関連番号API
            thisTemp.getGasRelationNoInfo(component, event, xGas4X);
        }).catch(function (error) {
            component.set("v.errorFlg", true);
        });
    },
    //契約お客さま情報API
    getElectricityAccountInfo : function(component, event) {
        // Apex
        var action = component.get("c.getElectricityAccountInfo");
        var sa = component.get("v.sa");
        action.setParams({
            'sa': sa
        });
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                if (response.code == 0) {
                    var electricityAccount = response.displayInfo;
                    component.set("v.electricityAccount", electricityAccount);
                } else if (response.code == 40) {
                    var messages = component.get("v.messages");
                    messages[messages.length] = response.message;
                    component.set("v.messages", messages);
                }
            } else {
                // システムエラー
            }
        });
        $A.enqueueAction(action);
    },
    //契約情報API
    getElectricityContractInfo : function(component, event) {
        // Apex
        var action = component.get("c.getElectricityContractInfo");
        var sa = component.get("v.sa");
        action.setParams({
            'sa': sa
        });
        return new Promise(function(resolve, reject) {
            action.setCallback(this, function(data) {
                var response = data.getReturnValue();
                if (component.isValid() && data.getState() == "SUCCESS" && response.code != 100) {
                    if (response.code == 0) {
                        var electricityContract = response.displayInfo;
                        component.set("v.electricityContract", electricityContract);
                        resolve(electricityContract.xGas4X);
                    } else if (response.code == 40) {
                        var messages = component.get("v.messages");
                        messages[messages.length] = response.message;
                        component.set("v.messages", messages);
                        reject(data.getError());
                    }
                } else {
                    reject(data.getError());
                }
            });
            $A.enqueueAction(action);
        }); 
    },
    //ガス関連番号API
    getGasRelationNoInfo  : function(component, event, xGas4X) {
        // Apex
        var action = component.get("c.getGasRelationNoInfo");
        action.setParams({
            'xGas4X': xGas4X
        });
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                if (response.code == 0) {
                    var gasRelationNo = response.displayInfo;
                    component.set("v.gasRelationNo", gasRelationNo);  
                } else if (response.code == 40) {
                    var messages = component.get("v.messages");
                    messages[messages.length] = response.message;
                    component.set("v.messages", messages);
                }
            } else {
                // システムエラー
            }
        });
        $A.enqueueAction(action);
    },
    //契約支払者情報API
    getElectricityPaymentInfo : function(component, event) {
        // Apex
        var action = component.get("c.getElectricityPaymentInfo");
        var sa = component.get("v.sa");
        action.setParams({
            'sa': sa
        });
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                if (response.code == 0) {
                    var electricityPayment = response.displayInfo;
                    component.set("v.electricityPayment", electricityPayment);
                } else if (response.code == 40) {
                    var messages = component.get("v.messages");
                    messages[messages.length] = response.message;
                    component.set("v.messages", messages);
                }
            } else {
                // システムエラー
            }
        });
        $A.enqueueAction(action);
    },
    //期間限定割情報API
    getElectricityTermLimitedInfo : function(component, event) {
        // Apex
        var action = component.get("c.getElectricityTermLimitedInfo");
        var sa = component.get("v.sa");
        action.setParams({
            'sa': sa
        });
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                if (response.code == 0) {
                    var electricityTermLimited = response.displayInfo;
                    component.set("v.electricityTermLimited", electricityTermLimited);
                } else if (response.code == 40) {
                    var messages = component.get("v.messages");
                    messages[messages.length] = response.message;
                    component.set("v.messages", messages);
                }
            } else {
                // システムエラー
            }
        });
        $A.enqueueAction(action);
    },
    //指図情報API
    getElectricityOperationOrderInfo : function(component, event) {
        // Apex
        var action = component.get("c.getElectricityOperationOrderInfo");
        var sa = component.get("v.sa");
        action.setParams({
            'sa': sa
        });
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                if (response.code == 0) {
                    var operationOrderList = response.displayInfo;
                    component.set("v.operationOrderList", operationOrderList);
                } else if (response.code == 40) {
                    var messages = component.get("v.messages");
                    messages[messages.length] = response.message;
                    component.set("v.messages", messages);
                }
            } else {
                // システムエラー
            }
        });
        $A.enqueueAction(action);
    }
})