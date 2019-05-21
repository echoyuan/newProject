/*
 * 共通処理
 */
public with sharing class CommonConvertUtil {
    
   /**
    * Null⇒ブランク
    * @param str Object
    * @return str
    */
    public static String toBlank(Object str) {
        if (str == null) {
            return '';
        }
        return (String)str;
    }
    
   /**
    * グローバル選択リスト選択値の取得
    * @param Schema.SObjectField 選択リスト項目API名
    * @return 選択値
    */
    public static String getSelectionValue(Schema.SObjectField field, String code) {
        if (String.isBlank(code)) {
            return '';
        }
        for (PicklistEntry pickitem : field.getDescribe().getPicklistValues()) {
            if (pickitem.isActive() && code == pickitem.getValue()) {
                return pickitem.getLabel();
            }
        }
        return '';
    }
    
    /**
     * ハイフン付きの日付を取得
     * @param str 対象のString
     * @return ハイフン付きの日付
     */
    public static String formatDateStr(String str) {
        if (String.isNotBlank(str)) {
            if (str.indexOf(CommonConstantsUtil.HYPHEN) > -1) {
                return str.replace(CommonConstantsUtil.HYPHEN, CommonConstantsUtil.SLASH_MARK);
            } else if (str.length() == 8) {
                return str.substring(0, 4) + CommonConstantsUtil.SLASH_MARK + str.substring(4, 6) + CommonConstantsUtil.SLASH_MARK + str.substring(6);
            } else if (str.length() == 6) {
                return str.substring(0, 4) + CommonConstantsUtil.SLASH_MARK + str.substring(4);
            }
        }
    	return str;
    }
    
    /**
     * 時刻を取得
     * @param str 対象のString
     * @return フォルマントの日付
     */
    public static String formatTimeStr(String str) {
        if (String.isNotBlank(str)) {
            if (str.length() == 6) {
                return str.substring(0, 2) + CommonConstantsUtil.COLON + str.substring(2,4)
                    + CommonConstantsUtil.COLON + str.substring(4);
            }
        }
        return str;
    }
    
    /**
     * 年月を取得
     * @param str 対象のString
     * @return フォルマントの日付
     */
    public static String formatYearMonthStr(String str) {
        if (String.isNotBlank(str)) {
            if (str.length() == 8) {
                return str.substring(0, 4) + CommonConstantsUtil.SLASH_MARK + str.substring(4,6);
            } else if (str.length() == 10) {
                return str.substring(0, 4) + CommonConstantsUtil.SLASH_MARK + str.substring(5,7);
            }
        }
        return str;
    }
    
    /**
     * ハイフン付きの郵便番号を取得
     * @param str 対象のString
     * @return ハイフン付きの郵便番号
     */
    public static String formatPostNoStr(String str) {
        if (String.isNotBlank(str) && str.length() == 7) {
            return str.substring(0, 3) + CommonConstantsUtil.HYPHEN + str.substring(3);
        }
    	return str;
    }
    
    /**
     * ハイフン付きの番号を取得
     * @param str 対象のString
     * @return ハイフン付きの番号
     */
    public static String formatNoStr(String str) {
        if (String.isNotBlank(str) && str.length() == 11) {
            return str.substring(0, 4) + CommonConstantsUtil.HYPHEN + str.substring(4, 7) + CommonConstantsUtil.HYPHEN + str.substring(7);
        }
    	return str;
    }

	/**
	 * 日付を指定した形式の文字列で取得します。
	 * @param Date target 対象の日付
	 * @param String format 形式 ex) デフォルトでyyyy/MM/dd
	 * @return String 日付文字列
	 */
	public static String format(Date target, String format) {
        if (target == null) {
            return '';
        }
		Datetime dt = Datetime.newInstanceGmt(target.year(), target.month(), target.day());
        String formatTemp = 'yyyy/MM/dd';
        if (String.isNotBlank(format)) {
            formatTemp = format;
        }
		return dt.formatGmt(formatTemp);
	}

	/**
	 * 日時を指定した形式の文字列で取得します。
	 * @param datetime target 対象の日時
	 * @param String format 形式 ex) デフォルトでyyyy/MM/dd
	 * @return String 日時文字列
	 */
	public static String formatDateTime(datetime target, String format) {
        if (target == null) {
            return '';
        }
        String formatTemp = 'yyyy/MM/dd';
        if (String.isNotBlank(format)) {
            formatTemp = format;
        }
		return target.formatGmt(formatTemp);
	}
    
    /**
	 * 時刻を指定した形式の文字列で取得します。YYYY-MM-DDThh:mm:ss+09:00
	 * @param Datetime dt 対象時刻
	 * @return String 時刻文字列
	 */
    public static String formatJpTimezone(Datetime dt, String format) {
        String formatDefault = 'yyyy-MM-dd\'T\'HH:mm:ss+09:00';
        if (String.isNotBlank(format)) {
            formatDefault = format;
        }
        if (dt != null) {
            return dt.formatGmt(formatDefault);
        } else {
            return '';
        }  
    }
    
    /**
	 * 契約電流、契約容量、契約電力の単位
	 * @param String 数字
	 * @param String 単位
	 * @return String 数字+単位
	 */
    public static String addUnit(String item, String unit) {
        if (String.isNotBlank(item)) {  
            return item + unit; 
        } else {
            return '';
        }  
    }

	/**
	 * 対象のObjectのListを、指定した項目でソートし、新しいListを返します。
	 * @param List<Object> target 対象のObjectのList
	 * @param List<String> fields 対象の項目
	 * @param List<Boolean> isDescs 降順ソートするかどうか
	 * @param List<Boolean> isNullsLasts Nullを最後にもっていくかどうか
	 * @return List<Object> ソートした新しいList
	 */
	public static List<Object> sort(List<Object> target, List<String> fields, List<Boolean> isDescs, List<Boolean> isNullsLasts) {
        if (target == null || target.isEmpty()) {
            return target;   
        }
        if (isDescs == null || isNullsLasts == null) {
            return target;
        }
		List<SortHelper> helpers = new List<SortHelper>();
		for (Object so : target) {
            if (so != null) {
                helpers.add(new SortHelper(so, fields, isDescs, isNullsLasts));
            }
		}
		helpers.sort();
		List<Object> result = new List<Object>();
		for (SortHelper helper : helpers) {
			result.add(helper.record);
		}
		return result;
	}

	/**
	 * ソート用のヘルパークラス
	 */
	private class SortHelper implements Comparable {
		/** レコード */
		private Object record;
		/** ソート対象の項目 */
		private String field;
		/** ソート対象の項目 */
		private final List<String> fields;
		/** 降順ソートするか */
		private Boolean isDesc;
		/** 降順ソートするか */
		private final List<Boolean> isDescs;
		/** Nullを最後にもっていくか */
		private Boolean isNullsLast;
		/** Nullを最後にもっていくか */
		private final List<Boolean> isNullsLasts;

		/**
		 * コンストラクタ
		 * @param Object record 対象のレコード
		 * @param List<String> fields ソート対象の項目
		 * @param List<Boolean> isDescs 降順ソートするか
		 * @param List<Boolean> isNullsLasts Nullを最後にもっていくか
		 */
		private SortHelper(Object record, List<String> fields, List<Boolean> isDescs, List<Boolean> isNullsLasts) {
			this.record = record;
			this.fields = fields;
			this.isDescs = isDescs;
			this.isNullsLasts = isNullsLasts;
		}
        
		/**
		 * 対象の項目値を取得する。
		 * @param Object o 比較対象
		 */
        private Map<String, Object> getCompareValue(Object obj){//, String field
            String jsonInstance = Json.serialize(obj);
            Map<String, Object> compareInstance = (Map<String, Object>)JSON.deserializeUntyped(jsonInstance);
            return compareInstance;
            //return compareInstance.get(field);
        }

		/**
		 * 対象の項目で比較します。
		 * @param Object o 比較対象
		 */
		public Integer compareTo(Object o) {
			SortHelper other = (SortHelper) o;
            Object thisValue;
            Object otherValue;
            Map<String, Object> compareInstance1 = getCompareValue(this.record);
            Map<String, Object> compareInstance2 = getCompareValue(other.record);
            for (Integer i = 0;i < this.fields.size(); i++) {
                this.field = this.fields.get(i);
                this.isDesc = this.isDescs.get(i);
                this.isNullsLast = this.isNullsLasts.get(i);
                thisValue = compareInstance1.get(this.field);//getCompareValue(this.record, this.field);this.record.get(this.field);
                otherValue = compareInstance2.get(this.field);//getCompareValue(other.record, this.field);other.record.get(other.field);
                if (toBlank(thisValue).equals(toBlank(otherValue)) && i == this.fields.size() - 1) {
                    return -1;
                } else if (toBlank(thisValue).equals(toBlank(otherValue))) {
                    continue;
                } else if (thisValue == null) {
                    return this.getCompareNum(this.isNullsLast);
                } else if (otherValue == null) {
                    return this.getCompareNum(!this.isNullsLast);
                } else {
                    return this.getCompareNum((String)thisValue > (String)otherValue);
                }
            }
            return 0;
		}

		/**
		 * ソートモードを含めてどちらを前にするかを数値で返します。
		 * @param Boolean このインスタンスのほうが大きいかどうか
		 * @return Integer 降順ソートならばこのインスタンスが大きいかどうかを反転させた数値
		 */
		private Integer getCompareNum(Boolean thisIsLarger) {
			Integer result = thisIsLarger ? 1 : -1;
            if (this.isDesc) {
                return -result;
            }
			return result;
		}
	}
    
    /**
     * 正規表現
     **/
    public static Boolean RegexMatches (String patternParam, String value) {
        Boolean flag = false;
      	Pattern p = Pattern.compile(patternParam);
        Matcher m = p.matcher(value);
        if (m.matches()) {
            flag = true;
        }
        return flag;
    }
    
    /**
     * ガスメータ設置箇所情報取得
     * @param meterInfo List<CommonGasMeterSetResponseDto>
     * @param returnMap Map<String, String>
     * @param status String
     * @return Map<String, String>
     **/
    public static Map<String, String> getGasMeterInfo (
        List<CommonGasMeterSetResponseDto> meterInfo 
        , Map<String, String> returnMap
        , String status) {
        // システム日付より小さいレコードを残すようにすること
        //List<CommonGasMeterSetResponseDto> meterInfo = new List<CommonGasMeterSetResponseDto>();
        date sysDate = date.today();
        if (meterInfo != null && !meterInfo.isEmpty()) {
            String statusH = '契約中(開栓中)';
            String statusC = '解約済(開栓中)';
            if (meterInfo.size() > 1 && String.isNotBlank(status) && status.indexOf('契約中') > -1) {
                statusH = '契約中(開栓中あり)';
                statusC = '契約中(閉栓中)';
            } else if (meterInfo.size() > 1 && String.isNotBlank(status) && status.indexOf('解約済') > -1) {
                statusH = '解約済(開栓中あり)';
                statusC = '解約済(閉栓中)';
            }
            List<String> gmtYmdStartList = new List<String>();
            List<String> gmtYmdCloseList = new List<String>();
            //List<String> gmtYmdStartForCloseList = new List<String>();
            for (CommonGasMeterSetResponseDto meter : meterInfo) {
                // いずれかのガスメータ開閉栓状態が開栓中の場合は「開栓中あり」
                if (CommonConstantsUtil.GMT_STATUS_OPENING.equals(meter.gmtStatus)) {
                    returnMap.put('status', statusH);
                    // 開栓中のガスメータが1つでも存在する場合はブランク
                    returnMap.put('gmtYmdEnd', '');
                    if (String.isNotBlank(meter.ksenYmd)) {
                        gmtYmdStartList.add(meter.ksenYmd);
                    }
                } else if (CommonConstantsUtil.GMT_STATUS_CLOSING.equals(meter.gmtStatus)) {
                    gmtYmdCloseList.add(meter.hsenYmd);
                }
                /*if (String.isNotBlank(meter.ksenYmd)) {
                    gmtYmdStartForCloseList.add(meter.ksenYmd);
                }*/
                // すべてのガスメータ開閉栓状態が閉栓中の場合、開栓日を保持するため設定する
                if (String.isNotBlank(meter.ksenYmd)) {
                    gmtYmdStartList.add(meter.ksenYmd);
                }
            }
            // すべてのガスメータ開閉栓状態が閉栓中の場合は「閉栓中」
            if (gmtYmdCloseList.size() == meterInfo.size()) {
                returnMap.put('status', statusC);
                if (String.isNotBlank(status) && status.indexOf('解約済') > -1) {
                    gmtYmdCloseList.sort();
                    // すべて閉栓中の場合、一番最新の閉栓日を表示
                    returnMap.put('gmtYmdEnd', CommonConvertUtil.formatJpTime(gmtYmdCloseList.get(gmtYmdCloseList.size() - 1)));
                }
                /*gmtYmdStartForCloseList.sort();
                // 一番過去の開栓日を表示
                returnMap.put('gmtYmdStart', gmtYmdStartForCloseList.get(0));*/
            }
            if (!gmtYmdStartList.isEmpty()) {
                gmtYmdStartList.sort();
                // 開栓中のガスメータのうち、一番過去の開栓日を表示
                returnMap.put('gmtYmdStart', gmtYmdStartList.get(0));
            }
        }
        return returnMap;
    }
    
    /**
     * メール送信
     * @param className クラス名
     * @param mailAddress 送信アドレス
     * @param subject メールタイトル
     * @param e 異常
     **/
    /*public static void toMail(String className, String[] mailAddress, String subject, Exception e) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(mailAddress);
        if (String.isBlank(subject)) {
            mail.setSubject('TG-CRMシステムエラー');
        } else {
            mail.setSubject(subject);
        }
        mail.setSaveAsActivity(false);
        //mail.setCharset('Shift-JIS');
        String err = System.Label.SYSTEM_ERROR_MESSAGE + '\r\n\r\n';
        err += '【クラス名】:' + className + '\r\n';
        if (e != null) {
            err += '【エラーメッセージ】:' + e.getMessage() + '\r\n';
            err += '【スタックトレース】:' + e.getStackTraceString() + '\r\n';
        }
        mail.setPlainTextBody(err);
        Messaging.sendEmail(new Messaging.Email[] { mail });
    }*/
    
    /**
     * メール送信
     * @param errInfo エラー内容
     * @param subject メールタイトル
     * @param mailAddress 送信アドレス
     **/
    /*public static void toMail(String errInfo, String subject, String[] mailAddress) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(mailAddress);
        if (String.isBlank(subject)) {
            mail.setSubject('TG-CRMシステムエラー（バッチ）');
        } else {
            mail.setSubject(subject);
        }
        mail.setSaveAsActivity(false);
        //mail.setCharset('Shift-JIS');
        mail.setPlainTextBody(errInfo);
        Messaging.sendEmail(new Messaging.Email[] { mail });
    }*/
    
    /**
     * 環境変数_APIリクエスト共通パラメータの取得
     * @param developerName リクエストタイプ
     * @return Map<String, String>
     **/
    public static Map<String, String> getEnvApiRequestCommon(String developerName) {
        List<EnvApiRequestCommon__mdt> recordInfo = [
            SELECT 
                Domain__c
                , Protocol__c
                , EnvironmentPath__c
                , ApiSubscriptionKey__c FROM EnvApiRequestCommon__mdt WHERE DeveloperName =: developerName Limit 1];
        if (recordInfo != null && !recordInfo.isEmpty()) {
            Map<String, String> info = new Map<String, String>();
            // ドメインURL
            info.put('domainUrl', recordInfo.get(0).Domain__c);
            // プロトコル
            info.put('protocol', recordInfo.get(0).Protocol__c);
            // セキュリティキー
            info.put('securityKey', recordInfo.get(0).ApiSubscriptionKey__c);
            // 環境Path
            info.put('environmentPath', recordInfo.get(0).EnvironmentPath__c);
            return info;
        }
        return null;
    }
    
    /**
     * APIリクエストパラメータの取得
     * @param developerName リクエストタイプ
     * @return Map<String, Object>
     **/
    public static Map<String, Object> getApiRequest(String developerName) {
        List<ApiRequest__mdt> recordInfo = [
            SELECT 
                TimeOutTime__c
                , RetryCount__c
                , RetryIntervalTime__c
                , UrlPath__c
                    , LogOutputLevel__c FROM ApiRequest__mdt WHERE DeveloperName =: developerName Limit 1];
        if (recordInfo != null && !recordInfo.isEmpty()) {
            Map<String, Object> info = new Map<String, Object>();
            // sendのtimeout時間
            info.put('inOutTimeOut', recordInfo.get(0).TimeOutTime__c);
            // sendのリトライ間隔時間
            info.put('inOutSleepTime', recordInfo.get(0).RetryIntervalTime__c);
            // sendのリトライ回数
            info.put('inOutLoopCnt', recordInfo.get(0).RetryCount__c);
            // ログ出力重要度
            info.put('notificationLevel', recordInfo.get(0).LogOutputLevel__c);
            // SubApiパス
            info.put('subUrl', recordInfo.get(0).UrlPath__c);
            return info;
        }
        return null;
    }
    
   /**
    * Object⇒Integer
    * @param str Object
    * @return Integer
    */
    public static Integer toInteger(Object str) {
        if (str == null) {
            return null;
        }
        return Integer.valueOf(str);
    }
    
    /**
     * API通信エラーログ登録
     * 
     * @param request
     *       リクエスト
     * @param response
     *       レスポンス
     * @param ex
     *       異常
     * @param className
     *       クラス名
     * @param caseNumber
     *       ケース番号
     * @param caseId
     *       ケース
     * @param notificationLevel
     *       ログレベル
     * @param apiLogInfoList
     *       ログ出力リスト
     * */
    public static void addApiLog(
        HttpRequest request
        , HttpResponse response
        , Exception ex
        , String className
        , String caseNumber
        , String caseId
        , Integer notificationLevel
        , List<Map<String,Object>> apiLogInfoList) {
            Map<String,Object> apiLogInfo = new Map<String,Object>();
            apiLogInfo.put('request', request);
            apiLogInfo.put('response', response);
            apiLogInfo.put('ex', ex);
            apiLogInfo.put('className', className);
            apiLogInfo.put('caseNumber', caseNumber);
            apiLogInfo.put('caseId', caseId);
            apiLogInfo.put('notificationLevel', notificationLevel);
            apiLogInfoList.add(apiLogInfo); 
        }
    
    /**
	 * 時刻を指定した形式の文字列で取得します。YYYY-MM-DDThh:mm:ss+09:00
	 * @param String dt 対象時刻
	 * @return String 時刻文字列
	 */
    public static String formatJpTime(String dtInput) {
        String dt = getDateTimeString(dtInput);
        if (String.isBlank(dt)) {
            return '';
        }
        if (dtInput.contains('T') || dtInput.length() < 10) {
            return dtInput;
        }
        return formatJpTimezone(Datetime.valueOfGmt(dt), 'yyyy/MM/dd\'T\'HH:mm:ss+09:00');
    }
    
    /**
	 * 時刻を指定した形式の文字列で取得します。YYYY-MM-DD hh:mm:ss
	 * @param String dt 対象時刻
	 * @return String 時刻文字列
	 */
    public static String getDateTimeString(String dtInput) {
        if (String.isBlank(dtInput)) {
            return null;
        }
        if (dtInput.contains('T') || dtInput.length() < 10) {
            return dtInput;
        }
        String timeOutput = dtInput;
        if (dtInput.length() == 10) {
            timeOutput = dtInput + ' 00:00:00';
        } else if (dtInput.length() > 10 && dtInput.indexOf(CommonConstantsUtil.HALF_SPACE) > -1) {
            String timeInput = dtInput.substring(dtInput.indexOf(CommonConstantsUtil.HALF_SPACE) + 1);
            if (String.isBlank(timeInput)) {
                timeOutput = dtInput.replace(CommonConstantsUtil.HALF_SPACE, '') + ' 00:00:00';
            } else {
                List<String> timeInputArray = timeInput.split(CommonConstantsUtil.COLON);
                timeOutput = dtInput.substring(0, dtInput.indexOf(CommonConstantsUtil.HALF_SPACE));
                if (timeInputArray != null && !timeInputArray.isEmpty()) {
                    List<String> timeOutputList = new List<String>();
                    for (String arr : timeInputArray) {
                        timeOutputList.add(arr);
                    }
                    if (timeOutputList.size() == 1) {
                        timeOutput = timeOutput + CommonConstantsUtil.HALF_SPACE + timeOutputList.get(0) + ':00:00';
                    } else if (timeOutputList.size() == 2) {
                        timeOutput = timeOutput + CommonConstantsUtil.HALF_SPACE + String.join(timeOutputList, CommonConstantsUtil.COLON) + ':00';
                    } else {
                        timeOutput = timeOutput + CommonConstantsUtil.HALF_SPACE + String.join(timeOutputList, CommonConstantsUtil.COLON);
                    }
                }
            }
        }
        timeOutput = timeOutput.replace(CommonConstantsUtil.SLASH_MARK, CommonConstantsUtil.HYPHEN);
        return timeOutput;
    }
    
    /**
	 * 顧客住所の更新を行う
	 * @param List<String> Ids IDリスト
	 */
    @InvocableMethod
    public static void convertAddressCharacterForProcess (List<String> Ids) {
        List<Account> accountList = [SELECT Address__c, SearchAddress__c FROM Account WHERE Id IN : Ids];
        if (accountList != null && !accountList.isEmpty()) {
            String convertAddress = '';
            if (String.isNotBlank(accountList[0].Address__c)) {
                convertAddress = convertCharacter(accountList[0].Address__c);
            }
            accountList[0].SearchAddress__c = convertAddress;
            update accountList;
        }
    }
    
    /**
	 * 住所変更ルールにより、変換処理を行う
	 * @param String addressStr 対象文字列
	 * @return String 文字列
	 */
    public static String convertCharacter(String addressStr) {
        String address = addressStr;
        if (String.isNotBlank(address)) {
            List<Map<String, String>> regexpMapList = new List<Map<String, String>>();
            //検索用住所変換検索
            List<SearchAddressCleansing__mdt> recordListInfo = [
                SELECT DeveloperName , MasterLabel , ReplacementString__c FROM SearchAddressCleansing__mdt
            ];
            if (recordListInfo != null && !recordListInfo.isEmpty()) {
                for (SearchAddressCleansing__mdt recordInfo : recordListInfo) {
                    //置換文字列の取得
                    String replacementString = recordInfo.ReplacementString__c;
                    if (String.isNotBlank(replacementString)) {
                        //文字列リストの取得（改行でスプリト）
                        List<String> replacementList = replacementString.split(CommonConstantsUtil.SPLIT_LINE_CODE, -2);
                        for (Integer i = 0; i < replacementList.size(); i++) {
                            String replacement = replacementList[i];
                            if (String.isNotBlank(replacement)) {
                                //正規表現用Map
                                Map<String, String> regexpMap = new Map<String, String>();
                                String key = '';
                                String regexp = '';
                                //コンマ置換、二重引用符置換
                                replacement = replacement.replace(CommonConstantsUtil.COMMA_SPECIAL_CODE, CommonConstantsUtil.COMMA_SPECIA_CODE_CONVERT)
                                    .replace(CommonConstantsUtil.DOUBLE_QUOTES_SPECIAL_CODE, CommonConstantsUtil.DOUBLE_QUOTES_STRING);
                                //置換先
                                key = replacement.split(CommonConstantsUtil.COMMA_MARK)[0]
                                    .replace(CommonConstantsUtil.DOUBLE_QUOTES_MARK, '');
                                //正規表現regExp
                                regexp = escapeExprSpecialWord(replacement)
                                    .replace(CommonConstantsUtil.COMMA_MARK, CommonConstantsUtil.OR_MARK)
                                    .replace(CommonConstantsUtil.DOUBLE_QUOTES_MARK, '')
                                    .replace(CommonConstantsUtil.DOUBLE_QUOTES_STRING, CommonConstantsUtil.DOUBLE_QUOTES_MARK)
                                    .replace(CommonConstantsUtil.COMMA_STRING, CommonConstantsUtil.COMMA_MARK);

                                if (key == '') {
                                    regexp = regexp.substring(1);
                                }
                                regexpMap.put(key, regexp);
                                regexpMapList.add(regexpMap);
                            }
                        } 
                    }
                }
                if (regexpMapList != null && regexpMapList.size() > 0) {
                    for (Map<String, String> regexpMap : regexpMapList) {
                        Set <String> keySet = new Set<String>();
						keySet = regexpMap.keySet();
                        for (String key : keySet) {
                            String regexp = regexpMap.get(key);
                            //正規表現 regexp に一致する文字列を置換
                            address = address.replaceAll(regexp, key);
                        }
                    } 
                }
             } 
        }
       	return address;
	}
    
    /**
    * エスケープ用メソッド
    * 
    * @param keyword
    * @return　エスケープ結果
    */
    public static String escapeExprSpecialWord(String keyword) {
        if (String.isNotBlank(keyword)) {
            String[] fbsArr = new String[] { '\\', '$', '(', ')', '*', '+', '.', '[', ']', '?', '^', '{', '}', '|' };
                for (String key : fbsArr) {
                    if (keyword.contains(key)) {
                        keyword = keyword.replace(key, '\\' + key);
                    }
                }
        }
        return keyword;
    }
    
   /**
    * 実行中ユーザーがバッチ実行ユーザーであるか
    * @return Boolean
    */
    @TestVisible public static Boolean isBatchUser() {
        List<Profile__mdt> profileList = [SELECT ProfileName__c, 
                                          DeveloperName FROM Profile__mdt 
                                          WHERE DeveloperName =: CommonConstantsUtil.BATCHUSER Limit 1];
        if (profileList != null && !profileList.isEmpty()) {
            if (userInfo.getName() == profileList.get(0).ProfileName__c) {
                return true;
            }
        }
        return false;
    }
    
   /**
    * プロファイル名の取得
    * @return List<Profile__mdt>
    */
    @TestVisible public static List<Profile__mdt> getProfiles() {
        List<Profile__mdt> profileList = [SELECT ProfileName__c, OpenCloseSwitchingFlag__c, DeveloperName FROM Profile__mdt];
        return profileList;
    }
    
   /**
    * ToDo依頼先チーム情報の取得
    * @return List<ToDoRequestTeam__mdt>
    */
    @TestVisible public static List<ToDoRequestTeam__mdt> getToDoRequestTeams() {
        List<ToDoRequestTeam__mdt> teamList = [SELECT DeveloperName, ToDoRequestQueName__c, ToDoRequestTeamName__c FROM ToDoRequestTeam__mdt];
        return teamList;
    }
    
   /**
    * キュー情報の取得
    * @param queueName String
    * @return List<QueueSobject>
    */
    public static List<QueueSobject> getQueueInfo(String queueName) {
        List<QueueSobject> queueList = [SELECT SobjectType, Queue.Name, 
                                        Queue.ID, Queue.DeveloperName 
                                        FROM QueueSobject 
                                        WHERE Queue.DeveloperName =: queueName Limit 1];
        return queueList;
    }
}