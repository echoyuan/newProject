/**
 * ContractList sample
 */
public class ContractListController {
    public ContractListController() {
    }
    
    /**
     * 会員IDによって、契約リストを取得する
     * 
     * @param id　
     *       会員ID
     * @return 
     *       契約リスト
     * */
    @AuraEnabled
    public static CommonResponseDto getContractList(String id) {
        List<List<CommonResponseSimpleContractDto>> contractList = null;

        // 会員情報取得
        Account account = getAccountInfo(id);
        if (account == null) {
            // TODO
            // return new CommonResponseDto(40, '該当レコードなし', null, null);
        }        
        system.debug('*******:会員情報取得終了！');
        try {
            CommonContractApiRequest requestUtil = new CommonContractApiRequest();
            // リクエストの設定
        	system.debug('*********:setRequestInfo開始'+account);
            // TODO:account取得できません
            HttpRequest request = setRequestInfo(requestUtil.getRequest(), 'GET', 'https://tg.azure-api.net/test/test', '111');
            //HttpRequest request = setRequestInfo(requestUtil.getRequest(), 'POST', 'https://tg.azure-api.net/TokyoGas/postContractsList', '111');
            // リクエストの発送
            system.debug('*******:リクエストの発送開始！');
            requestUtil.send(request);
            // 共通メソッドで契約一覧の取得
            system.debug('*******:契約一覧の取得開始！');
            // TODO:画面変更していないので、共通API変更した対応案
            contractList = requestUtil.getContractList();
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new CommonResponseDto(100, 'システムエラー', null, null);
        }
        if (contractList == null) {
            return new CommonResponseDto(40, '契約情報取得失敗', null, null);
        }
        return new CommonResponseDto(0, null, contractList, null);
    }
    
    /**
     * リクエストの設定
     * 
     * @param request　
     *       リクエストオブジェクト
     * @param dataType　
     *       リクエストタイプ
     * @param endPoint　
     *       URL
     * @return 
     *       なし
     * */
    private static HttpRequest setRequestInfo(HttpRequest request, String dataType, String endPoint, String accountId) {
        if(dataType == 'GET'){
            request.setHeader('Content-Length', '0');
        }else{
        	setRequestBody(null, null, request, accountId);
        	request.setHeader('Content-Length', String.valueOf(request.getBody().length()));
        }
        request.setMethod(dataType);
        request.setEndpoint(endpoint);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Ocp-Apim-Subscription-Key', '989092bfe04943eeaa3885338fc24033');
        return request;
    }
    
    /**
     * リクエストボディーの設定
     * 
     * @param services　
     *       サービスリスト
     * @param keys　
     *       キーリスト
     * @param request　
     *       リクエストオブジェクト
     * @return 
     *       なし
     * */
    private static void setRequestBody(List<String> services, List<String> keys, HttpRequest request, String accountId) {
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        /*if (services == null) {
            gen.writeObjectField('services', ContractApiRequestUtil.DEFAULT_SERVICES);
        } else {
            gen.writeObjectField('services', services);
        }
        gen.writeObjectField('keys', keys);*/
        // TODO:
        gen.writeObjectField('memberId', accountId);
        gen.writeEndObject();
        System.debug(Logginglevel.INFO, 'request body:' + gen.getAsString());
        request.setBody(gen.getAsString());
    }

    /**
     * 会員にのみAxを初版する場合は専用の連番を取得
     * 
     * @param id　
     *       アカウントid
     * @return 
     *       アカウントオブジェクト
     * */
    private static Account getAccountInfo(String id) {
        // ToDo: 会員にのみAxを初版する場合は専用の連番を取得
        List<Account> accounts = [
            SELECT
                 id//,MemberID__c
            FROM
                Account
            WHERE
                Id =: id
        ];
        return !accounts.isEmpty() ? accounts.get(0) : null;
    }

    /**
     * 契約詳細情報取得
     * 
     * @param serviceType
     *       サービスタイプ
     * @param serviceKey
     *       アカウントid
     * @return 
     *       アカウントオブジェクト
     * */
    @AuraEnabled
    public static CommonResponseDto getContractDetail(String serviceType, String serviceKey) {
        CommonResponseGasContractDetailDto contract = null;
        try {
            CommonApiRequestGasDetail apiRequest = new CommonApiRequestGasDetail();
            apiRequest.send(serviceKey);
            if (apiRequest.contract == null) {
                return new CommonResponseDto(40, '契約情報取得失敗', null, null);
            }
            contract = apiRequest.contract;
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new CommonResponseDto(100, 'システムエラー', null, null);
        }
        return new CommonResponseDto(0, null, null, contract);
    }
    
    //add by yuan
    /**
     * 契約詳細情報(電力)取得
     * 
     * @param serviceType
     *       サービスタイプ
     * @param serviceKey
     *       アカウントid
     * @return 
     *       アカウントオブジェクト
     * */
    @AuraEnabled
    public static CommonResponseDto getElContractDetail(String serviceType, String serviceKey) {
        CommonResponseElContractDetailDto detail = null;
        try {
            CommonApiRequestElDetail apiRequest = new CommonApiRequestElDetail();
            apiRequest.send(serviceKey);
            if (apiRequest.contract == null) {
                return new CommonResponseDto(40, '契約情報取得失敗', null, null);
            }
            detail = apiRequest.contract;
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new CommonResponseDto(100, 'システムエラー', null, null);
        }
        return new CommonResponseDto(0, null, null, detail);
    }
    //add by yuan
}