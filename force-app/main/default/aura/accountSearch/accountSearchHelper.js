({  
    // 初期化処理
    initHandler: function(component, event, helper) {
        component.set("v.errorMsg", null);
        var action = component.get("c.initCmpView");
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                if (response.code == 0) {
                    component.set("v.cmpView", response.displayInfo);
                }
            } else {
                component.set("v.popFlg", true);
            }
        });
        // アクションを行う
        $A.enqueueAction(action);
    },
    searchHelper: function(component, event, mapToSend) {
        //エラーメッセージ定義
        var errLimitMsg = '検索結果が200件を超えているため、絞り込み条件を追加して再検索を実施してください';
        var errNoResultMsg = '該当する顧客が存在しません';
        var action = component.get("c.fetchAccount");
        action.setParams({
            'nameKana': mapToSend['nameKanaValue']
            ,'nameKanji': mapToSend["nameKanjiValue"]
            ,'ax': mapToSend['axValue']
            ,'phone': mapToSend['phoneValue']
            ,'birthday': mapToSend['birthdayValue']
            ,'address': mapToSend['addressValue']
            ,'memberFlag': mapToSend['memberFlagValue']
            ,'notMemberFlag': mapToSend['notMemberFlagValue']
            ,'no1x': mapToSend['no1xValue']
            ,'no2x': mapToSend['no2xValue']
            ,'no3x': mapToSend['no3xValue']
            ,'no4x': mapToSend['no4xValue']
            ,'emailValue': mapToSend['emailValue']
            ,'mTGIdValue': mapToSend['mTGIdValue']
       });
        action.setCallback(this, function(data) {
            var response = data.getReturnValue();
            if (action.getState() == "SUCCESS" && response.code != 100) {
                var returnList = response.displayInfo;
                if (response.code == 0) {
                    if (returnList.length > 200) {
                        component.set("v.searchResultMsg", errLimitMsg);
                        component.set("v.searchResult", null);
                        component.set("v.numberOfRecord", 0);
                    } else {
                        component.set("v.numberOfRecord", returnList.length);
                        component.set("v.searchResult", returnList);
                        component.set("v.isOpenedSearchPanel", false);
                    }
                } else if (response.code == 40) {
                    component.set("v.searchResultMsg", errNoResultMsg);//response.message
                    component.set("v.numberOfRecord", 0);
                    component.set("v.searchResult", null);
                }
            } else {
                component.set("v.numberOfRecord", 0);
                component.set("v.searchResult", null);
                component.set("v.popFlg", true);
                component.set("v.isLoading", false);
            }
            component.set("v.isLoaded", true);
        });
        $A.enqueueAction(action);
    },
    sortData: function (cmp, fieldName, sortDirection) {
        var data = cmp.get("v.searchResult");
        var reverse = sortDirection !== 'asc';

        data = Object.assign([],
            data.sort(this.sortBy(fieldName, reverse ? -1 : 1))
        );
        cmp.set("v.searchResult", data);
    },
    sortBy: function (field, reverse, primer) {
        var key = primer
            ? function(x) { return primer(x[field]) }
            : function(x) { return x[field] };

        return function (a, b) {
            var valueA = key(a);
            var valueB = key(b);
            return reverse * ((valueA > valueB) - (valueB > valueA));
        };
    },
    /**
      * 数字、ハイフンチェック
      * @param cmpField　フィールド
      * @param cmpValue　入力値
      * @param messageList　エラーメッセージリスト
      * @param hfFlg　ハイフン有無チェックフラグ
      * @param message　エラーメッセージ
      * @returns
      */
    checkNumberWithHF: function(cmpField, cmpValue, messageList, hfFlg, message, 
        strDefine, checkFlg) {
        if($A.util.isEmpty(cmpValue) || checkFlg) {
            return false;
        }
        var regu = '^[0-9]*$';
        if (hfFlg) {
            regu = '^[0-9-]*$';
        }
        var regExp = new RegExp(regu);
        var checkValue = cmpValue;
        if(!$A.util.isEmpty(strDefine)){
            checkValue = cmpValue.replace(strDefine, '');
        }
        if (!regExp.test(checkValue)) {
            return this.setMessage(cmpField, messageList, message);
        }
        return false;
    },
    /**
      * 長さチェック
      * @param cmpField　フィールド
      * @param cmpValue　入力値
      * @param messageList　エラーメッセージリスト
      * @param lenList　許容する文字数リスト→11,13等
      * @param message　エラーメッセージ
      * @param checkFlg　チェック必要フラグ
      * @param maxInput　最大入力チェックフラグ
      * @returns
      */
    checkLength: function(cmpField, cmpValue, messageList, lenList, message, checkFlg, maxInput) {
        if ($A.util.isEmpty(cmpValue) || checkFlg) {
            return false;
        }
        var valLen = cmpValue.length;
        var checkResult = false;
        for(var i=0; i < lenList.length ;i++ ){
            if (maxInput) {
                if (valLen <= lenList[i]) {
                    checkResult = true;
                    break;
                }
            } else if (valLen == lenList[i]) {
                checkResult = true;
                break;
            }
        }
        if (!checkResult) {
            return this.setMessage(cmpField, messageList, message);
        }
        return false;
    },
    /**
      * 日付チェック
      * @param cmpField　フィールド
      * @param cmpValue　入力値
      * @param messageList　エラーメッセージリスト
      * @param message　エラーメッセージ
      * @returns
      */
    dateCheck : function(cmpField, cmpValue, messageList, message) {
        if(!$A.util.isEmpty(cmpValue)){
            //var dateValue = $A.localizationService.parseDateTime(cmpValue, 'YYYY/MM/DD');
            //if(dateValue == null){
            //    return this.setMessage(cmpField, messageList, message);
            //}
            //if(cmpValue.length < 10){
            //    return this.setMessage(cmpField, messageList, message);
            //}
            var dateStr = cmpValue.replace(/-/g,'/');
            //var yymmddReg = /[\d]{4}[\/][\d]{2}[\/][\d]{2}/g;
            var yymmddReg = /[\d]{4}[\d]{2}[\d]{2}/g;
            var regResult = dateStr.replace(yymmddReg,'');
            if(!$A.util.isEmpty(regResult)){
                return this.setMessage(cmpField, messageList, message);
            }
            //var strOne = dateStr.indexOf('/');
            //var strTwo = dateStr.lastIndexOf('/');
            var yearStr = dateStr.substring(0,4);//strOne
            var monthStr = dateStr.substring(4,6);//strOne+1,strTwo
            var dayStr = dateStr.substring(6);//strTwo+1
            var yearNum = this.getIntValue(yearStr);
            var monthNum = this.getIntValue(monthStr);
            var dayNum = this.getIntValue(dayStr);
            if(yearNum == 0 || monthNum == 0 
               || dayNum == 0 || !this.validateMonth(monthNum)){
                return this.setMessage(cmpField, messageList, message);
            }
            if (!this.validateDay(yearNum,monthNum,dayNum)) {
                return this.setMessage(cmpField, messageList, message);
            }
            return false;
        }
    },
    /**
      * int値を取得
      * @param str
      * @returns
      */
    getIntValue : function(str) {
        if(str.replace(/^0+/g,'') == ''){
            return 0;
        }
        return str.replace(/^0+/g,'');
    },
    /**
      * 月をチェック
      * @param month_num 月?
      * @returns
      */
    validateMonth : function(monthNum) {
        if(monthNum > 12 || monthNum < 1){
            return false;
        }
        return true;
    },
    /**
      * 日付をチェック
      * @param yearNum 年
      * @param monthNum 月
      * @param dayNum 日
      * @returns
      */
    validateDay : function(yearNum,monthNum,dayNum) {
        if((monthNum == 1 || monthNum == 3 || monthNum == 5 || monthNum == 7
            ||monthNum == 8 || monthNum == 10 || monthNum == 12) && dayNum > 31){
            return false;
        }else if((monthNum == 4 || monthNum == 6 || monthNum == 9 || monthNum == 11)
                 && dayNum > 30){
            return false;
        }else if(monthNum == 2){
            if(yearNum % 4 == 0 && (yearNum % 100 != 0 || yearNum % 400 == 0) && dayNum > 29){
                return false;
            }else if(dayNum > 28){
                return false;
            }
        }
        return true;
    },
    /**
      * 全角カナチェック
      * @param cmpField　フィールド
      * @param cmpValue　入力値
      * @param messageList　エラーメッセージリスト
      * @param message　エラーメッセージ
      * @param checkFlg　チェック必要フラグ
      * @returns
      */
    zenkakuCheck : function(cmpField, cmpValue, messageList, message, checkFlg) {
        if ($A.util.isEmpty(cmpValue) || checkFlg) {
            return false;
        }
        if (!cmpValue.match(/^[\u30a1-\u30f6　 ー]+$/)){
            return this.setMessage(cmpField, messageList, message);
        }
        return false;
    },
    /**
      * 住所チェック：入力範囲５～２５５桁
      * @param cmpField　住所フィールド
      * @param cmpValue　住所入力値
      * @param messageList　エラーメッセージリスト
      * @param message　エラーメッセージ
      * @returns
      */
    addressCheck : function(cmpField, cmpValue, messageList, message, from, to) {
        if (!$A.util.isEmpty(cmpValue) 
            && (cmpValue.length < from || cmpValue.length > to)) {
            return this.setMessage(cmpField, messageList, message);
        }
        return false;
    },
    /**
      * 画面項目にエラー設定
      * @param cmpField
      * @param messageList　エラーメッセージリスト
      * @param message　エラーメッセージ
      * @returns
      */
    setMessage : function(cmpField, messageList, message) {
        if (cmpField != null) {
            cmpField.set("v.errors", [{
                message: message
            }]);
        }
        messageList[messageList.length] = message;
        return true;
    },
    /**
      * 顧客キー項目検索で相関チェックのエラー設定
      * @param cmp
      * @param messageList　エラーメッセージリスト
      */
    souKanKokyakuKeyCheck : function(cmp, messageList) {
        var cnt = 0;
        if (!$A.util.isEmpty(cmp.get("v.no1xValue"))) {
            cnt = cnt + 1;
        }
        if (!$A.util.isEmpty(cmp.get("v.no2xValue"))) {
            cnt = cnt + 1;
        }
        if (!$A.util.isEmpty(cmp.get("v.no3xValue"))) {
            cnt = cnt + 1;
        }
        if (!$A.util.isEmpty(cmp.get("v.no4xValue"))) {
            cnt = cnt + 1;
        }
        if (!$A.util.isEmpty(cmp.get("v.axValue"))) {
            cnt = cnt + 1;
        }
        if (!$A.util.isEmpty(cmp.get("v.mTGIdValue"))) {
            cnt = cnt + 1;
        }
        if (cnt > 1) {
            // 2項目以上の入力がある場合にエラー
            messageList[messageList.length] = '・顧客キーは、1項目のみ入力して下さい';
        }
    },
    /**
      * 顧客属性項目検索で相関チェックのエラー設定
      * @param cmp
      * @param messageList　エラーメッセージリスト
      * @param souKanChkMsg1　エラーメッセージ
      * @param souKanChkMsg2　エラーメッセージ
      */
    souKanKokyakuZokuseiCheck : function(cmp, messageList, souKanChkMsg1, souKanChkMsg2) {
        var tenMark = '・';
        var param = [];
        if (!$A.util.isEmpty(cmp.get("v.nameKanaValue")) 
            && !this.getPersonInput(cmp)) {
            // おなまえ(カナ)が入力されている場合、電話番号、メールアドレス、住所の入力は必須
            param = ['おなまえ(カナ)'];
            messageList[messageList.length] = tenMark + this.putMessageParam(souKanChkMsg1, param);
        }
        if (!$A.util.isEmpty(cmp.get("v.nameKanjiValue")) 
            && !this.getPersonInput(cmp)) {
            param = ['おなまえ(漢字・英字)'];
            // おなまえ(漢字・英字)が入力されている場合、電話番号、メールアドレス、住所の入力は必須
            messageList[messageList.length] = tenMark + this.putMessageParam(souKanChkMsg1, param);
        }
        if (!$A.util.isEmpty(cmp.get("v.birthdayValue")) 
            && !this.getPersonInput(cmp)) {
            param = ['生年月日'];
            // 生年月日が入力されている場合、電話番号、メールアドレス、住所の入力は必須
            messageList[messageList.length] = tenMark + this.putMessageParam(souKanChkMsg1, param);
        }
        if (!cmp.find('memberFlagId').get("v.value") 
            && !cmp.find('notMemberFlagId').get("v.value")) {
            //統合顧客/未統合顧客はどちらかのチェックは必須
            messageList[messageList.length] = tenMark + souKanChkMsg2;
        }
    },
    /**
      * 未入力フラグを取得
      * @param cmp
      * @returns 未入力フラグ
      */
    getPersonInput : function(cmp) {
        if ($A.util.isEmpty(cmp.get("v.phoneValue")) 
            && $A.util.isEmpty(cmp.get("v.emailValue"))
            && $A.util.isEmpty(cmp.get("v.addressValue"))) {
            return false
        }
        return true;
    },
    /**
      * メッセージの可変パラメータの設定
      * @param msg
      * @param param
      * @returns msgTemp
      */
    putMessageParam : function(msg, param){
        var msgTemp = msg;
        for(var i = 0; i<param.length ; i++) {
            var comStr = '$' +( i + 1);
            msgTemp = msgTemp.split(comStr).join(param[i])
        }
        return msgTemp;
    }
})