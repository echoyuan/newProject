({
    initLabel: function(component, event, helper) {
        component.set('v.mycolumns', [
            { label: '統合顧客ID(Ax)', fieldName: 'IntegratedClientID__c', type: 'text',sortable: true},
            { label: 'おなまえ(カナ)', fieldName: 'detailPageLink', type: 'url', data_target:'Id', sortable: true, typeAttributes: {label: { fieldName: 'Name'}, target: '_blank'}},
            { label: 'おなまえ(漢字・英字)', fieldName: 'NameOfKanji__c', type: 'text',sortable: true},
            { label: '生年月日', fieldName: 'Birthdate__c', type: 'date',sortable: true},
            { label: '電話番号', fieldName: 'PhoneNumber1__c', type: 'text',sortable: true},
            { label: '住所', fieldName: 'Address__c', type: 'text',sortable: true},
            { label: '統合顧客/未統合顧客', fieldName: 'ClientStatus__c', type: 'text', sortable: true}
            // cellAttributes: { class: { fieldName: 'ClientIconView__c' } } ,
        ]);
        helper.initHandler(component, event, helper);
        $A.util.removeClass(component.find("addressId"),"slds-form-element");
    },
    
    keySearch: function(component, event, helper) {
        //エラーメッセージ定義
        var errSchMsg = '顧客項目が設定されていません';
        var numChkMsg1 = '数値のみ入力可';
        var numChkMsg2 = '数値またはハイフン(-)のみ入力可';
        var inputTypeMsg = '入力形式が不正 (入力可能な形式：$1)';
        var inputLenMsg = '入力桁数が不正 (入力可能桁数：$1)';
        //メッセージリスト
        var messageList = new Array();
        //数字チェックフラグ
        var numberCheck = true;
        //長さチェックフラグ
        var lengthCheck = true;
        //チェック数値リスト
        var lenList = new Array();
        // メッセージ情報のクリア
        component.set("v.keyErrorMsg", null);
        // メッセージ情報のクリア
        component.set("v.propertyErrorMsg", null);
        var param = [];
        //ガスメーター設置場所番号(1x)
        var no1xId = component.find("no1xId");
        var no1xValue = component.get("v.no1xValue");
        //no1xId.set("v.errors", null);
        $A.util.removeClass(component.find("no1xValueError1"), "show");
        $A.util.removeClass(component.find("no1xValueError2"), "show");
        $A.util.removeClass(component.find("no1xId"),"slds-has-error");
        //支払契約番号(2x)
        //var no2xId = component.find("no2xId");
        //var no2xValue = component.get("v.no2xValue");
        //no2xId.set("v.errors", null);
        //お客さま登録番号(3x)
        var no3xId = component.find("no3xId");
        var no3xValue = component.get("v.no3xValue");
        //no3xId.set("v.errors", null);
        $A.util.removeClass(component.find("no3xValueError1"), "show");
        $A.util.removeClass(component.find("no3xValueError2"), "show");
        $A.util.removeClass(component.find("no3xId"),"slds-has-error");
        //ガス使用契約番号(ガス4x)
        var no4xId = component.find("no4xId");
        var no4xValue = component.get("v.no4xValue");
        //no4xId.set("v.errors", null);
        $A.util.removeClass(component.find("no4xValueError1"), "show");
        $A.util.removeClass(component.find("no4xValueError2"), "show");
        $A.util.removeClass(component.find("no4xId"),"slds-has-error");
        //統合顧客ID(AX)
        var axId = component.find("axId");
        var axValue = component.get("v.axValue");
        //axId.set("v.errors", null);
        $A.util.removeClass(component.find("axValueError1"), "show");
        $A.util.removeClass(component.find("axValueError2"), "show");
        $A.util.removeClass(component.find("axId"),"slds-has-error");
        //mTGログインID
        var mTGIdId = component.find("mTGIdId");
        var mTGIdValue = component.get("v.mTGIdValue");
        //mTGIdId.set("v.errors", null);
        $A.util.removeClass(component.find("mTGIdValueError1"), "show");
        $A.util.removeClass(component.find("mTGIdValueError2"), "show");
        $A.util.removeClass(component.find("mTGIdId"),"slds-has-error");
        //メッセージDivを隠す
        component.set('v.cmpView.areaViewMap.key1','display: none;');
        component.set('v.cmpView.areaViewMap.key2','display: none;');
        // 顧客属性項目検索設定
        $A.enqueueAction(component.get('c.setPropertySearch'));
        //顧客キー項目検索を行う
        if ($A.util.isEmpty(no1xValue) 
            //&& $A.util.isEmpty(no2xValue)
            && $A.util.isEmpty(no3xValue)
            && $A.util.isEmpty(no4xValue)
            && $A.util.isEmpty(axValue)
            && $A.util.isEmpty(mTGIdValue)) {
            messageList[messageList.length] = errSchMsg;
            component.set("v.keyErrorMsg", messageList);
        } else {
            lenList = new Array();
            lenList[0] = 11;
            lenList[1] = 13;
            
            //ガスメーター設置場所番号(1x)
            
            numberCheck = helper.checkNumberWithHF(null, no1xValue, 
                messageList, true, numChkMsg2, '', false);
            if (numberCheck){
                $A.util.addClass(component.find("no1xValueError1"),"show");
                $A.util.addClass(component.find("no1xId"),"slds-has-error");
                component.set('v.cmpView.areaViewMap.key1','');
            } else {
                param = ['11 or 13'];
                lengthCheck = helper.checkLength(null, no1xValue, 
                    messageList, lenList, helper.putMessageParam(inputLenMsg, param), numberCheck, false);
                if (lengthCheck){
                    $A.util.addClass(component.find("no1xValueError2"),"show");
                    $A.util.addClass(component.find("no1xId"),"slds-has-error");
                    component.set('v.cmpView.areaViewMap.key1','');
                }  
            }
            
            //支払契約番号(2x)
            /*numberCheck = helper.checkNumberWithHF(no2xId, no2xValue, 
                    messageList, true, numChkMsg2, '', false);
                helper.checkLength(no2xId, no2xValue, 
                    messageList, lenList, inputLenMsg.replace('X', '11 or 13'), numberCheck, false);*/
            //お客さま登録番号(3x)
            numberCheck = helper.checkNumberWithHF(null, no3xValue, 
                messageList, true, numChkMsg2, '', false);
            if (numberCheck){
                $A.util.addClass(component.find("no3xValueError1"),"show");
                $A.util.addClass(component.find("no3xId"),"slds-has-error");
                component.set('v.cmpView.areaViewMap.key1','');
            } else {
                param = ['11 or 13'];
                lengthCheck = helper.checkLength(null, no3xValue, 
                     messageList, lenList, helper.putMessageParam(inputLenMsg, param), numberCheck, false);
                if (lengthCheck){
                    $A.util.addClass(component.find("no3xValueError2"),"show");
                    $A.util.addClass(component.find("no3xId"),"slds-has-error");
                    component.set('v.cmpView.areaViewMap.key1','');
                }
            }
            
            //ガス使用契約番号(ガス4x)
            numberCheck = helper.checkNumberWithHF(null, no4xValue, 
                messageList, true, numChkMsg2, '', false);
            if (numberCheck){
                $A.util.addClass(component.find("no4xValueError1"),"show");
                $A.util.addClass(component.find("no4xId"),"slds-has-error");
                component.set('v.cmpView.areaViewMap.key1','');
            } else {
                param = ['11 or 13'];
                lengthCheck = helper.checkLength(null, no4xValue, 
                    messageList, lenList, helper.putMessageParam(inputLenMsg, param), numberCheck, false);
                if (lengthCheck){
                    $A.util.addClass(component.find("no4xValueError2"),"show");
                    $A.util.addClass(component.find("no4xId"),"slds-has-error");
                    component.set('v.cmpView.areaViewMap.key1','');
                }
            }
            //統合顧客ID(AX)
            param = ['先頭「A」、以降半角数値10桁'];
            numberCheck = helper.checkNumberWithHF(null, axValue, messageList, false, 
                helper.putMessageParam(inputTypeMsg, param), 'A', false);
            if (numberCheck){
                $A.util.addClass(component.find("axValueError1"),"show");
                $A.util.addClass(component.find("axId"),"slds-has-error");
                component.set('v.cmpView.areaViewMap.key2','');
            } else {
                lenList = new Array();
                lenList[0] = 11;
                param = ['11'];
                lengthCheck = helper.checkLength(null, axValue, 
                    messageList, lenList, helper.putMessageParam(inputLenMsg, param), numberCheck, false);
                if (lengthCheck){
                    $A.util.addClass(component.find("axValueError2"),"show");
                    $A.util.addClass(component.find("axId"),"slds-has-error");
                    component.set('v.cmpView.areaViewMap.key2','');
                }
            }
            
            //mTGログインID
            numberCheck = helper.checkNumberWithHF(null, mTGIdValue, 
                messageList, false, numChkMsg1, '', false);
            if (numberCheck){
                $A.util.addClass(component.find("mTGIdValueError1"),"show");
                $A.util.addClass(component.find("mTGIdId"),"slds-has-error");
                component.set('v.cmpView.areaViewMap.key2','');
            } else {
                lenList = new Array();
                lenList[0] = 20;
                param = ['20'];
                lengthCheck = helper.checkLength(null, mTGIdValue, 
                    messageList, lenList, helper.putMessageParam(inputLenMsg, param), numberCheck, false);
                if (lengthCheck){
                    $A.util.addClass(component.find("mTGIdValueError2"),"show");
                    $A.util.addClass(component.find("mTGIdId"),"slds-has-error");
                    component.set('v.cmpView.areaViewMap.key2','');
                }
            }
            
        }
        
        //入力チェックがない場合、相関チェックを行う
        if($A.util.isEmpty(messageList)){
            //顧客キー項目検索を行う
            helper.souKanKokyakuKeyCheck(component, messageList);
            component.set("v.keyErrorMsg", messageList);
        }

        if (!$A.util.isEmpty(messageList)) {
            component.set("v.isLoading", false);
            component.set("v.searchResult", null);
            //チェックエラーがある場合、スクロールを一番上まで戻す
            window.scrollTo(0,0);
        } else {
            component.set("v.isLoading", true);
            component.set("v.isLoaded", false);
            var mapToSend = {};
            mapToSend['no1xValue'] = no1xValue;
            mapToSend['no3xValue'] = no3xValue;
            mapToSend['no4xValue'] = no4xValue;
            mapToSend['axValue'] = axValue;
            mapToSend['mTGIdValue'] = mTGIdValue;
            helper.searchHelper(component, event, mapToSend);
        }
    },
    
    propertySearch: function(component, event, helper) {
        //エラーメッセージ定義
        var errSchMsg = '顧客項目が設定されていません';
        var numChkMsg1 = '全角カナのみ入力可';
        var numChkMsg2 = '数値またはハイフン(-)のみ入力可';
        var inputTypeMsg = '入力形式が不正 (入力可能な形式：$1)';
        var inputLenMsg = '入力桁数が不正 (入力可能桁数：$1)';
        var souKanChkMsg1 = '$1が入力される場合は電話番号、メールアドレス、住所のいずれかの入力は必須';
        var souKanChkMsg2 = '統合顧客/未統合顧客はどちらかのチェックは必須';
        
        /*var validExpense =component.find('viewform').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
            }, true);
        if(!validExpense){
            return false;
        }*/
        //メッセージリスト
        var messageList = new Array();
        //数字チェックフラグ
        var numberCheck = true;
        //長さチェックフラグ
        var lengthCheck = true;
        //チェック数値リスト
        var lenList = new Array();
        // メッセージ情報のクリア
        component.set("v.keyErrorMsg", null);
        // メッセージ情報のクリア
        component.set("v.propertyErrorMsg", null);
        var param = [];
        // 顧客キー項目検索項目設定
        $A.enqueueAction(component.get('c.setKeySearch'));
        //おなまえ(カナ)
        var nameKanaId = component.find("nameKanaId");
        var nameKanaValue = component.get("v.nameKanaValue");
        //nameKanaId.set("v.errors", null);
        $A.util.removeClass(component.find("nameKanaValueError1"), "show");
        $A.util.removeClass(component.find("nameKanaValueError2"), "show");
        $A.util.removeClass(component.find("nameKanaId"),"slds-has-error");
        //おなまえ(漢字・英字)
        var nameKanjiId = component.find("nameKanjiId");
        var nameKanjiValue = component.get("v.nameKanjiValue");
        //nameKanjiId.set("v.errors", null);
        $A.util.removeClass(component.find("nameKanjiValueError"), "show");
        $A.util.removeClass(component.find("nameKanjiId"),"slds-has-error");
        //電話番号
        var phoneId = component.find("phoneId");
        var phoneValue = component.get("v.phoneValue");
        //phoneId.set("v.errors", null);
        $A.util.removeClass(component.find("phoneError1"), "show");
        $A.util.removeClass(component.find("phoneError2"), "show");
        $A.util.removeClass(component.find("phoneId"),"slds-has-error");
        //生年月日
        var birthdayId = component.find("birthdayId");
        var birthdayValue = component.get("v.birthdayValue");
        //birthdayId.set("v.errors", null);
        $A.util.removeClass(component.find("birthdayValueError1"), "show");
        $A.util.removeClass(component.find("birthdayValueError2"), "show");
        $A.util.removeClass(component.find("birthdayId"),"slds-has-error");
        //統合顧客/未統合顧客
        var memberFlagId = component.find("memberFlagId");
        var memberFlagValue = component.get("v.memberFlagValue");
        memberFlagId.set("v.errors", null);
        var notMemberFlagId = component.find("notMemberFlagId");
        var notMemberFlagValue = component.get("v.notMemberFlagValue");
        notMemberFlagId.set("v.errors", null);
        //メールアドレス
        var emailId = component.find("emailId");
        var emailValue = component.get("v.emailValue");
        //emailId.set("v.errors", null);
        //$A.util.removeClass(component.find("emailValueError"), "show");
        //$A.util.removeClass(component.find("emailId"),"slds-has-error");
        //住所
       var addressId = component.find("addressId");
       var addressValue = component.get("v.addressValue");
        //addressId.set("v.errors", null);
        //$A.util.removeClass(component.find("addressValueError"), "show");
        //$A.util.removeClass(component.find("addressId"),"tgcls-ui-text-error");
        //メッセージDivを隠す
        component.set('v.cmpView.areaViewMap.key3','display: none;');
        component.set('v.cmpView.areaViewMap.key4','display: none;');
        //顧客キー項目検索を行う
        if ($A.util.isEmpty(nameKanaValue) 
            && $A.util.isEmpty(nameKanjiValue)
            && $A.util.isEmpty(phoneValue)
            && $A.util.isEmpty(birthdayValue)
            && $A.util.isEmpty(emailValue)
            && $A.util.isEmpty(addressValue)) {
            messageList[messageList.length] = errSchMsg;
            component.set("v.propertyErrorMsg", messageList);
        } else {
            //顧客属性項目検索を行う
            //おなまえ(カナ)
            numberCheck = helper.zenkakuCheck(null, nameKanaValue, 
                messageList, numChkMsg1, false);
            if (numberCheck){
                    $A.util.addClass(component.find("nameKanaValueError1"),"show");
                    $A.util.addClass(component.find("nameKanaId"),"slds-has-error");
                    component.set('v.cmpView.areaViewMap.key3','');
            } else {
                lenList = new Array();
                lenList[0] = 80;
                param = ['80'];
                lengthCheck = helper.checkLength(null, nameKanaValue, 
                    messageList, lenList, helper.putMessageParam(inputLenMsg, param), numberCheck, true);
                if (lengthCheck){
                    $A.util.addClass(component.find("nameKanaValueError2"),"show");
                    $A.util.addClass(component.find("nameKanaId"),"slds-has-error");
                    component.set('v.cmpView.areaViewMap.key3','');
                }
            }
            //おなまえ(漢字・英字)
            lenList = new Array();
            lenList[0] = 135;
            param = ['135'];
            lengthCheck = helper.checkLength(null, nameKanjiValue, 
                messageList, lenList, helper.putMessageParam(inputLenMsg, param), false, true);
            if (lengthCheck){
                $A.util.addClass(component.find("nameKanjiValueError"),"show");
                $A.util.addClass(component.find("nameKanjiId"),"slds-has-error");
                component.set('v.cmpView.areaViewMap.key3','');
            }
            //電話番号
            numberCheck = helper.checkNumberWithHF(null, phoneValue, 
                messageList, true, numChkMsg2, '', false);
            if (numberCheck){
                $A.util.addClass(component.find("phoneError1"),"show");
                $A.util.addClass(component.find("phoneId"),"slds-has-error");
                component.set('v.cmpView.areaViewMap.key3','');
            } else {
                lenList = new Array();
                lenList[0] = 40;
                param = ['40'];
                lengthCheck = helper.checkLength(null, phoneValue, 
                    messageList, lenList, helper.putMessageParam(inputLenMsg, param), numberCheck, true);
                if (lengthCheck){
                    $A.util.addClass(component.find("phoneError2"),"show");
                    $A.util.addClass(component.find("phoneId"),"slds-has-error");
                    component.set('v.cmpView.areaViewMap.key3','');
                }
            }
            
            //生年月日
            lenList = new Array();
            lenList[0] = 8;
            param = ['8'];
            lengthCheck = helper.checkLength(null, birthdayValue, 
                messageList, lenList, helper.putMessageParam(inputLenMsg, param), false, false);
            if (lengthCheck){
                $A.util.addClass(component.find("birthdayValueError2"),"show");
                $A.util.addClass(component.find("birthdayId"),"slds-has-error");
                component.set('v.cmpView.areaViewMap.key3','');
            } else {
                param = ['YYYYMMDD'];
                var dateChk = helper.dateCheck(null, birthdayValue, 
                    messageList, helper.putMessageParam(inputTypeMsg, param));
                if (dateChk){
                    $A.util.addClass(component.find("birthdayValueError1"),"show");
                    $A.util.addClass(component.find("birthdayId"),"slds-has-error");
                    component.set('v.cmpView.areaViewMap.key3','');
                }
            }
            //メールアドレス
            /*lenList = new Array();
            lenList[0] = 80;
            param = ['80'];
            lengthCheck = helper.checkLength(null, emailValue, 
                messageList, lenList, helper.putMessageParam(inputLenMsg, param), false, true);
            if (lengthCheck){
                $A.util.addClass(component.find("emailValueError"),"show");
                $A.util.addClass(component.find("emailId"),"slds-has-error");
                component.set('v.cmpView.areaViewMap.key4','');
            }
            //住所
            param = ['7～255'];
            var addressChk = helper.addressCheck(null, addressValue, 
                messageList, helper.putMessageParam(inputLenMsg, param), 7, 255);
            if (addressChk){
                $A.util.addClass(component.find("addressValueError"),"show");
                $A.util.addClass(component.find("addressId"),"tgcls-ui-text-error");
                component.set('v.cmpView.areaViewMap.key4','');
            }*/
        }
        
        //入力チェックがない場合、相関チェックを行う
        if($A.util.isEmpty(messageList)){
            //顧客属性項目検索を行う
            helper.souKanKokyakuZokuseiCheck(component, messageList, souKanChkMsg1, souKanChkMsg2);
            component.set("v.propertyErrorMsg", messageList);
        }

        if (!$A.util.isEmpty(messageList)) {
            component.set("v.isLoading", false);
            component.set("v.searchResult", null);
            //チェックエラーがある場合、スクロールを一番上まで戻す
            window.scrollTo(0,0);
        } else {
            component.set("v.isLoading", true);
            component.set("v.isLoaded", false);
            var mapToSend = {};
            mapToSend['nameKanaValue'] = nameKanaValue;
            mapToSend['nameKanjiValue'] = nameKanjiValue;
            mapToSend['phoneValue'] = phoneValue;
            mapToSend['birthdayValue'] = birthdayValue;
            mapToSend['emailValue'] = emailValue;
            mapToSend['addressValue'] = addressValue;
            mapToSend['memberFlagValue'] = memberFlagValue;
            mapToSend['notMemberFlagValue'] = notMemberFlagValue;
            helper.searchHelper(component, event, mapToSend);
        }
    },

    openSearchPanel: function (component, event, helper) {
        component.set("v.isOpenedSearchPanel", true);
    },

    closeSearchPanel: function (component, event, helper) {
        component.set("v.isOpenedSearchPanel", false);
    },

    updateColumnSorting: function (cmp, event, helper) {
        cmp.set('v.isSorting', true);
        setTimeout(function() {
            var fieldName = event.getParam('fieldName');
            var sortDirection = event.getParam('sortDirection');
            cmp.set("v.sortedBy", fieldName);
            cmp.set("v.sortedDirection", sortDirection);
            helper.sortData(cmp, fieldName, sortDirection);
            cmp.set('v.isSorting', false);
        }, 0);
    },
    // ポップアップ画面閉じる処理
    popClose: function(component, event, helper) {
        component.set("v.popFlg", false);
    },
    // 顧客キー項目検索項目設定
    setKeySearch: function(component, event, helper) {
        //ガスメーター設置場所番号(1x)
        var no1xId = component.find("no1xId");
        //no1xId.set("v.errors", null);
        $A.util.removeClass(component.find("no1xValueError1"), "show");
        $A.util.removeClass(component.find("no1xValueError2"), "show");
        $A.util.removeClass(component.find("no1xId"),"slds-has-error");
        //支払契約番号(2x)
        //var no2xId = component.find("no2xId");
        //no2xId.set("v.errors", null);
        //お客さま登録番号(3x)
        var no3xId = component.find("no3xId");
        //no3xId.set("v.errors", null);
        $A.util.removeClass(component.find("no3xValueError1"), "show");
        $A.util.removeClass(component.find("no3xValueError2"), "show");
        $A.util.removeClass(component.find("no3xId"),"slds-has-error");
        //ガス使用契約番号(ガス4x)
        var no4xId = component.find("no4xId");
        //no4xId.set("v.errors", null);
        $A.util.removeClass(component.find("no4xValueError1"), "show");
        $A.util.removeClass(component.find("no4xValueError2"), "show");
        $A.util.removeClass(component.find("no4xId"),"slds-has-error");
        //統合顧客ID(AX)
        var axId = component.find("axId");
        //axId.set("v.errors", null);
        $A.util.removeClass(component.find("axValueError1"), "show");
        $A.util.removeClass(component.find("axValueError2"), "show");
        $A.util.removeClass(component.find("axId"),"slds-has-error");
        //mTGログインID
        var mTGIdId = component.find("mTGIdId");
        //mTGIdId.set("v.errors", null);
        $A.util.removeClass(component.find("mTGIdValueError1"), "show");
        $A.util.removeClass(component.find("mTGIdValueError2"), "show");
        $A.util.removeClass(component.find("mTGIdId"),"slds-has-error");
        //メッセージDivを隠す
        component.set('v.cmpView.areaViewMap.key1','display: none;');
        component.set('v.cmpView.areaViewMap.key2','display: none;');
    },
    // 顧客属性項目検索項目設定
    setPropertySearch: function(component, event, helper) {
        //おなまえ(カナ)
        var nameKanaId = component.find("nameKanaId");
        //nameKanaId.set("v.errors", null);
        $A.util.removeClass(component.find("nameKanaValueError1"), "show");
        $A.util.removeClass(component.find("nameKanaValueError2"), "show");
        $A.util.removeClass(component.find("nameKanaId"),"slds-has-error");
        //おなまえ(漢字・英字)
        var nameKanjiId = component.find("nameKanjiId");
        //nameKanjiId.set("v.errors", null);
        $A.util.removeClass(component.find("nameKanjiValueError"), "show");
        $A.util.removeClass(component.find("nameKanjiId"),"slds-has-error");
        //電話番号
        //var phoneId = component.find("phoneId");
        //phoneId.set("v.errors", null);
        $A.util.removeClass(component.find("phoneError1"), "show");
        $A.util.removeClass(component.find("phoneError2"), "show");
        $A.util.removeClass(component.find("phoneId"),"slds-has-error");
        //生年月日
        var birthdayId = component.find("birthdayId");
        //birthdayId.set("v.errors", null);
        $A.util.removeClass(component.find("birthdayValueError1"), "show");
        $A.util.removeClass(component.find("birthdayValueError2"), "show");
        $A.util.removeClass(component.find("birthdayId"),"slds-has-error");
        //統合顧客/未統合顧客
        var memberFlagId = component.find("memberFlagId");
        memberFlagId.set("v.errors", null);
        var notMemberFlagId = component.find("notMemberFlagId");
        notMemberFlagId.set("v.errors", null);
        //メールアドレス
        var emailId = component.find("emailId");
        //emailId.set("v.errors", null);
        //$A.util.removeClass(component.find("emailValueError"), "show");
        //$A.util.removeClass(component.find("emailId"),"slds-has-error");
        //住所
        //var addressId = component.find("addressId");
        //addressId.set("v.errors", null);
        //$A.util.removeClass(component.find("addressValueError"), "show");
        //$A.util.removeClass(component.find("addressId"),"tgcls-ui-text-error");
        //メッセージDivを隠す
        component.set('v.cmpView.areaViewMap.key3','display: none;');
        component.set('v.cmpView.areaViewMap.key4','display: none;');
    },
    clearRedColor : function(component,event,helper){
        //住所
        var addressId = component.find("addressId");
        //addressId.set("v.errors", null);
        $A.util.removeClass(component.find("addressId"),"tgcls-ui-text-error");
    },
    // 顧客キー項目検索項目をクリア
    keyClear : function(component,event,helper){
        component.set("v.no1xValue","");
        component.set("v.no3xValue","");
        component.set("v.no4xValue","");
        component.set("v.axValue","");
        component.set("v.mTGIdValue","");
        $A.enqueueAction(component.get('c.setKeySearch'));
    },
    // 顧客属性項目検索項目をクリア
    propertyClear : function(component,event,helper){
        component.set("v.nameKanaValue","");
        component.set("v.nameKanjiValue","");
        component.set("v.phoneValue","");
        component.set("v.birthdayValue","");
        component.set("v.emailValue","");
        component.set("v.addressValue","");
        component.set("v.memberFlagValue",true);
        component.set("v.notMemberFlagValue",true);
        $A.enqueueAction(component.get('c.setPropertySearch'));
    },
    //errorShow
    errorShow : function (component,event,helper){
    debugger;
	}
    
    //
})