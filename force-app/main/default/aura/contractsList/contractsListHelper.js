({
	getContractList  : function(component, event) {
    	var id = component.get("v.recordId");
	    // Apex
    	var action = component.get("c.getContractList");
	    action.setParams({
    		"id": id
	    });
        
    	action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                if (response.code == 0) {
                    var contractList = response.contractList;
                    component.set("v.contractsList", contractList);
                    var sum = 0;
                    for(var ind=0; ind < contractList.length; ind++){
                        sum = sum + contractList[ind].length;
                    }
                    if (contractList) {
                        component.set("v.count", sum);
                    } 
                } else if (response.code == 40) {
                    component.set("v.message", response.message);
                    console.error("warn:" + response.message);
                }                
            } else {
                component.set("v.message", 'システムエラーが発生しました');
                var errors = data.getError();
                if (response.code == 100 && response.message) {
                    console.error("error: " + response.message);
                } else if (errors && errors[0] && errors[0].message) {
                    console.error("error: " + errors[0].message);
                }
                component.set("v.errorFlg", true);
            }
    	});
        
    	$A.enqueueAction(action);
    },

    getContractDetail  : function(component, event) {
	    // Apex
        var action = component.get("c.getContractDetail");
        action.setParams({
            'serviceType': event.target.getAttribute('data-service-type')
            ,'serviceKey': event.target.getAttribute('data-service-key')
	    });
        
    	action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                if (response.code == 0) {
                    var contract = response.contract;
                    component.set("v.gasContract", contract);                    
                } else if (response.code == 40) {
                    component.set("v.contractMessage", response.message);
                }
            } else {
                component.set("v.contractMessage", 'システムエラーが発生しました');
                var errors = data.getError();
                if (response.code == 100 && response.message) {
                    console.error("error: " + response.message);
                } else if (errors && errors[0] && errors[0].message) {
                    console.error("error: " + errors[0].message);
                }
                // component.set("v.errorFlg", true);
            }
    	});
        
    	$A.enqueueAction(action);
    },
    
    //add by yuan
    //電力契約詳細取得
    getElContractDetail : function(component, event) {
        var action = component.get("c.getElContractDetail");
        action.setParams({
            'serviceType': event.target.getAttribute('data-service-type')
            ,'serviceKey': event.target.getAttribute('data-service-key')
	    });
    	action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            debugger;
            if (action.getState() == "SUCCESS" && response.code != 100) {
                if (response.code == 0) {
                    var contract = response.contract;
                    component.set("v.elContract", contract);                    
                } else if (response.code == 40) {
                    component.set("v.contractMessage", response.message);
                }
            } else {
                component.set("v.contractMessage", 'システムエラーが発生しました');
                var errors = data.getError();
                if (response.code == 100 && response.message) {
                    console.error("error: " + response.message);
                } else if (errors && errors[0] && errors[0].message) {
                    console.error("error: " + errors[0].message);
                }
            }
    	});
    }
    //add by yuan
})