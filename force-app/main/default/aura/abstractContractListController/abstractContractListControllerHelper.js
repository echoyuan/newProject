({
	getContractList  : function(component, event) {
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
                        component.set("v.contractsList", contractList);
                        resolve(contractList);
                    }
                } else {
                    reject(data.getError());
                }
            });
        });
        callNum.then(
            $A.getCallback(function(contractList) {
                for (var i = 0;i < contractList.length; i++) {
                    var contractGroup = contractList[i];
                    for (var j = 0; j < contractGroup.length; j++) {
                        // Apiのメソッドを一個づつ呼出す。それぞれで。
                        //Api1
                        //Api2 error　「通信エラー」で赤字で印字する感じ
                        //Api3
                        //if (document.getElementById("status"+i + '' + j) != null) {
                        //    document.getElementById("status"+i + '' + j).innerHTML = i + '' + j;
                        //}
                    }
                }
            }),
            $A.getCallback(function(errors) {
                component.set("v.errorFlg", true);
            })
        )
        
        $A.enqueueAction(action, true);
    },
    getContractInfo  : function(component, event) {
        var id = component.get("v.recordId");
        var action = component.get("c.getContractInfo");
        action.setParams({
            "id": id
        });
         var callNum = new Promise(function (resolve, reject) {
            action.setCallback(this, function(data) {
                var commonResponse = data.getReturnValue();
                if (action.getState() == "SUCCESS" && commonResponse.code != 100) {
                    if (commonResponse.code == 0) {
                        var contractList = commonResponse.contractListByJson;
                        
                        component.set("v.contractsList", contractList);
                        var sum = 0;
                        for(var ind=0; ind < contractList.length; ind++){
                            sum = sum + contractList[ind].length;
                        }
                        if (contractList) {
                            component.set("v.count", sum);
                        }
                        
                        var checkList = commonResponse.checkListForJson;
                        component.set("v.contractsList", contractList);
                        component.set("v.checkList", checkList);
                        component.set("v.checkBackUpList", checkList);
                        component.set("v.viewModel", commonResponse.viewModel);
                        component.set("v.checkModel", commonResponse.checkModel);
                        component.set("v.editBottenFlg", commonResponse.editBottenFlg);
                        resolve(checkList);
                    }else  if (commonResponse.code == 40) {
                        component.set("v.contractMessage", commonResponse.message);
                    } else if (commonResponse.code == 60) {
                        component.set("v.warningMsg", commonResponse.message);
                    }
                } else {
                    reject(data.getError());
                }
            });
        });
        callNum.then(
            $A.getCallback(function(checkList) {
                for(var ind=0; ind < checkList.length; ind++){
                    //var childCmp = component.find('checkBoxChild');
                    if(checkList[ind] == 'ON'){
                        document.getElementById("cbx"+ind).checked = true;
                        //childCmp[ind].set("v.value", true);
                    }else{
                        document.getElementById("cbx"+ind).checked = false;
                        //childCmp[ind].set("v.value", false);
                    }
                }
            }),
            $A.getCallback(function(errors) {
                component.set("v.errorFlg", true);
            })
        )
        $A.enqueueAction(action);
    },
    returnToList  : function(component, event) {
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
    },
    saveChangeJson  : function(component, event, helper) {
        var id = component.get("v.recordId");
        // TODO:
        if(id == null){
        	id = '5000k00000AL9GbAAL';
        }
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
                    component.set("v.checkModel", '');
                    component.set("v.infoFlg", true);
                    component.set("v.infoMsg", '名義変更契約の対象情報を保存しました。');
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
        var checkList = component.get("v.checkList");
        for(var ind=0; ind < checkList.length; ind++){
            if(document.getElementById('cbx'+ind).checked){
        		checkList[ind] = 'ON';
            }else{
        		checkList[ind] = 'OFF';
            }
        }
        component.set("v.checkList", checkList);
    } 
})