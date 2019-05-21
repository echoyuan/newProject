/**
 * [情報連携キー]キー検索APIリクエスト共通処理
 */
public with sharing class CommonKeySearchApi extends CommonAbstractRequestApi {
    private final String TGCRM_SERVICE_TYPE = 'A01';
    // 項目種別
    public static final List<String> DEFAULT_ITEMS = new List<String>{'001', '002', '003', '004', '005', '006', '007', '008', '009', '010', '011', '012'};
    // ロール種別
    public static final List<String> DEFAULT_ROLES = new List<String>{'01', '02', '03', '04', '05'};
    // サービス契約種別
    public static final List<String> DEFAULT_SERVICES = new List<String>{'001', '002', '003', '004', '005', '006', '007', '008', '009', '010', '011', '012', '013'};
    // サービスのサービスタイプ（サービス契約種別）　→　ユーザのユーザキータイプ（基幹キー種別）
    private final Map<String, String> SERVICE_USER_KEY_TYPE =
        new Map<String, String>{
            '001' => '003',    // ガス：お客さま登録番号(3x)
            '010' => '003',    // 域外ガス：お客さま登録番号(3x)
            '006' => '003',    // 電気：お客さま登録番号(3x)
            '003' => '016',    // ＴＥＳメンテナンス：016 (識別番号サービス番号(ATOM-TES用） )
            '007' => '010',    // トリプル割：P番
            '008' => '010',    // 駆け付けサービス：P番
            '012' => '015',    // ガススペシャルサポート ：くらしお客さま番号
            '004' => '003',    // 警報器リース：お客さま登録番号(3x)
            '009' => '011',    // myTOKYOGAS  ：会員ID 
            '013' => '017'     // TG-CRM   ：顧客ID
        };
            
    // サービスのサービスタイプ（サービス契約種別）　→　サービスのサービスキータイプ（基幹キー種別）
    private final Map<String, String> SERVICE_KEY_TYPE =
        new Map<String, String>{
            '001' => '004', // ガス使用契約番号(ガス4x) 
            '002' => '013', // サービス契約番号(COSMOS用) 
            '003' => '016', // 識別番号サービス番号(ATOM-TES用） 
            '004' => '005', // 他システム使用契約番号(他シス4x) 
            '006' => '007', // 電力契約番号(SA) 
            '007' => '009', // 光サービスID 
            '008' => '010', // P番 
            '009' => '006', // カスタマ番号(8x)
            '010' => '003', // お客さま登録番号(3x) 
            '011' => '013', // サービス契約番号(COSMOS用) 
            '012' => '014', // くらしサービス番号 
            '013' => '017'  // 顧客ID 
        };
            
    // サービスのサービスタイプ（サービス契約種別）　→　サービスのその他キータイプ（基幹キー種別）
    private final Map<String, String> OTHER_KEY_TYPE =
        new Map<String, String>{
            '001' => '001'  // 001 ( ガスメーター設置場所番号(1x) )
        };
            
    // サービスのサービスタイプ（サービス契約種別）　→　ソート
    private final Map<String, String> SERVICE_UNIQUE_SORT_KEY =
        new Map<String, String>{
            '001' => '004',    // ガス：ガス使用契約番号(ガス4x)
            '002' => '013',    // くらし見守り・マイツーホー：サービス契約番号(COSMOS用) 
            '003' => '016',    // ＴＥＳメンテナンス：識別番号サービス番号(ATOM-TES用）
            '004' => '003',    // 警報器リース：003 ( お客さま登録番号(3x) )
            //'006' => '007',    // 電気：電力契約番号(SA)
            '006' => '003',    // 電気：お客さま登録番号(3x)
            '007' => '009',    // トリプル割：光サービスID
            '008' => '010',    // 駆け付けサービス：P番
            '009' => '011',    // myTOKYOGAS：会員ID
            '010' => '003',    // 域外ガス：お客さま登録番号(3x)
            '011' => '013',    // リモートプラス：サービス契約番号(COSMOS用) 
            '012' => '014',    // ガススペシャルサポート：くらしサービス番号
            '013' => '017'     // TG-CRM   ：顧客ID
        };
    private final Map<String, String> SERVICE_NAME =
        new Map<String, String>{
            '001' => 'ガス',
            '0011' => 'ガストラサポ',
            '010' => '域外ガス',
            '006' => '電気',
            '0061' => '電気トラサポ',
            '012' => 'スペサポ', 
            '008' => '駆けつけ',
            '007' => 'トリプル割', 
            '004' => '警報器リース',
            '003' => 'TESメンテ',
            '009' => 'myTOKYOGAS'
        };
    
     private final Map<String, String> SERVICE_SORT_KEY =
        new Map<String, String>{
            '001' =>  '11',    //  ガス 
            '010' =>  '12',    //  域外ガス 
            '006' =>  '13',    //  電気 
            '003' =>  '14',    //  ＴＥＳメンテナンス 
            '012' =>  '15',    //  ガススペシャルサポート 
            '0011' => '16',    //  ガストラサポ
            '0061' => '17',    //  電気トラサポ
            '008' =>  '18',    //  駆け付けサービス 
            '004' =>  '19',    //  警報器リース 
            '007' =>  '20'    //  トリプル割 
        };

    private final Map<String, String> SERVICE_STATUS =
        new Map<String, String>{
            '01' => '提供未',
            '02' => '提供中',
            '03' => '停止中',
            '04' => '解約',
            '00102' => '契約中(開栓中)',//ガス提供中の場合
            '00104' => '解約済(開栓中)',//ガス解約の場合
            '001102' => '適用中',//ガストラサポ提供中の場合
            '001104' => '解約済',//ガストラサポ解約の場合
            '01002' => '契約中',//域外ガス提供中の場合
            '01004' => '解約済',//域外ガス解約の場合
            '00602' => '契約中',//電気提供中の場合
            '00604' => '解約済',//電気解約の場合
            '006102' => '適用中',//電気トラサポ提供中の場合
            '006104' => '解約済',//電気トラサポ解約の場合
            '9902' => '適用中',//スペサポ、駆けつけ、トリプル割、警報器リース、TESメンテ提供中の場合
            '9904' => '解約済',//スペサポ、駆けつけ、トリプル割、警報器リース、TESメンテ解約の場合
            '05' => '取消'
        };

    private final Map<String, String> SERVICE_SORT_STATUS =
        new Map<String, String>{
            '契約中(開栓中)' => '11',
            '契約中' => '12', 
            '適用中' => '13', 
            '提供未' => '14',
            '提供中' => '15',
            '停止中' => '16',
            '解約済(開栓中)' => '17',
            '解約済' => '18'
        };
       
	/** 退会済 */
    private static final String WITHDRAWAL = 'Withdrawal';
    /** 未退会 */
    private static final String NO_WITHDRAWAL = 'NoWithdrawal';
    // リクエストパラメータ
    private List<String> services = null;
    private List<Map<String, String>> serviceList = null;
    private List<Map<String, String>> roleList = null;
    private List<Map<String, String>> itemTypeList = null;
    private List<Map<String, String>> serviceKeyList = null;
    private String transferYmdTo = null;
    // API通信エラーメッセージ
    private final String messageHeader = '[情報連携キー検索API]の通信に失敗しました。';

    public CommonKeySearchApi(List<String> services, List<String> keys) {
        if (services != null && !services.isEmpty()) {
            serviceList = new List<Map<String, String>>();
            for (String serviceType : services) {
                Map<String, String> serviceMap = new Map<String, String>();
                serviceMap.put('serviceType', serviceType);
                serviceList.add(serviceMap);
            }
        }
        if (keys != null && !keys.isEmpty()) {
            serviceKeyList = new List<Map<String, String>>();
            for (String serviceKey : keys) {
                Map<String, String> serviceKeyMap = new Map<String, String>();
                serviceKeyMap.put('serviceKey', serviceKey);
                serviceKeyList.add(serviceKeyMap);
            }
        }
        this.services = services;
        //this.keys = keys;
    }
    
    /**
     * リクエストの設定
     * 
     * @param request　
     *       HttpRequest
     * */
    public override void setRequestInfo(HttpRequest request) {
        // リクエスト情報（ボディー）の設定
        setRequestBody(request);
        request.setHeader('Content-Length', String.valueOf(request.getBody().length()));
        request.setMethod(CommonConstantsUtil.POST);
    	request.setEndpoint(fullPath);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Ocp-Apim-Subscription-Key', securityKey);
    }
    
    /**
     * リクエストボディーの設定
     * @param request リクエスト
     * */
    private void setRequestBody(HttpRequest request) {
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        // 契約リスト(顧客/名義訂正/名義変更)例2019/01/29 16:00に実行した場合、"2019-01-29T16:00:00+09:00"
        if (this.services != null && this.services.equals(CommonConstantsUtil.CONTRACT_LIST_SERVICES)) {
            if (String.isNotBlank(this.transferYmdTo)) {
                gen.writeObjectField('transferYmdTo', CommonConvertUtil.formatJpTime(this.transferYmdTo));
            } else {
                Date target = Date.today();
                Datetime dt = Datetime.newInstanceGmt(target.year(), target.month(), target.day());
                gen.writeObjectField('transferYmdTo', CommonConvertUtil.formatJpTime(CommonConvertUtil.formatDateTime(dt, null)));
            }
        }
        // サービス契約リスト
        if (serviceList == null || serviceList.isEmpty()) {
            serviceList = new List<Map<String, String>>();
            for (String serviceType : DEFAULT_SERVICES) {
                Map<String, String> serviceTypeMap = new Map<String, String>();
                serviceTypeMap.put('serviceType', serviceType);
                serviceList.add(serviceTypeMap);
            }
        }
        gen.writeObjectField('services', serviceList);
        // サービス契約キーリスト
        if (serviceKeyList != null && !serviceKeyList.isEmpty()) {
            gen.writeObjectField('serviceKeys', serviceKeyList);
        }
        // ロールリスト
        if (roleList == null || roleList.isEmpty()) {
            roleList = new List<Map<String, String>>();
            for (String role : DEFAULT_ROLES) {
                Map<String, String> roleMap = new Map<String, String>();
                roleMap.put('roleType', role);
                roleList.add(roleMap);
            }
        }
        gen.writeObjectField('roles', roleList);
        // 項目リスト
        if (itemTypeList == null || itemTypeList.isEmpty()) {
            itemTypeList = new List<Map<String, String>>();
            for (String item : DEFAULT_ITEMS) {
                Map<String, String> itemMap = new Map<String, String>();
                itemMap.put('itemType', item);
                itemTypeList.add(itemMap);
            }
        }
        gen.writeObjectField('itemTypes', itemTypeList);
        
        gen.writeEndObject();
        request.setBody(gen.getAsString());
    }
    
    /**
     * TMAXリスト取得
     * 
     * @return
     *       TMAXリストを返却する
     * */
    public List<CommonKeySearchResponseDto> getTMaxList() {
        List<CommonKeySearchResponseDto> serviceList = new List<CommonKeySearchResponseDto>();
        
        JSONParser parser = null;
        ResponseData data = null;
        try{
            // レスポンスボディーからデータを取得する
            parser = JSON.createParser(getResponse().getBody());
            data = (ResponseData) parser.readValueAs(ResponseData.class); 
            /*if (data.error != null && data.error.errorCode != null) {
                system.debug(Logginglevel.ERROR, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.COMMON_KEY_API);
                CommonLoggingUtil.outputApiLog(
                    getRequest()
                    , getResponse()
                    , null
                    , className
                    , ''
                    , ''
                    , getLevel());
                throw new ApiCallOutErrorException();
            }*/
            if ('success'.equals(data.result)) {
                // 返却成功の場合
                //if (data.keyGroupList != null && !data.keyGroupList.isEmpty()) {
                //    for (KeyGroup keyGroup : data.keyGroupList) {
                //        if (keyGroup.serviceList != null) {
                if (data.serviceList != null && !data.serviceList.isEmpty()) {
                    //for (ServiceDto serviceDto : keyGroup.serviceList) {
                    for (ServiceDto serviceDto : data.serviceList) {
                        if (serviceDto == null) {
                            continue;
                        }
                        // ユーザーリスト
                        List<UserDto> userDtoList = serviceDto.userList;
                        for (UserDto userDto : userDtoList) {
                            if (userDto == null
                                || userDto.userKeys == null
                                || userDto.services == null
                                || userDto.services.isEmpty()
                                || String.isBlank(userDto.services.get(0).serviceType)) {
                                    continue;
                                }
                            // サービス契約種別
                            String serviceType = userDto.services.get(0).serviceType;
                            if (!isServiceTypeContains(serviceType)) {
                                continue;
                            }
                            // サービス契約キー
                            String serviceKey = getServiceKey(serviceType, userDto.services.get(0).keys);
                            boolean deleteFlg = getServiceStatusExcept(userDto.services.get(0).transfers);
                            // ※解約済の契約は除外する(異動種別が「解約」で、異動日を迎えている異動情報を持つ契約)
                            if(!deleteFlg){
                                CommonKeySearchResponseDto dto = new CommonKeySearchResponseDto(
                                    ''
                                    , serviceType
                                    , serviceKey
                                    , ''
                                    , ''
                                    , null
                                    , null
                                    , null
                                    , ''
                                );
                                serviceList.add(dto);
                            }
                        }
                    }
                }      
                //        }
                //    }
                //}
                return serviceList; 
            }
            
            // 結果が異常の場合、または結果コードがある場合
            resultError(data);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, messageHeader + CommonConstantsUtil.ERR_CONTENT_TXT + e.getMessage());
            CommonLoggingUtil.outputApiLog(
                getRequest()
                , getResponse()
                , e
                , className
                , ''
                , ''
                , getLevel());
            throw new ApiCallOutErrorException(e);
        }
        
        return null; 
    }
    
    /**
     * 解約データを除くため、
     * 異動情報の取得
     * 
     * @param transfers　
     *       異動リスト
     * @return 除くフラグ
     * */
    private boolean getServiceStatusExcept(List<Transfer> transfers) {
        boolean ret = false;
        date sysDate = date.today();
        for (Transfer transfer : transfers) {
            if ('04'.equals(transfer.transferType)) {
                if (String.isNotBlank(transfer.transferYmd)
                    && date.valueOf(transfer.transferYmd.replace('/','-')) > sysDate){
					ret = true;
                    break;
                }
            }
        }
        return ret;
    }

    /**
     * webIDリスト取得
     * 
     * @return
     *       webIDリストを返却する
     * */
    public List<CommonKeySearchResponseDto> getWebIdList() {
        List<CommonKeySearchResponseDto> serviceListForSort = new List<CommonKeySearchResponseDto>();
        List<CommonKeySearchResponseDto> serviceList = new List<CommonKeySearchResponseDto>();
        
        JSONParser parser = null;
        ResponseData data = null;
        try{
            // レスポンスボディーからデータを取得する
            parser = JSON.createParser(getResponse().getBody());
            data = (ResponseData) parser.readValueAs(ResponseData.class); 
            if ('success'.equals(data.result)) {
                // 返却成功の場合
                //if (data.keyGroupList != null && !data.keyGroupList.isEmpty()) {
                    //for (KeyGroup keyGroup : data.keyGroupList) {
                        //if (keyGroup.serviceList != null) {
                        //for (ServiceDto serviceDto : keyGroup.serviceList) {
                if (data.serviceList != null && !data.serviceList.isEmpty()) {
                    for (ServiceDto serviceDto : data.serviceList) {
                        if (serviceDto == null) {
                            continue;
                        }
                        // ユーザーリスト
                        List<UserDto> userDtoList = serviceDto.userList;
                        for (UserDto userDto : userDtoList) {
                            if (userDto == null
                                || userDto.userKeys == null
                                || userDto.services == null
                                || userDto.services.isEmpty()
                                || String.isBlank(userDto.services.get(0).serviceType)) {
                                    continue;
                                }
                            // サービス契約種別
                            String serviceType = userDto.services.get(0).serviceType;
                            if (!isServiceTypeContains(serviceType)) {
                                continue;
                            }
                            // ユーザーキー
                            // お客さま登録番号(3x)や顧客特定Keyが格納される
                            String userKey = getUserKey(serviceType, userDto.userKeys);
                            // サービス契約キー
                            String serviceKey = getServiceKey(serviceType, userDto.services.get(0).keys);
                            // その他契約キー
                            // String otherKey = getOtherKey(serviceType, userDto.services.keys);
                            Map<String, String> transferMap = getServiceStatus(userDto.services.get(0).transfers);
                            // ステータス変更
                            String status = SERVICE_STATUS.get(serviceType + transferMap.get('status'));
                            CommonKeySearchResponseDto dto = new CommonKeySearchResponseDto(
                                userKey
                                , serviceType
                                , String.isBlank(serviceKey) ? userKey : serviceKey
                                , ''//otherKey
                                , SERVICE_NAME.get(serviceType)
                                , status
                                , transferMap.get('start')// 開始日
                                , transferMap.get('end')// 終了日
                                , CommonConstantsUtil.HYPHEN
                            );
                            String memberStatus = String.isNotBlank(transferMap.get('end')) ? WITHDRAWAL : NO_WITHDRAWAL;
                            dto.withdrawalStatus = memberStatus;
                            serviceListForSort.add(dto);
                        }
                    }
                }
                    //    }
                    //}
                if (!serviceListForSort.isEmpty()) {
                    List<Object> tempList = CommonConvertUtil.sort(
                        serviceListForSort
                        ,new List<String> {'withdrawalStatus', 'userKey'}
                        ,new List<Boolean> {false, true}
                        ,new List<Boolean> {false, false});
                    for (Object o : tempList) {
                        serviceList.add((CommonKeySearchResponseDto)o);
                    } 
                }
                //}
                return serviceList; 
            }
            
            // 結果が異常の場合、または結果コードがある場合
            resultError(data);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, messageHeader + CommonConstantsUtil.ERR_CONTENT_TXT + e.getMessage());
            CommonLoggingUtil.outputApiLog(
                getRequest()
                , getResponse()
                , e
                , className
                , ''
                , ''
                , getLevel());
            throw new ApiCallOutErrorException(e);
        }
        
        return null; 
    }

    /**
     * 契約一覧検索Apiのコール
     * 
     * @return 　
     *       契約一覧検索結果を返却する
     * */
    public List<List<CommonKeySearchResponseDto>> getContractList() {
        List<List<CommonKeySearchResponseDto>> serviceList = new List<List<CommonKeySearchResponseDto>>();
        
        JSONParser parser = null;
        ResponseData data = null;
        try{
            // レスポンスボディーからデータを取得する
            parser = JSON.createParser(getResponse().getBody());
            data = (ResponseData) parser.readValueAs(ResponseData.class); 
            if ('success'.equals(data.result)) {
                MapWrapper[] allGrpArray = new MapWrapper[0];
                // 返却成功の場合
                //if (data.keyGroupList != null && !data.keyGroupList.isEmpty()) {
                    //MapWrapper[] allGrpArray = new MapWrapper[0];
                    //for (KeyGroup keyGroup : data.keyGroupList) {
                        //if (keyGroup.serviceList != null) {
                            //for (ServiceDto serviceDto : keyGroup.serviceList) {
                if (data.serviceList != null && !data.serviceList.isEmpty()) {
                    for (ServiceDto serviceDto : data.serviceList) {
                        if (serviceDto == null) {
                            continue;
                        }
                        MapWrapper[] oneGrpArray = new MapWrapper[0];
                        // ユーザーインデックス
                        String userIndex = serviceDto.indexId;
                        // ユーザーリスト
                        List<UserDto> userDtoList = serviceDto.userList;
                        Date maxEndDate = null;
                        // TESメンテまたはスペサポを契約している場合は表示しないため、ガストラサポ一時格納
                        MapWrapper[] oneGrpArrayTemp = new MapWrapper[0];
                        //  TESメンテまたはスペサポを契約しているフラグ
                        boolean tesSpOpenFlag = false;
                        for (UserDto userDto : userDtoList) {
                            if (userDto == null
                                || userDto.userKeys == null
                                || userDto.services == null
                                || userDto.services.isEmpty()
                                || String.isBlank(userDto.services.get(0).serviceType)) {
                                    continue;
                                }
                            // サービス契約種別
                            String serviceType = userDto.services.get(0).serviceType;
                            if (!isServiceTypeContains(serviceType)) {
                                continue;
                            }
                            // ユーザーキー
                            // お客さま登録番号(3x)や顧客特定Keyが格納される
                            String userKey = getUserKey(serviceType, userDto.userKeys);
                            // サービス契約キー
                            String serviceKey = getServiceKey(serviceType, userDto.services.get(0).keys);
                            // その他契約キー
                            String otherKey = getOtherKey(serviceType, userDto.services.get(0).keys);
                            Map<String, String> transferMap = getServiceStatus(userDto.services.get(0).transfers);
                            // グループに最大更新日の取得
                            Date thisEndDate = null;
                            if(String.isNotBlank(transferMap.get('end'))){
                                thisEndDate = Date.valueOf(transferMap.get('end').replace('/','-'));
                            } else if (String.isNotBlank(transferMap.get('start'))) {
                                thisEndDate = Date.valueOf(transferMap.get('start').replace('/','-'));
                            }
                            if(thisEndDate != null && (maxEndDate == null || maxEndDate < thisEndDate)){
                                maxEndDate = thisEndDate;
                            }
                            // 契約状態
                            String status = SERVICE_STATUS.get(serviceType + transferMap.get('status'));
                            if ('012'.equals(serviceType) 
                                || '008'.equals(serviceType) 
                                || '007'.equals(serviceType) 
                                || '004'.equals(serviceType) 
                                || '003'.equals(serviceType)
                               ) {
                                   status = SERVICE_STATUS.get('99' + transferMap.get('status'));
                               }
                            CommonKeySearchResponseDto dto = new CommonKeySearchResponseDto(
                                userKey
                                , serviceType
                                , String.isBlank(serviceKey) ? userKey : serviceKey
                                , otherKey
                                , SERVICE_NAME.get(serviceType)
                                , status
                                , '001'.equals(serviceType) ? null : transferMap.get('start')// 開始日
                                //, '001'.equals(serviceType) ? null : CommonConvertUtil.formatJpTime(transferMap.get('end'))// 終了日
                                , '001'.equals(serviceType) ? null : transferMap.get('end')// 終了日
                                , CommonConstantsUtil.HYPHEN
                            );
                            // 契約一覧の契約キーに、
                            // ガスの場合、１X、４X、３Xのようにする
                            if('001'.equals(serviceType)){
                                if (String.isNotBlank(otherKey)) {
                                    dto.viewKey = otherKey;
                                } else if (String.isNotBlank(serviceKey)) {
                                    dto.viewKey = serviceKey;
                                } else {
                                    dto.viewKey = userKey;
                                }
                            } else if ('003'.equals(serviceType)) {
                                // ＴＥＳメンテの場合、一覧の契約者キーにサービスキーを表示
                                dto.viewKey = serviceKey;
                            } else {
                                dto.viewKey = userKey;
                            }
                            if ('001'.equals(serviceType)
                                || '0011'.equals(serviceType)
                                || '006'.equals(serviceType)
                                || '0061'.equals(serviceType)
                                || '004'.equals(serviceType)
                                || '010'.equals(serviceType)) {
                                     dto.viewKey = CommonConvertUtil.formatNoStr(dto.viewKey);
                                 }
                            if (('003'.equals(serviceType) || '012'.equals(serviceType)) && '02'.equals(transferMap.get('status'))) {
                                tesSpOpenFlag = true;                                
                            }
                            // グレー背景フラグ設定
                            setGrayFlag(dto);
                            
                            oneGrpArray.add(new MapWrapper(
                                dto
                                , getStatusSort(status) + SERVICE_SORT_KEY.get(serviceType)
                                , getServiceKey(SERVICE_UNIQUE_SORT_KEY.get(serviceType), userDto.services.get(0).keys)));
                            if('001'.equals(serviceType)){
                                // ガストラサポ
                                CommonKeySearchResponseDto dtoClone = dto.clone();
                                dtoClone.categoryName = SERVICE_NAME.get('0011');
                                dtoClone.serviceType='0011';
                                dtoClone.status = SERVICE_STATUS.get(dtoClone.serviceType + transferMap.get('status'));
                                dtoClone.menu = '-';
                                //dtoClone.startDate = '';
                                //dtoClone.endDate = '';
                                //if ('02' == transferMap.get('status')) {
                                dtoClone.startDate = transferMap.get('start');
                                //} else if ('04' == transferMap.get('status')) {
                                //dtoClone.endDate = CommonConvertUtil.formatJpTime(transferMap.get('end'));
                                dtoClone.endDate = transferMap.get('end');
                                //}
                                // グレー背景フラグ設定
                                setGrayFlag(dtoClone);
                                oneGrpArrayTemp.add(new MapWrapper(
                                    dtoClone
                                    , getStatusSort(SERVICE_STATUS.get(dtoClone.serviceType + transferMap.get('status'))) + SERVICE_SORT_KEY.get('0011')
                                    , getServiceKey(SERVICE_UNIQUE_SORT_KEY.get(serviceType), userDto.services.get(0).keys)));
                            } else if('006'.equals(serviceType) && !isFutureDate(userDto.services.get(0).transfers)){
                                // ①電気トラサポの契約開始日が未来の場合、電気トラサポの行表示をしない
                                // 電気トラサポ
                                CommonKeySearchResponseDto dtoClone = dto.clone();
                                dtoClone.categoryName = SERVICE_NAME.get('0061');
                                dtoClone.menu = '-';
                                dtoClone.serviceType='0061';
                                dtoClone.status = SERVICE_STATUS.get(dtoClone.serviceType + transferMap.get('status'));
                                //dtoClone.startDate = '';
                                //dtoClone.endDate = '';
                                if (String.isNotBlank(transferMap.get('start'))) {//'02' == transferMap.get('status') && 
                                    // 毎月15日時点で電気供給を受けている人は、翌月1日が契約開始日となるよう表示する
                                    dtoClone.startDate = getElcTrspContractStart(transferMap.get('start'));
                                }// else if ('04' == transferMap.get('status')) {
                                dtoClone.endDate = //CommonConvertUtil.formatJpTime(
                                    getElcTrspContractEnd(
                                        dtoClone.startDate
                                        , transferMap.get('end'));//);
                                //}
                                // グレー背景フラグ設定
                                setGrayFlag(dtoClone);
                                oneGrpArray.add(new MapWrapper(
                                    dtoClone
                                    , getStatusSort(SERVICE_STATUS.get(dtoClone.serviceType + transferMap.get('status'))) + SERVICE_SORT_KEY.get('0061')
                                    , getServiceKey(SERVICE_UNIQUE_SORT_KEY.get(serviceType), userDto.services.get(0).keys)));
                            }
                        }
                        if (!tesSpOpenFlag) {
                            // TESメンテまたはスペサポを契約している場合は表示しない
                            oneGrpArray.addAll(oneGrpArrayTemp);
                        }
                        if (!oneGrpArray.isEmpty()) {
                            oneGrpArray.sort();
                            List<CommonKeySearchResponseDto> oneGrpList = new List<CommonKeySearchResponseDto>();
                            for (MapWrapper oneGrpItem : oneGrpArray) {
                                oneGrpList.add((CommonKeySearchResponseDto)oneGrpItem.obj);
                            }
                            allGrpArray.add(new MapWrapper(oneGrpList, maxEndDate, oneGrpList.get(0).serviceKey));
                        }
                    }
                }
                        //}
                    //}
                if (!allGrpArray.isEmpty()) {
                    allGrpArray.sort();
                    for (MapWrapper grpItem : allGrpArray) {
                        serviceList.add((List<CommonKeySearchResponseDto>)grpItem.obj);
                    }
                }
                //}
                return serviceList;
            }
            
            // 結果が異常の場合、または結果コードがある場合
            resultError(data);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, messageHeader + CommonConstantsUtil.ERR_CONTENT_TXT + e.getMessage());
            CommonLoggingUtil.outputApiLog(
                getRequest()
                , getResponse()
                , e
                , className
                , ''
                , ''
                , getLevel());
            throw new ApiCallOutErrorException(e);
        }
        
        return null;
    }

    /**
     * グレー背景フラグ設定
     * 
     * @dto 
     * 
     * */
    private void setGrayFlag(CommonKeySearchResponseDto dto){
        // グレー背景フラグ設定
        if (String.isNotBlank(dto.status) 
            && (dto.status.indexOf(CommonConstantsUtil.GMT_STATUS_CLOSED) > -1 )) {
                dto.grayFlag = ' gray-backcolor-row';
            }
    }

    /**
     * 顧客ID検索Apiのコール
     * 
     * @return 　
     *       顧客ID検索結果を返却する
     * */
    public List<List<CommonKeySearchResponseDto>> getCustomerKey() {
        List<List<CommonKeySearchResponseDto>> serviceList = new List<List<CommonKeySearchResponseDto>>();
        
        JSONParser parser = null;
        ResponseData data = null;
        try{
            // レスポンスボディーからデータを取得する
            parser = JSON.createParser(getResponse().getBody());
            data = (ResponseData) parser.readValueAs(ResponseData.class); 
            if ('success'.equals(data.result)) {
                // 返却成功の場合
                //if (data.keyGroupList != null && !data.keyGroupList.isEmpty()) {
                    //for (KeyGroup keyGroup : data.keyGroupList) {
                        //if (keyGroup.serviceList != null) {
                            //for (ServiceDto serviceDto : keyGroup.serviceList) {
                if (data.serviceList != null && !data.serviceList.isEmpty()) {
                    for (ServiceDto serviceDto : data.serviceList) {
                        if (serviceDto == null) {
                            continue;
                        }
                        List<CommonKeySearchResponseDto> oneGrpList = new List<CommonKeySearchResponseDto>();
                        // ユーザーリスト
                        List<UserDto> userDtoList = serviceDto.userList;
                        for (UserDto userDto : userDtoList) {
                            if (userDto == null
                                || userDto.userKeys == null
                                || userDto.services == null
                                || userDto.services.isEmpty()
                                || String.isBlank(userDto.services.get(0).serviceType)) {
                                    continue;
                                }
                            // サービス契約種別
                            String serviceType = userDto.services.get(0).serviceType;
                            if ('013'.equals(serviceType) && isServiceTypeContains(serviceType)) {
                                // ユーザーキー
                                // お客さま登録番号(3x)や顧客特定Keyが格納される
                                String userKey = getUserKey(serviceType, userDto.userKeys);
                                CommonKeySearchResponseDto dto = new CommonKeySearchResponseDto(
                                    userKey
                                    , serviceType
                                    , ''
                                    , ''
                                    , ''
                                    , ''
                                    , ''
                                    , ''
                                    , ''
                                );
                                oneGrpList.add(dto);
                            }
                        }
                        if (!oneGrpList.isEmpty()) {
                            serviceList.add(oneGrpList);
                        }
                    }
                }
                        //}
                    //}
                //}
                return serviceList;
            }
            
            // 結果が異常の場合、または結果コードがある場合
            resultError(data);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, messageHeader + CommonConstantsUtil.ERR_CONTENT_TXT + e.getMessage());
            CommonLoggingUtil.outputApiLog(
                getRequest()
                , getResponse()
                , e
                , className
                , ''
                , ''
                , getLevel());
            throw new ApiCallOutErrorException(e);
        }
        
        return null;
    }
    
    /**
     * 内部クラス（ソート）
     * */
    private class MapWrapper implements Comparable {
        public Object obj;
        public Object sortKey;
        public Object sortKey2;
        // 項目、ソートキー１、ソートキー２
        public MapWrapper(Object obj, Object sortKey, Object sortKey2) {
            this.obj = obj;
            this.sortKey = sortKey;
            this.sortKey2 = sortKey2;
        }
        public Integer compareTo(Object other) {
            // ソートキー１が文字列の場合
            if (sortKey instanceof String) {
                // ソートキー１同一、複数レコードがある場合、ソートキー２にて比較してソートする
                if ((String)((MapWrapper)other).sortKey == (String)sortKey) {
                    return (String)((MapWrapper)other).sortKey2 > (String)sortKey2 ? 1 : -1;
                } else {
                    // ソートキー１同一、複数レコードがない場合、ソートキー１にて比較してソートする
                    return (String)((MapWrapper)other).sortKey > (String)sortKey ? -1 : 1;
                }
            // ソートキー１が日付の場合
            } else if (sortKey instanceof Date){
                if (other != null){
                    if (Date.valueOf(((MapWrapper)other).sortKey) > Date.valueOf(sortKey)) {
                        return 1;
                    } else if (Date.valueOf(((MapWrapper)other).sortKey) == Date.valueOf(sortKey)) {
                        return (String)((MapWrapper)other).sortKey2 > (String)sortKey2 ? 1 : -1;
                    } else {
                        return -1;
                    }
                }
            }
            return 0;
        }
    }
    
    /**
     * ユーザキーの取得
     * 
     * @param serviceType　
     *       サービス契約種別
     * @param userKeys　
     *       ユーザキーリスト
     * @return ユーザキー
     * */
    private String getUserKey(String serviceType, List<UserKey> userKeys) {
        String key = '';
        if (userKeys.isEmpty()) {
            return key;
        }
        String userKeyType = SERVICE_USER_KEY_TYPE.get(serviceType);
        for (UserKey userKey : userKeys) {
            if (userKeyType != null && userKeyType.equals(userKey.keyType)) {
                key = userKey.userKey;
                break;
            }
        }
        return key;
    }
    
    /**
     * サービスキーの取得
     * 
     * @param serviceType　
     *       サービス契約種別
     * @param keys　
     *       サービスのキーリスト
     * @return サービスキー
     * */
    private String getServiceKey(String serviceType, List<Key> keys) {
        String serviceKey = '';
        if (keys.isEmpty()) {
            return serviceKey;
        }
        String keyType = SERVICE_KEY_TYPE.get(serviceType);
        for (Key key : keys) {
            if (keyType != null && keyType.equals(key.keyType)) {
                serviceKey = key.serviceKey;
                break;
            }
        }
        return serviceKey;
    }
    
    /**
     * その他キーの取得
     * 
     * @param serviceType　
     *       サービス契約種別
     * @param keys　
     *       サービスのキーリスト
     * @return その他キー
     * */
    private String getOtherKey(String serviceType, List<Key> keys) {
        String serviceKey = '';
        if (keys.isEmpty()) {
            return serviceKey;
        }
        String keyType = OTHER_KEY_TYPE.get(serviceType);
        for (Key key : keys) {
            if (keyType != null && keyType.equals(key.keyType)) {
                serviceKey = key.serviceKey;
                break;
            }
        }
        return serviceKey;
    }
    
    /**
     * 契約状態のソート順取得
     * 
     * @param status　
     *       契約状態
     * @return ソート順
     * */
    private String getStatusSort(String status) {
        if (String.isNotBlank(status)) {
            return SERVICE_SORT_STATUS.get(status);
        }
        return '99';
    }
    
    /**
     * 異動情報の取得
     * 
     * @param transfers　
     *       異動リスト
     * @return 異動情報
     * */
    private Map<String, String> getServiceStatus(List<Transfer> transfers) {
        // 日付の参照と仕様確認
        Map<String, String> retMap = new Map<String, String>();
        if (transfers == null) {
            retMap.put('start', '');
            retMap.put('end', '');
            retMap.put('status', '');
            return retMap;
        }
        date sysDate = date.today();
        String transferType = '';
        String trasferYmd = '';
        List<String> trasferStartYmdList = new List<String>();
        for (Transfer transfer : transfers) {
            if (String.isNotBlank(transfer.transferYmd)
                && date.valueOf(transfer.transferYmd.replace('/','-')) <= sysDate){
                    //if (String.isBlank(trasferYmd) 
                    //    || date.valueOf(trasferYmd.replace('/','-')) 
                    //        <= date.valueOf(transfer.transferYmd.replace('/','-'))) {
                        trasferYmd = transfer.transferYmd;
                        transferType = transfer.transferType;
                    //}
                    if ('02'.equals(transfer.transferType)) {
                        trasferStartYmdList.add(transfer.transferYmd);
                    }
            }
        }
        retMap.put('status', transferType);
        if ('02'.equals(transferType)) {
            retMap.put('start', trasferYmd);
        } else if ('04'.equals(transferType)) {
            if (!trasferStartYmdList.isEmpty()) {
                trasferStartYmdList.sort();
                retMap.put('start', trasferStartYmdList.get(trasferStartYmdList.size() - 1));//trasferStartYmdList.get(0)
            }
            retMap.put('end', trasferYmd);
        }
        return retMap;
    }
    
    /**
     * 契約開始日が未来日であるか
     * 
     * @param transfers　
     *       異動リスト
     * @return Boolean
     * */
    private Boolean isFutureDate(List<Transfer> transfers) {
        date sysDate = date.today();
        for (Transfer transfer : transfers) {
            if (String.isNotBlank(transfer.transferYmd)
                && date.valueOf(transfer.transferYmd.replace('/','-')) > sysDate
                && '02'.equals(transfer.transferType)){
                    return true;
            }
        }
        return false;
    }

    private class ResponseData extends CommonKeyApiResponseData {
        private List<ServiceDto> serviceList { get; set; }
        //private List<KeyGroup> keyGroupList{ get; set; }
        //private Error error{ get; set; }
    }

    /*private class Error {
        private String statusCode{ get; set; }
        private String errorCode{ get; set; }
        private String message{ get; set; }
    }

    private class KeyGroup {
        private List<ServiceDto> serviceList { get; set; }
    }  */
