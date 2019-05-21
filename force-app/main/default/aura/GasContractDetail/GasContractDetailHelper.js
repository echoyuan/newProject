({
    getSyncGasContractInfo : function(component, event) {
        var thisTemp = this;
        //ガス契約情報API
        thisTemp.getGasContractListInfo(component, event)
        .then(function(gasContractResponseDto) {
            //支払情報取得
            thisTemp.getPaymentListInfo(component, event, gasContractResponseDto.syokyNo)
            .then(function(shrkyNo) {
                //お客さま情報API
                thisTemp.getGasAccountInfo(component, event, shrkyNo);
            });
            //総合扱いガスメータ/数 
            var sogoAtkGmtSu = gasContractResponseDto.sogoAtkGmtSu;
            //総合契約判断
            var isSogoAtkGmtSu = new Boolean(false);
            if (Number(sogoAtkGmtSu) !='NaN' && Number(sogoAtkGmtSu) > 0) {
                isSogoAtkGmtSu = true; 
            }
            //ガスメータ設置場所情報API
            thisTemp.getGasMeterSetListInfo(component, event, isSogoAtkGmtSu);
        })
    },
    //ガス契約情報
    getGasContractListInfo : function(component, event) {
        // Apex
        var action = component.get("c.getGasContractListInfo");
        var nox4 = component.get("v.nox4");
        action.setParams({
            'nox4': nox4
        });
        return new Promise(function(resolve, reject) {
            action.setCallback(this, function(data) {
                var response = data.getReturnValue();
                if (component.isValid() && data.getState() == "SUCCESS") {
                    if (response.code == 0) {
                        var gasContractResponseDtoList = response.displayInfo;
                        component.set("v.gasContractResponseDtoList", gasContractResponseDtoList);
                        resolve(gasContractResponseDtoList[0]);
                    }
                    /*else if (response.code == 40) {
                    component.set("v.contractMessage", response.message);
                }*/   
                } else {
                    var errors = data.getError();
                    if (response.code == 100 && response.message) {
                        console.error("error: " + response.message);
                    } else if (errors && errors[0] && errors[0].message) {
                        console.error("error: " + errors[0].message);
                    }
                    reject(data.getError());
                }
            });
            $A.enqueueAction(action);
        }); 
    },
    //電気料金合算パターン情報API
    getGasElectricAddInfo : function(component, event) {
        // Apex
        var action = component.get("c.getGasElectricAddInfo");
        action.setParams({
            'nox4': component.get("v.nox4")	
        });
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                if (response.code == 0) {
                    var gasElectricAddResponseDto = response.displayInfo;
                    component.set("v.gasElectricAddResponseDto", gasElectricAddResponseDto);
                }
                /*else if (response.code == 40) {
                    component.set("v.contractMessage", response.message);
                }*/
            } else {
                //component.set("v.contractMessage", 'システムエラーが発生しました');
                var errors = data.getError();
                if (response.code == 100 && response.message) {
                    console.error("error: " + response.message);
                } else if (errors && errors[0] && errors[0].message) {
                    console.error("error: " + errors[0].message);
                }
            }
        });
        $A.enqueueAction(action);
    },
    //お客さま情報API
    getGasAccountInfo : function(component, event, noxParam) {
        // Apex
        var action = component.get("c.getGasAccountInfo");
        var noxParm = noxParam;
        action.setParams({
            'nox3': noxParm ? noxParm : component.get("v.nox3")	
        });
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                if (response.code == 0) {
                    if (!noxParm) {
                        var gasAccountResponseDto = response.displayInfo;
                        component.set("v.gasAccountResponseDto", gasAccountResponseDto);
                    } else {
                        var paymentAccountResponseDto = response.displayInfo;
                        component.set("v.paymentAccountResponseDto", paymentAccountResponseDto);
                    } 
                }
                /*else if (response.code == 40) {
                    component.set("v.contractMessage", response.message);
                }*/
            } else {
                //component.set("v.contractMessage", 'システムエラーが発生しました');
                var errors = data.getError();
                if (response.code == 100 && response.message) {
                    console.error("error: " + response.message);
                } else if (errors && errors[0] && errors[0].message) {
                    console.error("error: " + errors[0].message);
                }
            }
        });
        $A.enqueueAction(action);
    },
    //接客履歴情報API
    getGasReceiveHistoryListInfo : function(component, event) {
        // Apex
        var action = component.get("c.getGasReceiveHistoryListInfo");
        action.setParams({
            'nox3': component.get("v.nox3")
        });
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                if (response.code == 0) {
                    var gasReceiveHistoryResponseDtoList = response.displayInfo;
                    component.set("v.gasReceiveHistoryResponseDtoList", gasReceiveHistoryResponseDtoList);
                }
                /*else if (response.code == 40) {
                    component.set("v.contractMessage", response.message);
                }*/
            } else {
                //component.set("v.contractMessage", 'システムエラーが発生しました');
                var errors = data.getError();
                if (response.code == 100 && response.message) {
                    console.error("error: " + response.message);
                } else if (errors && errors[0] && errors[0].message) {
                    console.error("error: " + errors[0].message);
                }
            }
        });
        $A.enqueueAction(action);
    },
    //支払情報API
    getPaymentListInfo  : function(component, event, nox2) {
        // Apex
        var action = component.get("c.getPaymentListInfo");
        action.setParams({
            'nox2': nox2
        });
        return new Promise(function(resolve, reject) {
            action.setCallback(this, function(data) {
                var response = data.getReturnValue();
                if (action.getState() == "SUCCESS" && response.code != 100) {
                    if (response.code == 0) {
                        var gasPaymentResponseDtoList = response.displayInfo;
                        component.set("v.gasPaymentResponseDtoList", gasPaymentResponseDtoList);
                        resolve(gasPaymentResponseDtoList[0].shrkyNo);
                    }
                    /*else if (response.code == 40) {
                        component.set("v.contractMessage", response.message);
                    }*/
                } else {
                    //component.set("v.contractMessage", 'システムエラーが発生しました');
                    var errors = data.getError();
                    if (response.code == 100 && response.message) {
                        console.error("error: " + response.message);
                    } else if (errors && errors[0] && errors[0].message) {
                        console.error("error: " + errors[0].message);
                    }
                    reject(data.getError());
                }
            });
            $A.enqueueAction(action);  
        }); 
    }, 
    //ガスメータ設置場所情報API(ガスメータ一覧取得)
    getGasMeterSetListInfo  : function(component, event, isSogoAtkGmtSu) {
        // Apex
        var action = component.get("c.getGasMeterSetListInfo");
        action.setParams({
            'nox4': component.get("v.nox4"),
            'isSogoAtkGmtSu': isSogoAtkGmtSu
        });
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                if (response.code == 0) {
                    var gasMeterSetInfo = response.displayInfo;
                    if (isSogoAtkGmtSu.valueOf()) {
                        component.set("v.gasMeterSetResponseDtoList", gasMeterSetInfo);
                        var gasMeterSetResponseDto = {};
                        if (gasMeterSetInfo.length == 1) {
                            gasMeterSetResponseDto.gmtStatus = gasMeterSetInfo[0].gmtStatus;
                            component.set("v.gasMeterSetResponseDto", gasMeterSetResponseDto);
                        }
                    }else {
                        component.set("v.gasMeterSetResponseDto", gasMeterSetInfo);
                    } 
                }
                /*else if (response.code == 40) {
                    component.set("v.contractMessage", response.message);
                }*/
            } else {
                //component.set("v.contractMessage", 'システムエラーが発生しました');
                var errors = data.getError();
                if (response.code == 100 && response.message) {
                    console.error("error: " + response.message);
                } else if (errors && errors[0] && errors[0].message) {
                    console.error("error: " + errors[0].message);
                }
            }
        });
        $A.enqueueAction(action);
    },
    //警報器機器情報API
    getKhKikiInfo : function(component, event) {
        // Apex
        var action = component.get("c.getKhKikiInfo");
        action.setParams({
            'nox4': component.get("v.nox4")
        });
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                if (response.code == 0) {
                    var existStatus = response.displayInfo;
                    component.set("v.existStatus", existStatus);
                }
                /*else if (response.code == 40) {
                    component.set("v.contractMessage", response.message);
                }*/
            } else {
                //component.set("v.contractMessage", 'システムエラーが発生しました');
                var errors = data.getError();
                if (response.code == 100 && response.message) {
                    console.error("error: " + response.message);
                } else if (errors && errors[0] && errors[0].message) {
                    console.error("error: " + errors[0].message);
                }
            }
        });
        $A.enqueueAction(action);
    }
    
})