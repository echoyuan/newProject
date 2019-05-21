/**
 * 顧客検索画面用コントローラ
 */
public with sharing class AccountSearchController {
   
    //ー（長音）、‐（全角ハイフン）、－（全角マイナス）、 （半角ダッシュ）、
    // （全角ダッシュ）、―（ホリゾンタルバー）、"（負符号、減算記号）
    private static final Set<String> convertList = new Set<String>{'ー', '‐', '－' , ' ' ,' ' ,'―' ,'"'};
        
    /**
     * 全角数字マップ
     * Map<全角数字, 半角数字>
     */
    private static final Map<String, String> alphaNumberMap = new Map<String, String>{
        '０' => '0',
        '１' => '1',
        '２' => '2',
        '３' => '3',
        '４' => '4',
        '５' => '5',
        '６' => '6',
        '７' => '7',
        '８' => '8',
        '９' => '9'
    };
    
   /**
     * 画面表示項目のクラスです
     */
    public with sharing class CmpView {
        
        // Map<Api, Length>
        @AuraEnabled public Map<String, Integer> apiLengthMap {get;set;}
        
        // Map<key, isDisplayable>
        @AuraEnabled public Map<String, String> areaViewMap {get;set;}
        
        /**
         * コンストラクタです。
         */
        public CmpView() {
            Schema.DescribeSObjectResult accountSr = Account.SObjectType.getDescribe();
            Map<String, Schema.SObjectField> fMap = accountSr.fields.getMap();
            Schema.DescribeFieldResult fr;
            this.apiLengthMap = new Map<String, Integer>();
            this.areaViewMap = new Map<String, String>();
            this.areaViewMap.put('key1', 'display: none;');
            this.areaViewMap.put('key2', 'display: none;');
            this.areaViewMap.put('key3', 'display: none;');
            this.areaViewMap.put('key4', 'display: none;');
            for (String fieldKey : fMap.keySet()) {
                fr = fMap.get(fieldKey).getDescribe();
                if ((fr.isAutoNumber() || fr.isCreateable()) && fr.isAccessible()) {
                    this.apiLengthMap.put(fieldKey, fr.getLength());
                }
            }
        }
    }

    /**
     * 初期化処理
     */
    @AuraEnabled
    public static CommonResponseDto initCmpView() {
        CmpView cmpView = new CmpView();
        return new CommonResponseDto(0, null, cmpView);
    }
        
    @AuraEnabled
    public static CommonResponseDto fetchAccount(
        String nameKana
        , String nameKanji
        , String ax
        , String phone
        , String birthday
        , String address
        , boolean memberFlag
        , boolean notMemberFlag
        , String no1x
        , String no2x
        , String no3x
        , String no4x
        , String emailValue
        , String mTGIdValue
        ) {
        List<Map<String, Object>> returnList = new List<Map<String, Object>>();
        try {
            // 顧客ID
            Set<String> customerIdSet = new Set<String>();
            if (String.isNotBlank(no1x)
                || String.isNotBlank(no3x)
                || String.isNotBlank(no4x)
                || String.isNotBlank(mTGIdValue)) {
                    // サービス種別
                    List<String> services = getServiceTypes(no1x, no3x, no4x, mTGIdValue);
                    // サービス契約キー
                    List<String> keys = getServiceKeys(no1x, no3x, no4x, mTGIdValue);
                    CommonKeySearchApi searchApi = new CommonKeySearchApi(services, keys);
                    // リクエストの発送
                    searchApi.send();
                    // 共通メソッドで顧客IDの取得
                    List<List<CommonKeySearchResponseDto>> constractList = searchApi.getCustomerKey();
                    if (constractList != null && !constractList.isEmpty()) {
                        for (List<CommonKeySearchResponseDto> dtoList : constractList) {
                            if (dtoList != null && !dtoList.isEmpty()) {
                                for (CommonKeySearchResponseDto dto : dtoList) {
                                    if ('013'.equals(dto.serviceType) && String.isNotBlank(dto.userKey)) {
                                        customerIdSet.add('\'' + dto.userKey + '\'');
                                    }
                                }
                            }
                        }
                    }
                }
            String sQuery = 'SELECT Id, Status__c, Name, NameOfKanji__c, IntegratedClientID__c, '
                + ' LastName, FirstName, Birthdate__c, Phone, PhoneNumber1__c, '
                + ' Address__c, Email1__c, ClientStatus__c, ClientIconView__c FROM Account';
            Set<String> whereQuery = new Set<String>{};
            // ガスメーター設置場所番号(1x)
            // お客さま登録番号(3x)
            // ガス使用契約番号(4x)
            // mTGログインID
            if ((String.isNotBlank(no1x)
                || String.isNotBlank(no3x)
                || String.isNotBlank(no4x)
                || String.isNotBlank(mTGIdValue)) 
                && customerIdSet.isEmpty()) {
                    return new CommonResponseDto(40, '顧客情報取得失敗', null);
            }
            if (!customerIdSet.isEmpty()) {
                whereQuery.add('ClientId__c in (' + String.join(new List<String>(customerIdSet), ',') + ')');
            }
            //統合顧客ID(Ax)
            if (String.isNotBlank(ax)) {
                whereQuery.add('IntegratedClientID__c = \'' + trimSpaceLR(ax) + '\'');
            }
            //おなまえ(カナ)
            if (String.isNotBlank(nameKana)) {
                whereQuery.add('SearchName__c LIKE \'' + trimSpaceAll(nameKana) + '%\'');
            }
            //おなまえ(漢字・英字)
            if (String.isNotBlank(nameKanji)) {
                whereQuery.add('SearchNameOfKanji__c = \'' + String.escapeSingleQuotes(trimSpaceAll(nameKanji)) + '\'');
            }
            //電話番号
            if (String.isNotBlank(phone)) {
                whereQuery.add('(SearchPhoneNumber1__c = \'' + delHaifun(trimSpaceLR(phone)) 
                               + '\' OR SearchPhoneNumber2__c = \'' + delHaifun(trimSpaceLR(phone)) + '\')');
            }
            //生年月日
            //if (String.isNotBlank(birthday)) {
                //whereQuery.add('Birthdate__c = ' + birthday.left(4) + CommonConstantsUtil.HYPHEN + birthday.substring(4,6) + CommonConstantsUtil.hyphen + birthday.substring(6));
            //}
            //メールアドレス
            if (String.isNotBlank(emailValue)) {
                whereQuery.add('(Email1__c = \'' + String.escapeSingleQuotes(trimSpaceLR(emailValue)) 
                               + '\' OR Email2__c = \'' + String.escapeSingleQuotes(trimSpaceLR(emailValue)) + '\')');
            }
            //住所
            if (String.isNotBlank(address)) {
                whereQuery.add('(Address__c LIKE \'' + String.escapeSingleQuotes(convertToHankaku(trimSpaceLR(address))) + '%\''
                              + ' OR SearchAddress__c LIKE \'' + String.escapeSingleQuotes(CommonConvertUtil.convertCharacter(convertToHankaku(trimSpaceLR(address)))) + '%\')');
            }
            //統合顧客/未統合顧客
            if (memberFlag != null 
                && notMemberFlag != null 
                && memberFlag
                && !notMemberFlag) {
                    whereQuery.add('ClientStatus__c = \'' + CommonConstantsUtil.CLIENT_STATUS_IN + '\'');
                }
            if (memberFlag != null 
                && notMemberFlag != null 
                && !memberFlag 
                && notMemberFlag) {
                    whereQuery.add('ClientStatus__c = \'' + CommonConstantsUtil.CLIENT_STATUS_UN + '\'');
                }
            whereQuery.add('Status__c = \'' + CommonConstantsUtil.STATUS_AVAILABLE + '\'');
            if(!whereQuery.isEmpty()) {
                sQuery += ' WHERE ';
                sQuery += String.join(new List<String>(whereQuery), 'AND ');
            }
            //sQuery = String.escapeSingleQuotes(sQuery);
            List<Account> accountList = Database.query(sQuery +  ' Limit '+CommonConstantsUtil.CUS_SEARCH_LIMIT);
            List<String> parts = System.URL.getSalesforceBaseUrl().getHost().replace('-api','').split('\\.');
            for (Account acc: accountList) {
                String paramUrl = CommonConstantsUtil.QUERY_MARK;
                if (String.isNotBlank(no1x)) {
                    paramUrl = paramUrl + 'meter=' + no1x.replace(CommonConstantsUtil.HYPHEN, '');
                } else if (String.isNotBlank(no3x)) {
                    paramUrl = paramUrl + 'customer=' + no3x.replace(CommonConstantsUtil.HYPHEN, '');
                } else if (String.isNotBlank(no4x)) {
                    paramUrl = paramUrl + 'gascontract=' + no4x.replace(CommonConstantsUtil.HYPHEN, '');
                }
                Map<String, Object> returnMap = new Map<String, Object>();
                returnMap.put('IntegratedClientID__c', acc.IntegratedClientID__c);
                String url = '/lightning/r/Account/' + acc.Id + '/view';
                if (paramUrl.length() > 1) {
                    url = url + paramUrl;
                }
                returnMap.put('detailPageLink', url);
                //returnMap.put('NameOfKanji__c', acc.NameOfKanji__c);
                //returnMap.put('Birthdate__c', acc.Birthdate__c);
                //returnMap.put('PhoneNumber1__c', acc.PhoneNumber1__c);
                returnMap.put('Address__c', acc.Address__c);
                //returnMap.put('ClientStatus__c', CommonConvertUtil.getSelectionValue(Account.ClientStatus__c, acc.ClientStatus__c));
                returnMap.put('Name', acc.Name);
                returnList.add(returnMap);
            }
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
            //return new CommonResponseDto(100, 'システムエラー', null);
        }
        if (returnList == null || returnList.isEmpty()) {
            return new CommonResponseDto(40, '顧客情報取得失敗', null);
        }
        return new CommonResponseDto(0, null, returnList);
    }
    private static String trimSpaceLR(String str) {
        return str.replaceAll('^[　 ]+|[　 ]+$', '');
    }
    private static String trimSpaceAll(String str) {
        return str.replaceAll('\\s+', '').replaceAll('　','');
    }
    private static String delHaifun(String str) {
        return str.replaceAll('-', '');
    }
    /**
     * 文字列に全角数字、横線を半角にする
     * @param str
     * @returns 文字列
     */
    private static String convertToHankaku(String str) {
        String strTemp = str;
        for (String convert : convertList) {
            strTemp = strTemp.replaceAll(convert, '-');
        }
        for (String key : alphaNumberMap.keySet()) {
            if (strTemp.indexOf(key) > -1) {
                strTemp = strTemp.replaceAll(key, alphaNumberMap.get(key));
            }
        }
        return strTemp;
    }
    
    /**
     * サービス契約種別の設定
     * 
     * @param no1x　
     *       ガスメーター設置場所番号(1x)
     * @param no3x　
     *       お客さま登録番号(3x)
     * @param no4x　
     *       ガス使用契約番号(4x)
     * @param mTGIdValue　
     *       mTGログインID
     * @return 
     *       services
     * */
    private static List<String> getServiceTypes(String no1x, String no3x, String no4x, String mTGIdValue) {
        // サービス種別
        List<String> services = new List<String>();
        if (String.isNotBlank(no1x)) {
            // ガス
            services.add('001');
        } else if (String.isNotBlank(no3x)) {
            // ガス契約のガス使用契約者(3x)
            services.add('001');
            // 電力契約の使用契約者(3x)
            services.add('006');
            // 域外ガス契約の使用契約者(3x)
            services.add('010');
            // 警報器リース契約の支払契約者(3x)
            services.add('004');
        } else if (String.isNotBlank(no4x)) {
            // ガス
            services.add('001');
        } else if (String.isNotBlank(mTGIdValue)) {
            // myTOKYOGAS
            services.add('009');
        }
        // TG-CRM
        services.add('013');
        return services;
    }
    
    /**
     * サービス契約キーの設定
     * 
     * @param no1x　
     *       ガスメーター設置場所番号(1x)
     * @param no3x　
     *       お客さま登録番号(3x)
     * @param no4x　
     *       ガス使用契約番号(4x)
     * @param mTGIdValue　
     *       mTGログインID
     * @return 
     *       keys
     * */
    private static List<String> getServiceKeys(String no1x, String no3x, String no4x, String mTGIdValue) {
        // サービス契約キー
        List<String> keys = new List<String>();
        
        if (String.isNotBlank(no1x)) {
            keys.add(no1x.replace(CommonConstantsUtil.HYPHEN, ''));
        } else if (String.isNotBlank(no3x)) {
            keys.add(no3x.replace(CommonConstantsUtil.HYPHEN, ''));
        } else if (String.isNotBlank(no4x)) {
            keys.add(no4x.replace(CommonConstantsUtil.HYPHEN, ''));
        } else if (String.isNotBlank(mTGIdValue)) {
            keys.add(mTGIdValue.replace(CommonConstantsUtil.HYPHEN, ''));
        }
        return keys;
    }
}