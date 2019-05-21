public class CommonApiRequestKeys {
    public Integer statusCode { get; set; }
    public String errorCode { get; set; }
    public String errorMessage { get; set; }

    private HttpRequest request = null;
    private HttpResponse response = null;

    private final List<String> DEFAULT_SERVICES = new List<String>{'001', '006', '009', '010', '008', '007', '012', '002', '004', '003'};
    private final String TGCRM_SERVICE_TYPE = 'A01';
    private final Map<String, String> SERVICE_USER_KEY_TYPE =
        new Map<String, String>{
            '001' => '003',    // ガス：お客さま登録番号(3x)
            '006' => '003',    // 電気：お客さま登録番号(3x)
            '009' => '011',    // myTOKYOGAS：会員ID
            '010' => '003',    // 域外ガス：お客さま登録番号(3x)
            '008' => '010',    // 駆け付けサービス：P番
            '007' => '010',    // 光通信：P番
            '012' => '015',    // 有償メンテ：くらしお客さま番号
            '002' => '016',    // くらし見守り：くらし見守りID(仮)
            '004' => '017',    // 警報器リース：警報器リースID(仮)
            '003' => '018',    // ＴＥＳメンテナンス：ＴＥＳメンテナンスID(仮)
            'A01' => '019'     // TG-CRM：顧客識別ID(仮)
        };
    private final Map<String, String> SERVICE_KEY_TYPE =
        new Map<String, String>{
            '001' => '004',    // ガス：ガス使用契約番号(ガス4x)
            '006' => '007',    // 電気：電力契約番号(SA)
            '009' => '011',    // myTOKYOGAS：会員ID
            '010' => '003',    // 域外ガス：お客さま登録番号(3x)
            '008' => '010',    // 駆け付けサービス：P番
            '007' => '009',    // 光通信：光サービスID
            '012' => '014',    // 有償メンテ：くらしサービス番号
            '002' => '016',    // くらし見守り：くらし見守りID(仮)
            '004' => '017',    // 警報器リース：警報器リースID(仮)
            '003' => '018',    // ＴＥＳメンテナンス：ＴＥＳメンテナンスID(仮)
            'A01' => '019'     // TG-CRM：顧客識別ID(仮)
        };
    private final Map<String, String> SERVICE_NAME =
        new Map<String, String>{
            '001' => 'ガス',         // ガス：ガス使用契約番号(ガス4x)
            '006' => '電気',         // 電気：電力契約番号(SA)
            '009' => 'myTOKYOGAS',   // myTOKYOGAS：会員ID
            '010' => '域外ガス',     // 域外ガス：お客さま登録番号(3x)
            '008' => '駆け付け',     // 駆け付けサービス：駆け付けサービスID
            '007' => 'トリプル',     // 光通信：光サービスID
            '012' => '有償メンテ',   // 有償メンテ：有償メンテID(仮)
            '002' => 'くらし見守り', // くらし見守り：くらし見守りID(仮)
            '004' => '警報機リース', // 警報器リース：警報器リースID(仮)
            '003' => 'TESメンテ'     // ＴＥＳメンテナンス：ＴＥＳメンテナンスID(仮)
        };

    private final Map<String, String> SERVICE_STATUS =
        new Map<String, String>{
             '01' => '提供未',
            '02' => '提供中',
            '03' => '停止中',
            '04' => '解約済',
                //add
                '05' => '開栓中',
                '06' => '閉栓中',
                '007' => '契約中(開栓中)',
                '008' => '契約中',
                '0099' => '解約済(閉栓中)'
                ////add
                
        };

    public CommonApiRequestKeys(String endpoint) {
        request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint(endpoint);
    }

    public void send(List<String> keys) {
        send(keys, DEFAULT_SERVICES);
    }

    public void send(List<String> keys, List<String> services) {
        String body = getRequestBody(keys, services);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Content-Length', String.valueOf(body.length()));
        request.setHeader('Ocp-Apim-Subscription-Key', '989092bfe04943eeaa3885338fc24033');
//        request.setHeader('Host', 'tgcrm.azure-api.net');
//        request.setHeader('Hostaaa', 'aaaaa');
        //request.setBody(body);
        Http http = new Http();
        response = http.send(request);
        System.debug(Logginglevel.INFO, 'response code:' + response.getStatusCode());
        System.debug(Logginglevel.INFO, 'response body:' + response.getBody());
    }

    //yuan***********
    public void sendTest() {

        String body = '';
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeObjectField('services', 'services');
        gen.writeObjectField('keys', 'keys');
        gen.writeEndObject();
        body = gen.getAsString();
        //request.setBody(body);
        System.debug(Logginglevel.INFO, 'body code:' + body);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Content-Length', String.valueOf(body.length()));
        request.setHeader('Ocp-Apim-Subscription-Key', '989092bfe04943eeaa3885338fc24033');

        Http http = new Http();
        response = http.send(request);
        System.debug(Logginglevel.INFO, 'response code:' + response.getStatusCode());
        System.debug(Logginglevel.INFO, 'response body:' + response.getBody());
    }
    //yuan***********

    private String getRequestBody(List<String> keys, List<String> services) {
        String body = '';
        // debug mode only : true
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeObjectField('services', services);
        gen.writeObjectField('keys', keys);
        gen.writeEndObject();
        System.debug(Logginglevel.INFO, 'request body:' + gen.getAsString());

        return body;
    }

    // ToDo: 例外レスポンス処理詳細化
    // ToDo: 抽象化して個別実装を分ける
    public List<CommonResponseSimpleContractDto> getContractList() {
        if (response.getStatusCode() != 200) {
            errorMessage = response.getBody();
            return null;
        }
        List<CommonResponseSimpleContractDto> serviceList = new List<CommonResponseSimpleContractDto>();
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
                    for (Contract contract : keyGroup.serviceList) {
                        if (contract == null
                            || contract.userKeys == null
                            || contract.services == null
                            || String.isBlank(contract.services.serviceType)) {
                            continue;
                        }
                        system.debug(Logginglevel.INFO, 'Serialized contract: ' + JSON.serialize(contract));

                        String serviceType = contract.services.serviceType;
                        system.debug(Logginglevel.INFO, 'serviceType: ' + serviceType);
                        String userKey = getUserKey(serviceType, contract.userKeys);
                        system.debug(Logginglevel.INFO, 'userKey: ' + userKey);
                        String serviceKey = getServiceKey(serviceType, contract.services.keys);
                        system.debug(Logginglevel.INFO, 'servicekey: ' + serviceKey);
                        Map<String, String> transferMap = getServiceStatus(contract.services.transfers);
                        serviceList.add(
                            new CommonResponseSimpleContractDto(
                                  userKey
                                , serviceType
                                , String.isBlank(serviceKey) ? userKey : serviceKey
                                , SERVICE_NAME.get(serviceType)
                                , transferMap.get('status')
                                , transferMap.get('start')
                                , transferMap.get('end')
                                , '料金メニュー(固定)'
                                , '○'
                                , '確認フラグ(固定)'));
                        // テスト確認用
                        if ('006'.equals(serviceType)) {
                        serviceList.add(
                            new CommonResponseSimpleContractDto(
                                  userKey
                                , serviceType
                                , null
                                , '電気トラサポ'
                                , transferMap.get('status')
                                , transferMap.get('start')
                                , transferMap.get('end')
                                , '料金メニュー(固定)'
                                , '○'
                                , '確認フラグ(固定)'));
                        }
                    }
                }
            }
        }
        return serviceList;
    }

    // ToDo: 例外レスポンス処理詳細化
    // ToDo: 抽象化して個別実装を分ける
    public List<CommonResponseSimpleMtgDto> getMtgList() {
        if (response.getStatusCode() != 200) {
            errorMessage = response.getBody();
            return null;
        }
        List<CommonResponseSimpleMtgDto> serviceList = new List<CommonResponseSimpleMtgDto>();
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
                if (KeyGroup.serviceList != null) {
                    for (Contract contract : KeyGroup.serviceList) {
                        if (contract == null
                            || contract.userKeys == null
                            || contract.services == null
                            || String.isBlank(contract.services.serviceType)) {
                            continue;
                        }
                        system.debug(Logginglevel.INFO, 'Serialized contract: ' + JSON.serialize(contract));

                        String serviceType = contract.services.serviceType;
                        system.debug(Logginglevel.INFO, 'serviceType: ' + serviceType);
                        String userKey = getUserKey(serviceType, contract.userKeys);
                        system.debug(Logginglevel.INFO, 'userKey: ' + userKey);
                        String serviceKey = getServiceKey(serviceType, contract.services.keys);
                        system.debug(Logginglevel.INFO, 'servicekey: ' + serviceKey);
                        Map<String, String> transferMap = getServiceStatus(contract.services.transfers);
                        serviceList.add(
                            new CommonResponseSimpleMtgDto(
                                  String.isBlank(serviceKey) ? userKey : serviceKey
                                , transferMap.get('status')
                                , transferMap.get('start')
                                , transferMap.get('end')
                                , '本会員'
                                , '1000pt'));
                    }
                }
            }
        }
        return serviceList;
    }

    
    // Test
    public String getTestResponse() {
        return response.getBody();
    }

    // ToDo: 例外レスポンス処理詳細化
    // ToDo: 抽象化して個別実装を分ける
    public List<CommonResponseSimpleAccountDto> getAccountWithGpsList() {
        List<CommonResponseSimpleAccountDto> accountList = new List<CommonResponseSimpleAccountDto>();
        if (response.getStatusCode() != 200) {
            errorMessage = response.getBody();
            return accountList;
        }
        JSONParser parser = JSON.createParser(response.getBody());
        ResponseData data = (ResponseData) parser.readValueAs(ResponseData.class);
        if (data == null) {
            errorMessage = 'レスポンスフォーマット例外';
            return accountList;
        }
        if (data.error != null && data.error.errorCode != null) {
            errorCode = data.error.errorCode;
            errorMessage = data.error.message;
            return accountList;
        }
        if (data.keyGroupList != null) {
            for (KeyGroup keyGroup : data.keyGroupList) {
                if (keyGroup.serviceList != null) {
                    String accountId = '';
                    Boolean hasGas = false;
                    Boolean hasPower = false;
                    Boolean hasOther = false;
                    for (Contract contract : keyGroup.serviceList) {
                        if (contract == null
                            || contract.userKeys == null
                            || contract.services == null
                            || String.isBlank(contract.services.serviceType)) {
                            continue;
                        }
                        system.debug(Logginglevel.INFO, 'Serialized contract: ' + JSON.serialize(contract));

                        String serviceType = contract.services.serviceType;
                        system.debug(Logginglevel.INFO, 'serviceType: ' + serviceType);
                        String userKey = getUserKey(serviceType, contract.userKeys);
                        system.debug(Logginglevel.INFO, 'userKey: ' + userKey);
                        String serviceKey = getServiceKey(serviceType, contract.services.keys);
                        system.debug(Logginglevel.INFO, 'servicekey: ' + serviceKey);
                        if ('A01'.equals(serviceType)) {
                            accountId = userKey;
                        } else if ('001'.equals(serviceType)) {
                            hasGas = true;
                        } else if ('006'.equals(serviceType)) {
                            hasPower = true;
                        } else {
                            hasOther = true;
                        }
                    }
                    if (String.isNotBlank(accountId)) {
                        accountList.add(
                            new CommonResponseSimpleAccountDto(
                                accountId
                                , hasGas
                                , hasPower
                                , hasOther));
                    }
                }
            }
        }
        return accountList;
    }

    private String getUserKey(String serviceType, List<UserKey> userKeys) {
        String key = '';
        if (userKeys == null) {
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
        if (keys == null) {
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
        //add
        if (transferMap.containsKey('0099')) {
            retMap.put('end', transferMap.get('0099'));
            retMap.put('status', SERVICE_STATUS.get('0099'));
        } else if (transferMap.containsKey('008')) {
            
            retMap.put('status', SERVICE_STATUS.get('008'));
        }else if (transferMap.containsKey('007')) {
            
            retMap.put('status', SERVICE_STATUS.get('007'));
        }else
            //add
        if (transferMap.containsKey('04')) {
            retMap.put('end', transferMap.get('04'));
            retMap.put('status', SERVICE_STATUS.get('04'));
        } else if (transferMap.containsKey('03')) {
            retMap.put('end', transferMap.get('03'));
            retMap.put('status', SERVICE_STATUS.get('03'));
        } else if (transferMap.containsKey('02')) {
            retMap.put('end', '9999/99/99');
            retMap.put('status', SERVICE_STATUS.get('02'));
        } else if (transferMap.containsKey('01')) {
            retMap.put('end', '9999/99/99');
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
            keyGroupList = keyGroupList.clone();
            error = error.clone();
        }
    }

    private class KeyGroup {
        private List<Contract> serviceList;
        
        private KeyGroup(List<Contract> serviceList) {
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