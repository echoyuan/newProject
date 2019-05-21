public class CommonContractApiRequest {
    private Integer statusCode;
    private String errorCode = null;
    private String errorMessage = null;
    private HttpRequest request = null;
    private HttpResponse response = null;
    private final String TGCRM_SERVICE_TYPE = 'A01';
    // サービス契約種別
    public static final List<String> DEFAULT_SERVICES = new List<String>{'001', '002', '003', '004', '005', '006', '007', '008', '009', '010', '011', '012', '013'};
    // サービスのサービスタイプ（サービス契約種別）　→　ユーザのユーザキータイプ（基幹キー種別）
    private final Map<String, String> SERVICE_USER_KEY_TYPE =
        new Map<String, String>{
            '001' => '003',    // ガス：お客さま登録番号(3x)
            '010' => '003',    // 域外ガス：お客さま登録番号(3x)
            '006' => '003',    // 電気：お客さま登録番号(3x)
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
            '009' => '011', // 会員ID 
            '010' => '003', // お客さま登録番号(3x) 
            '011' => '013', // サービス契約番号(COSMOS用) 
            '012' => '014', // くらしサービス番号 
            '013' => '017'  // 顧客ID 
        };
            
    // サービスのサービスタイプ（サービス契約種別）　→　ソート
    private final Map<String, String> SERVICE_UNIQUE_SORT_KEY =
        new Map<String, String>{
            '001' => '004',    // ガス：ガス使用契約番号(ガス4x)
            '002' => '013',    // くらし見守り・マイツーホー：サービス契約番号(COSMOS用) 
            '003' => '016',    // ＴＥＳメンテナンス：識別番号サービス番号(ATOM-TES用）
            '004' => '003',    // 警報器リース：003 ( お客さま登録番号(3x) )
            '006' => '007',    // 電気：電力契約番号(SA)
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
            '003' => 'TESメンテ'
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
            '04' => '解約済'
        };

    private final Map<String, String> SERVICE_SORT_STATUS =
        new Map<String, String>{
            '提供未' => '11',
            '提供中' => '12',
            '停止中' => '13',
            '解約済' => '14'
        };
            
    public HttpRequest getRequest() {
        return request;
    }
    
    public String getErrorMessage() {
        return errorMessage;
    }

    public CommonContractApiRequest() {
        request = new HttpRequest();
    }

    /**
     * リクエストの発送
     * 
     * @param requestInput　
     *       発送されるリクエスト
     * */
    public void send(HttpRequest requestInput) {
        Http http = new Http();
        System.debug('*******requestInput:' + requestInput);
        response = http.send(requestInput);
        System.debug(Logginglevel.INFO, 'response code:' + response.getStatusCode());
        System.debug(Logginglevel.INFO, 'response body:' + response.getBody());
    }


    /**
     * 基盤キー検索Apiのコール(デモ画面確認用)
     * 
     * @return 　
     *       基盤キー検索結果を戻る
     * */
    public List<List<CommonResponseSimpleContractDto>> testConstructKeyApiCall() {

        List<List<CommonResponseSimpleContractDto>> serviceList = new List<List<CommonResponseSimpleContractDto>>();
        List<CommonResponseSimpleContractDto> serviceDtoList = new List<CommonResponseSimpleContractDto>();    
        
        serviceDtoList = new List<CommonResponseSimpleContractDto>();                        
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000092312', '入力不要', '入力不要', '電気', '提供中', '2018/05/20', '', 'ずっとも電気', '○', '-'));                      
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000092312', '入力不要', '入力不要', '電気トラサポ', '提供中', '2018/06/01', '', '-', '○', '-'));                      
		serviceList.add(serviceDtoList);
                
        serviceDtoList = new List<CommonResponseSimpleContractDto>();                        
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000092311', '入力不要', '入力不要', 'ガス', '開栓中', '2018/04/01', '', '一般契約', '○', '-'));
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000092311', '入力不要', '入力不要', 'ガストラサポ', '提供中', '2018/04/01', '', '-', '○', '-'));
		serviceList.add(serviceDtoList);        
                
        serviceDtoList = new List<CommonResponseSimpleContractDto>();                        
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000092310', '入力不要', '入力不要', 'ガス', '閉栓中', '2012/04/01', '2018/03/30', '一般契約', '○', '-'));
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000092310', '入力不要', '入力不要', 'ガストラサポ', '解約済', '2012/04/01', '2018/03/30', '-', '○', '-'));
		serviceList.add(serviceDtoList);   
        return serviceList;
    }

    /**
     * 基盤キー検索Apiのコール
     * 
     * @return 　
     *       基盤キー検索結果を戻る
     * */
    public List<List<CommonResponseSimpleContractDto>> execConstructKeyApiCall() {
        // レスポンス戻る値が異常の場合
        if (response.getStatusCode() != 200) {
            // エラーメッセージを設定する
            errorMessage = response.getBody();
            return null;
        }
        List<List<CommonResponseSimpleContractDto>> serviceList = new List<List<CommonResponseSimpleContractDto>>();
        // レスポンスボディーからデータを取得する
        JSONParser parser = JSON.createParser(response.getBody());
        ResponseData data = (ResponseData) parser.readValueAs(ResponseData.class);
        
        if (data == null) {
            errorMessage = 'レスポンスフォーマット例外';
            return null;
        }
        if (data.error != null && data.error.errorCode != null) {
            errorCode = data.error.errorCode;
            errorMessage = data.error.message;
            return null;
        }
        if (data.keyGroupList != null) {
            MapWrapper[] allGrpArray = new MapWrapper[0];
            for (KeyGroup keyGroup : data.keyGroupList) {
                if (keyGroup.serviceList != null) {
                    for (ServiceDto serviceDto : keyGroup.serviceList) {
                        if (serviceDto == null) {
                            System.debug(' serviceDto is null ');
                            continue;
                        }
                        MapWrapper[] oneGrpArray = new MapWrapper[0];
                        // ユーザーインデックス
                        String userIndex = serviceDto.indexId;
                        // ユーザーリスト
                        List<UserDto> userDtoList = serviceDto.userList;
						Date maxEndDate = null;
                    	for (UserDto userDto : userDtoList) {
                            if (userDto == null
                                || userDto.userKeys == null
                                || userDto.services == null
                                || String.isBlank(userDto.services.serviceType)) {
                                    continue;
                            }
                            // サービス契約種別
                            String serviceType = userDto.services.serviceType;
                            system.debug(Logginglevel.INFO, 'serviceType: ' + serviceType);
                            // ユーザーキー
                            // お客さま登録番号(3x)や顧客特定Keyが格納される
                            String userKey = getUserKey(serviceType, userDto.userKeys);
                            system.debug(Logginglevel.INFO, 'userKey: ' + userKey);
                            // サービス契約キー
                            String serviceKey = getServiceKey(serviceType, userDto.services.keys);
                            system.debug(Logginglevel.INFO, 'servicekey: ' + serviceKey);
                            Map<String, String> transferMap = getServiceStatus(userDto.services.transfers);
                            Date thisEndDate = null;
                            
                            if(String.isBlank(transferMap.get('end')) || '-'.equals(transferMap.get('end'))){
                                if(String.isBlank(transferMap.get('start')) || '-'.equals(transferMap.get('start'))){
                                    thisEndDate = Date.valueOf(transferMap.get('start').replace('/','-'));
                                }
                            }else{
                            	thisEndDate = Date.valueOf(transferMap.get('end').replace('/','-'));
                            }
                            if(maxEndDate == null || maxEndDate < thisEndDate){
                                maxEndDate = thisEndDate;
                            }
                            
                            CommonResponseSimpleContractDto dto = new CommonResponseSimpleContractDto(
                                    userKey
                                    , serviceType
                                    , String.isBlank(serviceKey) ? userKey : serviceKey
                                    , SERVICE_NAME.get(serviceType)
                                    , transferMap.get('status')
                                    , transferMap.get('start')
                                    , transferMap.get('end')
                                    , '料金メニュー(固定)'
                                    , '○'
                                    , '確認フラグ(固定)'
                                );
                            oneGrpArray.add(new MapWrapper(dto, getStatusSort(transferMap.get('status')) + SERVICE_SORT_KEY.get(serviceType), getServiceKey(SERVICE_UNIQUE_SORT_KEY.get(serviceType), userDto.services.keys)));
                            if(serviceType == '001'){
                                CommonResponseSimpleContractDto dtoClone = dto.clone();
                                dtoClone.categoryName = SERVICE_NAME.get('0011');
                                dtoClone.menu = '-';
                                oneGrpArray.add(new MapWrapper(dtoClone, getStatusSort(transferMap.get('status')) + SERVICE_SORT_KEY.get('0011'), getServiceKey(SERVICE_UNIQUE_SORT_KEY.get(serviceType), userDto.services.keys)));
                            }else if(serviceType == '006'){
                                CommonResponseSimpleContractDto dtoClone = dto.clone();
                                dtoClone.categoryName = SERVICE_NAME.get('0061');
                                dtoClone.menu = '-';
                                oneGrpArray.add(new MapWrapper(dtoClone, getStatusSort(transferMap.get('status')) + SERVICE_SORT_KEY.get('0061'), getServiceKey(SERVICE_UNIQUE_SORT_KEY.get(serviceType), userDto.services.keys)));
                            }
                    	}
                        if (!oneGrpArray.isEmpty()) {
                            oneGrpArray.sort();
                            List<CommonResponseSimpleContractDto> oneGrpList = new List<CommonResponseSimpleContractDto>();
                            for (MapWrapper oneGrpItem : oneGrpArray) {
                                oneGrpList.add((CommonResponseSimpleContractDto)oneGrpItem.obj);
                            }
                            System.debug('oneGrpList = '+oneGrpList);
                            allGrpArray.add(new MapWrapper(oneGrpList, maxEndDate, null));
                        }
                    }
                }
            }
            if (!allGrpArray.isEmpty()) {
                allGrpArray.sort();
                for (MapWrapper grpItem : allGrpArray) {
                    serviceList.add((List<CommonResponseSimpleContractDto>)grpItem.obj);
                }
            }
        }
        
        // TODO:
        serviceList = new List<List<CommonResponseSimpleContractDto>>();
        List<CommonResponseSimpleContractDto> serviceDtoList = new List<CommonResponseSimpleContractDto>();    
        
        serviceDtoList = new List<CommonResponseSimpleContractDto>();                        
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000092312', '入力不要', '入力不要', '電気', '提供中', '2018/05/20', '', 'ずっとも電気', '○', '-'));                      
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000092312', '入力不要', '入力不要', '電気トラサポ', '提供中', '2018/06/01', '', '-', '○', '-'));                      
		serviceList.add(serviceDtoList);
                
        serviceDtoList = new List<CommonResponseSimpleContractDto>();                        
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000092311', '入力不要', '入力不要', 'ガス', '開栓中', '2018/04/01', '', '一般契約', '○', '-'));
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000092311', '入力不要', '入力不要', 'ガストラサポ', '提供中', '2018/04/01', '', '-', '○', '-'));
		serviceList.add(serviceDtoList);        
                
        serviceDtoList = new List<CommonResponseSimpleContractDto>();                        
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000092310', '入力不要', '入力不要', 'ガス', '閉栓中', '2012/04/01', '2018/03/30', '一般契約', '○', '-'));
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000092310', '入力不要', '入力不要', 'ガストラサポ', '解約済', '2012/04/01', '2018/03/30', '-', '○', '-'));
		serviceList.add(serviceDtoList);   
        
        serviceDtoList = new List<CommonResponseSimpleContractDto>();                          
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000093101', '001', '004', 'ガス', '開栓中', '2018/04/01', '', '一般契約', '○', '-'));                
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000093102', '010', '003', '域外ガス', '開栓中', '2018/04/01', '', '一般契約', '○', '-'));                    
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000093103', '006', '007', '電気', '提供中', '2018/05/20', '', 'ずっとも電気', '○', '-'));          
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000093104', '003', '016', 'TESメンテ', '開栓中', '2018/04/01', '', '一般契約', '○', '-'));          
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000093105', '012', '014', 'スペサポ', '開栓中', '2018/04/01', '', '一般契約', '○', '-'));    
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000093111', '0011', '004', 'ガストラサポ', '提供中', '2018/04/01', '', '-', '○', '-'));                      
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000093161', '0061', '007', '電気トラサポ', '提供中', '2018/06/01', '', '-', '○', '-'));     
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000093108', '008', '010', '駆けつけ', '開栓中', '2018/04/01', '', '一般契約', '○', '-'));        
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000093104', '004', '003', '警報器リース', '開栓中', '2018/04/01', '', '一般契約', '○', '-'));        
        serviceDtoList.add(new CommonResponseSimpleContractDto(
        '30000093107', '007', '009', 'トリプル割', '開栓中', '2018/04/01', '', '一般契約', '○', '-'));                         
		serviceList.add(serviceDtoList);
        return serviceList;
    }

    /**
     * 顧客ID検索Apiのコール
     * 
     * @return 　
     *       顧客ID検索結果を戻る
     * */
    public List<List<CommonResponseSimpleContractDto>> getCustomerKey() {
        // レスポンス戻る値が異常の場合
        if (response.getStatusCode() != 200) {
            // エラーメッセージを設定する
            errorMessage = response.getBody();
            return null;
        }
        List<List<CommonResponseSimpleContractDto>> serviceList = new List<List<CommonResponseSimpleContractDto>>();
        // レスポンスボディーからデータを取得する
        JSONParser parser = JSON.createParser(response.getBody());
        ResponseData data = (ResponseData) parser.readValueAs(ResponseData.class);
        
        if (data == null) {
            errorMessage = 'レスポンスフォーマット例外';
            return null;
        }
        if (data.error != null && data.error.errorCode != null) {
            errorCode = data.error.errorCode;
            errorMessage = data.error.message;
            return null;
        }
        if (data.keyGroupList != null) {
            for (KeyGroup keyGroup : data.keyGroupList) {
                if (keyGroup.serviceList != null) {
                    for (ServiceDto serviceDto : keyGroup.serviceList) {
                        if (serviceDto == null) {
                            System.debug(' serviceDto is null ');
                            continue;
                        }
                        List<CommonResponseSimpleContractDto> oneGrpList = new List<CommonResponseSimpleContractDto>();
                        // ユーザーリスト
                        List<UserDto> userDtoList = serviceDto.userList;
                    	for (UserDto userDto : userDtoList) {
                            if (userDto == null
                                || userDto.userKeys == null
                                || userDto.services == null
                                || String.isBlank(userDto.services.serviceType)) {
                                    continue;
                            }
                            // サービス契約種別
                            String serviceType = userDto.services.serviceType;
                            system.debug(Logginglevel.INFO, 'serviceType: ' + serviceType);
                            // ユーザーキー
                            // お客さま登録番号(3x)や顧客特定Keyが格納される
                            String userKey = getUserKey(serviceType, userDto.userKeys);
                            system.debug(Logginglevel.INFO, 'userKey: ' + userKey);
                            CommonResponseSimpleContractDto dto = new CommonResponseSimpleContractDto(
                                    userKey
                                    , serviceType
                                    , ''
                                    , ''
                                    , ''
                                    , ''
                                    , ''
                                    , ''
                                    , ''
                                    , ''
                                );
                            System.debug('***** add 1');
                            oneGrpList.add(dto);
                            System.debug('***** add 2');
                    	}
                        if (!oneGrpList.isEmpty()) {
                            System.debug('oneGrpList = '+oneGrpList);
                            serviceList.add(oneGrpList);
                        }
                    }
                }
            }
        }
        return serviceList;
    }

    private class MapWrapper implements Comparable {
        public Object obj;
        public Object sortKey;
        public Object sortKey2;
        public MapWrapper(Object obj, Object sortKey, Object sortKey2) {
            this.obj = obj;
            this.sortKey = sortKey;
            this.sortKey2 = sortKey2;
        }
        public Integer compareTo(Object other) {
            if (sortKey instanceof String){
                if ((String)((MapWrapper)other).sortKey == (String)sortKey) {
                    return (String)((MapWrapper)other).sortKey2 > (String)sortKey2 ? 1 : -1;
                } else {
                    return (String)((MapWrapper)other).sortKey > (String)sortKey ? -1 : 1;
                }
            } else if (sortKey instanceof Date){
                if (other != null){
                    if (Date.valueOf(((MapWrapper)other).sortKey) >= Date.valueOf(sortKey)) {
                        return 1;
                    } else {
                        return -1;
                    }
                }
            }
            return 0;
        }
    }
    
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

    private String getStatusSort(String status) {
        if (String.isNotBlank(status) && !'-'.equals(status)) {
            return SERVICE_SORT_STATUS.get(status);
        }
        return '99';
    }

    private Map<String, String> getServiceStatus(List<Transfer> transfers) {
        // ToDo: 日付の参照と仕様確認
        Map<String, String> retMap = new Map<String, String>();
        if (transfers == null) {
            retMap.put('start', '-');
            retMap.put('end', '-');
            retMap.put('status', '-');
            return retMap;
        }
        Map<String, String> transferMap = new Map<String, String>();
        for (Transfer transfer : transfers) {
            transferMap.put(transfer.transferType, transfer.transferYmd);
        }
        if (transferMap.containsKey('05')) {
            retMap.put('end', transferMap.get('05'));
            retMap.put('status', SERVICE_STATUS.get('05'));
        } else if (transferMap.containsKey('04')) {
            retMap.put('end', transferMap.get('04'));
            retMap.put('status', SERVICE_STATUS.get('04'));
        } else if (transferMap.containsKey('03')) {
            retMap.put('end', transferMap.get('03'));
            retMap.put('status', SERVICE_STATUS.get('03'));
        } else if (transferMap.containsKey('02')) {
            retMap.put('end', '');
            retMap.put('status', SERVICE_STATUS.get('02'));
        } else if (transferMap.containsKey('01')) {
            retMap.put('end', '');
            retMap.put('status', SERVICE_STATUS.get('01'));
        }
        if (transferMap.containsKey('01')) {
            retMap.put('start', transferMap.get('01'));
        } else if (transferMap.containsKey('02')) {
            retMap.put('start', transferMap.get('02'));
        } else {
            retMap.put('start', '-');
        }
        return retMap;
    }

    private class ResponseData {
        private List<KeyGroup> keyGroupList;
        private Error error;
        
        private ResponseData(List<KeyGroup> groupLkeyGroupListist, Error error) {
            keyGroupList = groupLkeyGroupListist.clone();
            error = error.clone();
        }
    }

    private class KeyGroup {
        private List<ServiceDto> serviceList;
        
        private KeyGroup(List<ServiceDto> serviceList) {
            serviceList = serviceList.clone();
        }
    }  

    private class Error {
        private String statusCode;
        private String errorCode;
        private String message;
        
        private Error(String statusCode, String errorCode, Service message) {
            statusCode = statusCode;
            errorCode = errorCode;
            message = message;
        }
    }  

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
    
    private class ServiceDto {
        private String indexId;
        private List<UserDto> userList;
        
        private ServiceDto(String indexId, List<UserDto> userList) {
            indexId = indexId;
            userList = userList.clone();
        }
    } 
    
    private class UserDto {
        private List<UserKey> userKeys;
        private Service services;
        
        private UserDto(List<UserKey> userKeys, List<Service> services) {
            userKeys = userKeys.clone();
            services = services.clone();
        }
    }

    private class UserKey {
        private String keyType;
        private String userKey;
        private UserKey(String keyType, String userKey) {
            keyType = keyType;
            userKey = userKey;
        }
    }

    private class Service {
        private String serviceId;
        private String serviceType;
        private List<Role> roles;
        private List<Transfer> transfers;
        private List<Key> keys;
        
        private Service(String serviceId, String serviceType, List<Role> roles, List<Transfer> transfers, List<Key> keys) {
            serviceId = serviceId;
            serviceType = serviceType;
            roles = roles.clone();
            transfers = transfers.clone();
            keys = keys.clone();
        }
    }

    private class Role {
        private String roleType;
        private String transferYmd;
        private Role(String roleType, String transferYmd) {
            roleType = roleType;
            transferYmd = transferYmd;
        }
    }

    private class Transfer {
        private String transferType;
        private String transferYmd;
        private Transfer(String transferType, String transferYmd) {
            transferType = transferType;
            transferYmd = transferYmd;
        }
    }

    private class Key {
        private String systemType;
        private String keyType;
        private String serviceKey;
        private String startYmd;
        private Key(String systemType, String keyType, String serviceKey, String startYmd) {
            systemType = systemType;
            keyType = keyType;
            serviceKey = serviceKey;
            startYmd = startYmd;
        }
    }
}