({
    init : function(component, event, helper) {
    	helper.getContractList(component, event);
        component.set("v.activeSections", []);
    },

    handleSectionToggle: function (cmp, event, helper) {
        var openSections = event.getParam('openSections');
    },
    
    openModel: function(component, event, helper) {
      // for Display Model,set the "isOpen" attribute to "true"
      //component.set("v.popFlg", true);
      component.set("v.gasPopFlg", true);
      helper.getContractDetail(component, event);
      var gasContract = component.get("v.gasContract");
      //console.error("gasContract:" + gasContract.userPostal);
      if (gasContract) {
        console.error("true");
      }
    },
 
    //add by yuan
    openElModel: function(component, event, helper) {
      // for Display Model,set the "isOpen" attribute to "true"
      component.set("v.elPopFlg", true);
      helper.getElContractDetail(component, event);
      var elContract = component.get("v.elContract");
      //console.error("gasContract:" + gasContract.userPostal);
      if (elContract) {
        console.error("true");
      }
    },
    //add by yuan

    openList000: function (component, event, helper) {
        component.set("v.isOpen000", true);
    },

    closeList000: function (component, event, helper) {
        component.set("v.isOpen000", false);
    },
 
    openList001: function (component, event, helper) {
        component.set("v.isOpen001", true);
    },

    closeList001: function (component, event, helper) {
        component.set("v.isOpen001", false);
    },
 
    openList002: function (component, event, helper) {
        component.set("v.isOpen002", true);
    },

    closeList002: function (component, event, helper) {
        component.set("v.isOpen002", false);
    },
 
    openList003: function (component, event, helper) {
        component.set("v.isOpen003", true);
    },

    closeList003: function (component, event, helper) {
        component.set("v.isOpen003", false);
    },
 
    openList004: function (component, event, helper) {
        component.set("v.isOpen004", true);
    },

    closeList004: function (component, event, helper) {
        component.set("v.isOpen004", false);
    },
 
    openList006: function (component, event, helper) {
        component.set("v.isOpen006", true);
    },

    closeList006: function (component, event, helper) {
        component.set("v.isOpen006", false);
    },
 
    openList007: function (component, event, helper) {
        component.set("v.isOpen007", true);
    },

    closeList007: function (component, event, helper) {
        component.set("v.isOpen007", false);
    },
 
    openList008: function (component, event, helper) {
        component.set("v.isOpen008", true);
    },

    closeList008: function (component, event, helper) {
        component.set("v.isOpen008", false);
    },
 
    openList009: function (component, event, helper) {
        component.set("v.isOpen009", true);
    },

    closeList009: function (component, event, helper) {
        component.set("v.isOpen009", false);
    },
 
    openList010: function (component, event, helper) {
        component.set("v.isOpen010", true);
    },

    closeList010: function (component, event, helper) {
        component.set("v.isOpen010", false);
    },
 
    openList012: function (component, event, helper) {
        component.set("v.isOpen012", true);
    },

    closeList012: function (component, event, helper) {
        component.set("v.isOpen012", false);
    },
    
    // ポップアップ画面閉じる処理
    popClose: function(component, event, helper) {
        component.set("v.popFlg", false);
    },
    
    elPopClose: function(component, event, helper) {
        component.set("v.elPopFlg", false);
    },
    
   
    handleShowModal:function(component, event, helper) {
        var serviceType = event.target.getAttribute('data-service-type');
        var serviceKey = event.target.getAttribute('data-service-key');
     
        $A.createComponent("c:ElContractDetail", {
            "serviceType":serviceType,
            "serviceKey":serviceKey
            //component引入后，画面关闭，父画面也被关闭了
            //"parentComponent":component
        },
        function(component, status) {
            if (status === "SUCCESS") {
                var modalBody;
                modalBody = component;
                component.find('overlayLib').showCustomModal({
                    //header: "電力",
                    body: modalBody,
                    showCloseButton: false,
                    cssClass: "mydefined"
                }).then(function (overlay) {
                });                    
            }});
    },
    tripleOpenMode: function(component, event, helper) {
        component.set("v.triplePopFlg", true);
        
    },
        // ポップアップ画面閉じる処理
    triplePopClose: function(component, event, helper) {
        component.set("v.triplePopFlg", false);
    },
    
    openEleModel: function(component, event, helper) {
        component.set("v.elePopFlg", true);
        
    }
})