/*
    private class Contract {
        private String userId;
        private List<UserKey> userKeys;
        private Service services;
        
        private Contract(String userId, List<UserKey> userKeys, Service services) {
            userId = userId;
            userKeys = userKeys.clone();
            services = services.clone();
        }
    }  
    */
    private class ServiceDto {
        private String indexId{ get; set; }
        private List<UserDto> userList{ get; set; }
    } 
    
    private class UserDto {
        private List<UserKey> userKeys{ get; set; }
        private List<Service> services{ get; set; }
    }

    private class UserKey {
        private String keyType{ get; set; }
        private String userKey{ get; set; }
    }

    private class Service {
        //private String serviceId{ get; set; }
        private String serviceType{ get; set; }
        private List<Role> roles{ get; set; }
        private List<Transfer> transfers{ get; set; }
        private List<Key> keys{ get; set; }
    }

    private class Role {
        private String roleType{ get; set; }
        private String transferYmd{ get; set; }
    }

    private class Transfer {
        private String transferType{ get; set; }
        private String transferYmd{ get; set; }
    }

    private class Key {
        private String systemType{ get; set; }
        private String keyType{ get; set; }
        private String serviceKey{ get; set; }
        private String startYmd{ get; set; }
    }
    
    /**
     * 電気トラサポ契約開始日の取得
     * 
     * @param startDateTime　
     *       契約開始日
     * @return 電気トラサポ契約開始日
     * */
    private String getElcTrspContractStart(String startDateTime) {
        if (String.isNotBlank(startDateTime)) {
            //Datetime startDate = Datetime.valueOfGmt(CommonConvertUtil.getDateTimeString(startDateTime));
            //startDateTime = startDate.formatGmt('yyyy/MM/dd', 'Asia/Tokyo');
            startDateTime = startDateTime.replace(CommonConstantsUtil.HYPHEN, CommonConstantsUtil.SLASH_MARK);
            Integer year = Integer.valueOf(startDateTime.substring(0, startDateTime.indexOf(CommonConstantsUtil.SLASH_MARK)));
            Integer month = Integer.valueOf(startDateTime.substring(startDateTime.indexOf(CommonConstantsUtil.SLASH_MARK) + 1, startDateTime.lastIndexOf(CommonConstantsUtil.SLASH_MARK)));
            //Integer day = Integer.valueOf(startDateTime.substring(startDateTime.lastIndexOf(CommonConstantsUtil.SLASH_MARK) + 1));
            Integer day = Integer.valueOf(startDateTime.substring((startDateTime.lastIndexOf(CommonConstantsUtil.SLASH_MARK) + 1),
                                                                  (startDateTime.lastIndexOf(CommonConstantsUtil.SLASH_MARK) + 3)));
            date startDay = date.newInstance(year, month, 1);
            date newDate = startDay.addMonths(1);
            if (day > 15) {
                newDate = startDay.addMonths(2);
            }
            Datetime gMTDate = Datetime.newInstanceGmt(newDate.year(),newDate.month(),newDate.day(),0,0,0);
            return gMTDate.formatGmt('yyyy/MM/dd');//, 'Asia/Tokyo'
        }
        return null;
    }
    
    /**
     * 電気トラサポ契約終了日の取得
     * 
     * @param ymd　
     *       契約終了日
     * @return 電気トラサポ契約終了日
     * */
    private String getElcTrspContractEnd(String startDate, String endDateTime) {
        if (String.isBlank(endDateTime)) {
            return '';
        }
        ////String format = 'yyyy/MM/dd\'T\'HH:mm:ss+09:00';
        String format = 'yyyy/MM/dd';
        endDateTime = endDateTime.replace(CommonConstantsUtil.HYPHEN, CommonConstantsUtil.SLASH_MARK);
        if (String.isBlank(startDate)) {
            //Datetime endDate = Datetime.valueOfGmt(CommonConvertUtil.getDateTimeString(endDateTime));
            //endDateTime = endDate.formatGmt('yyyy/MM/dd hh:mm:ss');//, 'Asia/Tokyo'
            ////endDateTime = CommonConvertUtil.getDateTimeString(endDateTime);
            ////return Datetime.valueOfGmt(endDateTime).formatGmt(format);
            return endDateTime;
        }
        //Datetime endDate = Datetime.valueOfGmt(CommonConvertUtil.getDateTimeString(endDateTime));
        //endDateTime = endDate.formatGmt('yyyy/MM/dd hh:mm:ss');//, 'Asia/Tokyo'
        ////endDateTime = CommonConvertUtil.getDateTimeString(endDateTime);
        
        Integer startYear = Integer.valueOf(startDate.substring(0, startDate.indexOf(CommonConstantsUtil.SLASH_MARK)));
        Integer startMonth = Integer.valueOf(startDate.substring(startDate.indexOf(CommonConstantsUtil.SLASH_MARK) + 1, startDate.lastIndexOf(CommonConstantsUtil.SLASH_MARK)));
        
        Integer endYear = Integer.valueOf(endDateTime.substring(0, endDateTime.indexOf(CommonConstantsUtil.SLASH_MARK)));
        Integer endMonth = Integer.valueOf(endDateTime.substring(endDateTime.indexOf(CommonConstantsUtil.SLASH_MARK) + 1, endDateTime.lastIndexOf(CommonConstantsUtil.SLASH_MARK)));
        // 15日時点で契約開始日変換後の開始日は解約日と同年同月に一致するかを判断する
        if (startYear != endYear || startMonth != endMonth) {
            ////return Datetime.valueOfGmt(endDateTime).formatGmt(format);
            return endDateTime;
        }
        
        Integer day;
        ////if (endDateTime.length() > 10) {
        ////    day = Integer.valueOf(endDateTime.substring(endDateTime.lastIndexOf(CommonConstantsUtil.HYPHEN) + 1, endDateTime.indexOf(CommonConstantsUtil.HALF_SPACE)));
        ////} else {
        day = Integer.valueOf(endDateTime.substring(endDateTime.lastIndexOf(CommonConstantsUtil.SLASH_MARK) + 1));
        ////}
        
        // 翌月15日以前に解約した場合、その月の月末で契約終了となるように契約終了日を設定すること
        if (day >= 15) {
            ////return Datetime.valueOfGmt(endDateTime).formatGmt(format);
            return endDateTime;
        }
        ////Datetime endDate = Datetime.valueOfGmt(endDateTime);
        ////Datetime gMTDateTime = Datetime.newInstanceGmt(startYear, startMonth, date.daysInMonth(startYear, startMonth), endDate.hourGmt(), endDate.minuteGmt(), endDate.secondGmt());
        Datetime gMTDateTime = Datetime.newInstanceGmt(startYear, startMonth, date.daysInMonth(startYear, startMonth));
        
        endDateTime = gMTDateTime.formatGmt(format);//gMTDateTime.format('yyyy/MM/dd hh:mm:ss');
        return endDateTime;
    }

    /**
     * タイムアウト、リトライ、ログ出力など設定
     * */
    public override void setApiCustomerInfo() {
        // APIリクエストタイプ
        apiRequestType = 'KeySearchApi';
        // 環境変数APIタイプ
        envApiRequestType = CommonConstantsUtil.API_TYPE_KEY;
        // API通信エラーメッセージ
        message = this.messageHeader;
        // クラス名
        className = 'CommonKeySearchApi';
    }
    
    /**
     * サービス契約種別あるかをチェックする
     * 
     * @param serviceType　
     *       サービス契約種別
     * */
    private Boolean isServiceTypeContains(String serviceType) {
        // パラメータのサービス契約種別が有の場合
        if (services != null && !services.isEmpty()) {
            if (String.isNotBlank(serviceType) && services.contains(serviceType)) {
                return true;
            }
        } else {
            // パラメータのサービス契約種別が無、デフォルトサービス契約種別(全種類)にする場合
            if (serviceList != null && !serviceList.isEmpty()) {
                return true;
            }
        }
        return false;
    }
}