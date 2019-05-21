({
    init : function(component, event, helper) {
    	helper.getContractList(component, event);
    },

    handleSectionToggle: function (cmp, event, helper) {
        var openSections = event.getParam('openSections');
    },
    
    openModel: function(component, event, helper) {
      // for Display Model,set the "isOpen" attribute to "true"
      component.set("v.popFlg", true);
      helper.getContractDetail(component, event);
      var gasContract = component.get("v.gasContract");
      //console.error("gasContract:" + gasContract.userPostal);
      if (gasContract) {
        console.error("true");
      }
    },
    
    // ポップアップ画面閉じる処理
    popClose: function(component, event, helper) {
        component.set("v.popFlg", false);
    },
    //yuan
    onCheck: function(component, event, helper){
        debugger;
        var id = event.getSource().get("v.text");
        var value = event.getSource().get("v.value");
        component.set('v.checkbox'+id,value);
    }
    //yuan
})