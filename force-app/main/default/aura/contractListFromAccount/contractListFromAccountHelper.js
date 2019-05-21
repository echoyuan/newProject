({
	getContractList  : function(component, event) {
        var apiThis = this;
        var pageUrl = decodeURIComponent(window.location.search.substring(1));
        var paramArrays = pageUrl.split('&');
        var no1x = '';
        var no3x = '';
        var no4x = '';
        var yellowCss = ' yellow-backcolor-row';
        for (var i = 0; i < paramArrays.length; i++) {
            var paramArray = paramArrays[i].split('=');
            if (paramArray[0] === 'meter') {
                no1x = paramArray[1].replace(/-/g,'');
            } else if (paramArray[0] === 'customer') {
                no3x = paramArray[1].replace(/-/g,'');
            } else if (paramArray[0] === 'gascontract') {
                no4x = paramArray[1].replace(/-/g,'');
            }
        }
        // rejectで返ったエラーの場合
        var errorHandler = $A.getCallback(function(error){
            // システムエラー
            //component.set("v.errorFlg", true);
        });
        var id = component.get("v.recordId");
        var action = component.get("c.getContractList");
        action.setParams({
            "id": id
        });
        var callNum = new Promise(function (resolve, reject) {
            action.setCallback(this, function (data) {
                var response = data.getReturnValue();
                if (action.getState() == "SUCCESS" && response.code != 100) {
                    if (response.code == 0) {
                        var contractList = response.displayInfo;
                        var sum = 0;
                        for(var ind=0; ind < contractList.length; ind++){
                            var isYellowCss = false;
                            sum = sum + contractList[ind].length;
                            for (var grp = 0; grp < contractList[ind].length; grp ++) {
                                var record = contractList[ind][grp];
                                // 解約済ではない場合
                                //if ($A.util.isEmpty(record.grayFlag)) {
                                    if ('001' == record.serviceType) {
                                        //contractList[ind][grp].grayFlag = yellowCss;
                                        if ((!$A.util.isEmpty(record.otherKey1) 
                                            && record.otherKey1 === no1x) 
                                            || (!$A.util.isEmpty(record.serviceKey) 
                                            && record.serviceKey === no4x)) {
                                            isYellowCss = true;
                                        }
                                    }
                                    if (('001' == record.serviceType 
                                         || '0011' == record.serviceType
                                         || '006' == record.serviceType
                                         || '0061' == record.serviceType
                                         || '004' == record.serviceType
                                         || '010' == record.serviceType) ) {
                                        //contractList[ind][grp].grayFlag = yellowCss;
                                        //contractList[ind][grp].viewKey = apiThis.viewKeyFormat(contractList[ind][grp].viewKey);
                                        if (!$A.util.isEmpty(record.userKey) 
                                            && record.userKey === no3x) {
                                            isYellowCss = true;
                                        }
                                    }
                                /*} else if (('001' == record.serviceType 
                                            || '0011' == record.serviceType
                                            || '006' == record.serviceType
                                            || '0061' == record.serviceType
                                            || '004' == record.serviceType
                                            || '010' == record.serviceType) ) {
                                    contractList[ind][grp].viewKey = apiThis.viewKeyFormat(contractList[ind][grp].viewKey);
                                }*/
                            }
                            if (isYellowCss) {
                                contractList[ind].backgroundCss = 'accordionYellowCss';
                            } else {
                                contractList[ind].backgroundCss = '';
                            }
                        }
                        component.set("v.contractsList", contractList);
                        if (contractList) {
                            component.set("v.count", sum);
                        }
                        resolve(contractList);
                    } else if (response.code == 40) {
                        // Apex異常がある場合
                        var messages = component.get("v.messages");
                        messages[messages.length] = response.message;
                        component.set("v.messages", messages);
                        reject(data.getError());
                    }
                } else {
                    // システムエラー
                    component.set("v.errorFlg", true);
                    reject(data.getError());
                }
            });
            action.setBackground();
            $A.enqueueAction(action);
        });
        callNum.then(
            $A.getCallback(function(contractList) {
                apiThis.callApi(component, event, contractList, apiThis);
                /*for (var i = 0;i < contractList.length; i++) {
                    var contractGroup = contractList[i];
                    for (var j = 0; j < contractGroup.length; j++) {
                        // ガスの場合
                        if ('001' == contractGroup[j].serviceType) {
                            // [ガスCIS]ガスメータ設置箇所情報APIを呼出す。4x
                            apiThis.getGasMeterSetList(component, event, contractGroup[j].serviceKey, contractGroup[j].status, i + '' + j);
                            // [ガスCIS]契約情報APIを呼出す。4x
                            apiThis.getGasContractListInfo(component, event, contractGroup[j].serviceKey, i + '' + j);
                        }
                        // 電気の場合
                        if ('006' == contractGroup[j].serviceType) {
                            apiThis.getElectricityContractInfo(component, event, contractGroup[j].serviceKey, i + '' + j);
                        }
                        // 域外ガス
                        if ('010' == contractGroup[j].serviceType) {
                            apiThis.getOverseasGasContractInfo(component, event, contractGroup[j].userKey, i + '' + j);
                        }
                    }
                }*/
            }),errorHandler);  
    },
    getGasMeterSetList  : function(component, event, serviceKey, status, index) {
        var action = component.get("c.getGasMeterSetList");
        var id = component.get("v.recordId");
        action.setParams({
            'serviceKey' : serviceKey
            ,'status' : status
        });
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            var statusDom = document.getElementById(id + "status" + index);
            var startDateDom = document.getElementById(id + "startDate" + index);
            var endDateDom = document.getElementById(id + "endDate" + index);
            if (data.getState() == "SUCCESS" && response.code == 0) {
                var displayInfo = response.displayInfo;
                if (statusDom != null && displayInfo.status != null) {
                    statusDom.innerHTML = displayInfo.status;
                    var parentElement = statusDom.parentElement;
                    if (parentElement) {
                        parentElement.title = displayInfo.status;
                    } 
                }
                if (startDateDom != null && displayInfo.gmtYmdStart != null) {
                    startDateDom.innerHTML = displayInfo.gmtYmdStart;
                    var parentElement = startDateDom.parentElement;
                    if (parentElement) {
                        parentElement.title = displayInfo.gmtYmdStart;
                    } 
                }
                if (endDateDom != null && displayInfo.gmtYmdEnd != null) {
                    endDateDom.innerHTML = displayInfo.gmtYmdEnd;
                    var parentElement = endDateDom.parentElement;
                    if (parentElement) {
                        parentElement.title = displayInfo.gmtYmdEnd;
                    } 
                }
            } else {
                if (statusDom != null) {
                    statusDom.innerHTML = '通信エラー';
                    statusDom.className = 'slds-text-color--error';
                }
                if (startDateDom != null) {
                    startDateDom.innerHTML = '通信エラー';
                    startDateDom.className = 'slds-text-color--error';
                }
                if (endDateDom != null) {
                    endDateDom.innerHTML = '通信エラー';
                    endDateDom.className = 'slds-text-color--error';
                }
            }
        });
        action.setBackground();
        $A.enqueueAction(action);
    },
    getGasContractListInfo  : function(component, event, serviceKey, index) {
        var action = component.get("c.getGasContractListInfo");
        action.setParams({
            'serviceKey' : serviceKey
        });
        var id = component.get("v.recordId");
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            var menuDom = document.getElementById(id + "menu" + index);
            if (data.getState() == "SUCCESS" && response.code == 0) {
                if (menuDom != null) {
                    menuDom.innerHTML = response.displayInfo;
                    var parentElement = menuDom.parentElement;
                    if (parentElement) {
                        parentElement.title = response.displayInfo;
                    } 
                }
            } else {
                if (menuDom != null) {
                    menuDom.innerHTML = '通信エラー';
                    menuDom.className = 'slds-text-color--error';
                }
            }
        });
        action.setBackground();
        $A.enqueueAction(action);
    },
    getOverseasGasContractInfo  : function(component, event, userKey, index) {
        var action = component.get("c.getOverseasGasContractInfo");
        action.setParams({
            'userKey' : userKey
        });
        var id = component.get("v.recordId");
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            var menuDom = document.getElementById(id + "menu" + index);
            if (data.getState() == "SUCCESS" && response.code == 0) {
                if (menuDom != null) {
                    var displayInfo = response.displayInfo;
                    menuDom.innerHTML = displayInfo.planNm;
                    var parentElement = menuDom.parentElement;
                    if (parentElement) {
                        parentElement.title = displayInfo.planNm;
                    } 
                }
            } else {
                if (menuDom != null) {
                    menuDom.innerHTML = '通信エラー';
                    menuDom.className = 'slds-text-color--error';
                }
            }
        });
        action.setBackground();        
        $A.enqueueAction(action);
    },
    getElectricityContractInfo  : function(component, event, serviceKey, index) {
        var action = component.get("c.getElectricityContractInfo");
        action.setParams({
            'serviceKey' : serviceKey
        });
        var id = component.get("v.recordId");
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            var menuDom = document.getElementById(id + "menu" + index);
            if (data.getState() == "SUCCESS" && response.code == 0) {
                if (menuDom != null) {
                    menuDom.innerHTML = response.displayInfo;
                    var parentElement = menuDom.parentElement;
                    if (parentElement) {
                        parentElement.title = response.displayInfo;
                    } 
                }
            } else {
                if (menuDom != null) {
                    menuDom.innerHTML = '通信エラー';
                    menuDom.className = 'slds-text-color--error';
                }
            }
        });
        action.setBackground();
        $A.enqueueAction(action);
    },
    getContractInfo  : function(component, event) {
        var apiThis = this;
        var id = component.get("v.recordId");
        var action = component.get("c.getContractInfo");
        action.setParams({
            "id": id
        });
         var callNum = new Promise(function (resolve, reject) {
            action.setCallback(this, function(data) {
                var commonResponse = data.getReturnValue();
                if (action.getState() == "SUCCESS" && commonResponse.code != 100) {
                    if (commonResponse.code == 0 || commonResponse.code == 60) {
                        var contractList = commonResponse.contractListByJson;
                        /*for(var ind=0; ind < contractList.length; ind++){
                            for (var grp = 0; grp < contractList[ind].length; grp ++) {
                                var record = contractList[ind][grp];
                                if ('001' == record.serviceType 
                                    || '0011' == record.serviceType
                                    || '006' == record.serviceType
                                    || '0061' == record.serviceType
                                    || '004' == record.serviceType
                                    || '010' == record.serviceType) {
                                    contractList[ind][grp].viewKey = apiThis.viewKeyFormat(contractList[ind][grp].viewKey);
                                }
                            }
                        }*/
                        component.set("v.contractsList", contractList);
                        var sum = 0;
                        for(var ind=0; ind < contractList.length; ind++){
                            sum = sum + contractList[ind].length;
                        }
                        if (contractList) {
                            component.set("v.count", sum);
                        }
                        
                        var checkList = commonResponse.checkListForJson;
                        //component.set("v.contractsList", contractList);
                        component.set("v.checkList", checkList);
                        component.set("v.checkBackUpList", checkList);
                        component.set("v.viewModel", commonResponse.viewModel);
                		component.set("v.isDisplayForChangeNameFlg", true);
                        component.set("v.checkModel", commonResponse.checkModel);
                        component.set("v.canEdit", commonResponse.canEdit);
                        // 契約内容が変更の場合
                        if (commonResponse.code == 60) {
                        	component.set("v.warningFlg", true);
                            component.set("v.warningMsg", commonResponse.message);
                        }
                        resolve(checkList);
                    } else if (commonResponse.code == 40) {
                        // Apex異常がある場合
                        var messages = component.get("v.messages");
                        messages[messages.length] = commonResponse.message;
                        component.set("v.messages", messages);
                        component.set("v.viewModel", commonResponse.viewModel);
                        reject(data.getError());
                    }
                } else {
                    component.set("v.errorFlg", true);
                    reject(data.getError());
                }
            });
             action.setBackground();
             $A.enqueueAction(action);
        });
        callNum.then(
            $A.getCallback(function(checkList) {
                for(var ind=0; ind < checkList.length; ind++){
                    var cbxDom = document.getElementById(id + "cbx" + ind);
                    //var childCmp = component.find('checkBoxChild');
                    if(checkList[ind] == 'ON'){
                        cbxDom.checked = true;
                        //childCmp[ind].set("v.value", true);
                    }else{
                        cbxDom.checked = false;
                        //childCmp[ind].set("v.value", false);
                    }
                }
                apiThis.callApi(component, event, component.get("v.contractsList"), apiThis);
            })/*,
            $A.getCallback(function(errors) {
                component.set("v.errorFlg", true);
            })*/
        );
        //action.setBackground();
        //$A.enqueueAction(action);
    },
    /*returnToList  : function(component, event) {
    	component.set("v.viewModel", 'view');
        component.set("v.checkModel", '');
        var checkBackUpList = component.get("v.checkBackUpList");
            
        for(var ind=0; ind < component.find('checkBoxChild').length; ind++){
            var childCmp2 = component.find('checkBoxChild');
            if(checkBackUpList[ind] == 'ON'){
            	childCmp2[ind].set("v.value", true);
            }else{
            	childCmp2[ind].set("v.value", false);
            }
        }
    },*/
    saveChangeJson  : function(component, event, helper) {
        var strMsg = '名義変更契約の対象情報を保存しました。';
        var id = component.get("v.recordId");
        var checkList = component.get("v.checkList");
        var contractsList = component.get("v.contractsList");
        var action = component.get("c.save");
        action.setParams({
            'id' : id,
            'contractsList': contractsList,
            'checkList': checkList
        });
        action.setCallback(this, function(data) {
            var commonResponse = data.getReturnValue();
            if (action.getState() == "SUCCESS" && commonResponse.code != 100) {
                if (commonResponse.code == 0) {
                    var checkList = commonResponse.checkListForJson;
                    component.set("v.checkList", checkList);
                    component.set("v.checkBackUpList", checkList);
                    component.set("v.viewModel", 'view');
                	component.set("v.isDisplayForChangeNameFlg", true);
                    component.set("v.checkModel", '');
                    component.set("v.infoFlg", true);
                    component.set("v.infoMsg", strMsg);
                } else if (commonResponse.code == 40) {
                    component.set("v.contractMessage", commonResponse.message);
                }
            } else {
                component.set("v.errorFlg", true);
            }
        });
        
        $A.enqueueAction(action);
    },
    onCheck: function(component, event, helper){
        //var id = event.getSource().get("v.text");
        //var value = event.getSource().get("v.value");
        var id = component.get("v.recordId");
        var checkList = component.get("v.checkList");
        for(var ind=0; ind < checkList.length; ind++){
            var cbxDom = document.getElementById(id + "cbx" + ind);
            if (cbxDom != null) {
                if(cbxDom.checked){
                    checkList[ind] = 'ON';
                }else{
                    checkList[ind] = 'OFF';
                }
            }
        }
        component.set("v.checkList", checkList);
    } ,
    callApi : function(component, event, contractList, apiThis){
        for (var i = 0;i < contractList.length; i++) {
            var contractGroup = contractList[i];
            //住所取得
            apiThis.setContractListAddressTitle(component, event, contractGroup, i);
            for (var j = 0; j < contractGroup.length; j++) {
                // ガスの場合
                if ('001' == contractGroup[j].serviceType) {
                    // [ガスCIS]ガスメータ設置箇所情報APIを呼出す。4x
                    apiThis.getGasMeterSetList(component, event, contractGroup[j].serviceKey, contractGroup[j].status, i + '' + j);
                    // [ガスCIS]契約情報APIを呼出す。4x
                    apiThis.getGasContractListInfo(component, event, contractGroup[j].serviceKey, i + '' + j);
                }
                // 電気の場合
                if ('006' == contractGroup[j].serviceType) {
                    apiThis.getElectricityContractInfo(component, event, contractGroup[j].serviceKey, i + '' + j);
                }
                // 域外ガス
                if ('010' == contractGroup[j].serviceType) {
                    apiThis.getOverseasGasContractInfo(component, event, contractGroup[j].userKey, i + '' + j);
                }
            }
        }
    },
    setContractListAddressTitle : function(component, event, contractGroup, index) {
        var id = component.get("v.recordId");
        var action = component.get("c.getContractListAddressTitle");
        action.setParams({
            'contractGroup' : contractGroup
        });
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (data.getState() == "SUCCESS" && response.code == 0) {
                var displayInfo = response.displayInfo;
                var obj = component.getSuper().find("address")[index];
                obj.set("v.label", "グループ" + (index+1) + "：" + displayInfo);
                //obj.set("v.label", "<span>1231313</span>");
            } else {
                var obj = component.getSuper().find("address")[index];
                obj.set("v.label", "グループ" + (index+1) + "：" + "通信エラー");
                $A.util.addClass(obj, 'textColorError'); 
            }
        });
        action.setBackground();
        $A.enqueueAction(action);
    }
    /*viewKeyFormat : function (viewKey) {
    	var pattern = /^([0-9]{11})$/;
    	if(pattern.test(viewKey)) {
    		viewKey = viewKey.substring(0,4) + '-' + viewKey.substring(4,7) + '-' + viewKey.substring(7);
		}
 		return viewKey;
 	}*/
})