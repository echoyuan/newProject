/**
 * [電力]契約支払者情報APIリクエスト共通処理
 */
public with sharing class CommonElectricityPaymentApi extends CommonAbstractRequestApi {
    private final String messageHeader = '[契約支払者情報API]の通信に失敗しました。';
    /** ドメインURL */
    private static final String DOMAIN_URL = 'https://tgcrm-acp-api.azure-api.net/ele/';
    /** SubApiパス */
    private static final String CONTRACT_SUB_URL = 'payment';
    /** セキュリティキー */
    private static final String SECURITY_KEY = '219f7e405cbc4adf949c066b8dca5b00';
    /** 電力契約番号(SA)*/
    private String sa = '';

    /**
     * コンストラクタ
     * */
    public CommonElectricityPaymentApi(String sa) {
        this.sa = sa;
    }
    
    /**
    * お客さま情報を取得
    * 
    * @return お客さま情報を取得を戻る
   	* */
    public CommonElectricityPaymentResponseDto getElectricityPaymentInfo() {
        CommonElectricityPaymentResponseDto commonElectricityPaymentResponseDto = new CommonElectricityPaymentResponseDto();
       
        JSONParser parser = null;
        ResponseData data = null;
        try{
            // レスポンスボディーからデータを取得する
            parser = JSON.createParser(getResponse().getBody());
            data = (ResponseData) parser.readValueAs(ResponseData.class);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, messageHeader + CommonConst.ERR_CONTENT_TXT + e.getMessage());
            throw new ApiCallOutErrorException(e);
        } 
        
        // 返却成功の場合
        if (data.result == 'success') {
            commonElectricityPaymentResponseDto.saId = data.sa_id;
            commonElectricityPaymentResponseDto.xPayMethod = data.x_pay_method;
            commonElectricityPaymentResponseDto.xPayMethodLabel = data.x_pay_method_label;
            commonElectricityPaymentResponseDto.xPayerTo = data.x_payer_to;
            commonElectricityPaymentResponseDto.xPayerToLabel = data.x_payer_to_label;
            commonElectricityPaymentResponseDto.xPayerName = data.x_payer_name;
            commonElectricityPaymentResponseDto.xPayerNameKana = data.x_payer_name_kana;
            commonElectricityPaymentResponseDto.xPayerShopName = data.x_payer_shop_name;
            commonElectricityPaymentResponseDto.xPayerShopNameKana = data.x_payer_shop_name_kana;
            commonElectricityPaymentResponseDto.xPayerPostal = data.x_payer_postal;
            commonElectricityPaymentResponseDto.xPayerAddress1 = data.x_payer_address1;
            commonElectricityPaymentResponseDto.xPayerAddress2 = data.x_payer_address2;
            commonElectricityPaymentResponseDto.xPayerNum1 = data.x_payer_num1;
            commonElectricityPaymentResponseDto.xPayerAddress4 = data.x_payer_address4;
            return commonElectricityPaymentResponseDto;
        }
        
        // 結果が異常の場合、または結果コードがある場合
        resultError(data);
        
        return null;
    }
    
    /**
     * リクエストの設定
     * 
     * @param request　
     *       HttpRequest
     * */
    public override void setRequestInfo(HttpRequest request) {
		request.setHeader('Content-Length', '0');     
        request.setMethod(CommonConst.GET);
        request.setEndpoint(DOMAIN_URL + CONTRACT_SUB_URL);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Ocp-Apim-Subscription-Key', SECURITY_KEY);
    }
    
    private class ResponseData extends CommonApiResponseData {
        // 電力契約番号	
        private String 	sa_id { get; set; }
        // 支払方法	
        private String 	x_pay_method { get; set; }
        // 支払方法(名称)	
        private String 	x_pay_method_label { get; set; }
        // 支払者郵送先	
        private String 	x_payer_to { get; set; }
        // 支払者郵送先(名称)	
        private String 	x_payer_to_label { get; set; }
        // 支払者名	
        private String 	x_payer_name { get; set; }
        // 支払者名(カナ) 	
        private String 	x_payer_name_kana { get; set; }
        // 支払者_店名・屋号	
        private String 	x_payer_shop_name { get; set; }
        // 支払者_店名・屋号(カナ)	
        private String 	x_payer_shop_name_kana { get; set; }
        // 支払者郵便番号	
        private String 	x_payer_postal { get; set; }
        // 支払者住所和名	
        private String 	x_payer_address1 { get; set; }
        // 支払者建物名	
        private String 	x_payer_address2 { get; set; }
        // 支払者棟番	
        private String 	x_payer_num1 { get; set; }
        // 支払者部屋番	
        private String 	x_payer_address4 { get; set; }  
	}

    /**
     * タイムアウト、リトライ、ログ出力など設定
     * */
    public override void setApiCustomerInfo() {
        // sendのtimeout時間
        inOutTimeOut = 120000;
        // sendのリトライ間隔時間
        inOutSleepTime = 2000;
        // sendのリトライ回数
        inOutLoopCnt = 5;
        // ログ出力重要度
        notificationLevel = 1;
        // API通信エラーメッセージ
        message = this.messageHeader;
        // クラス名
        className = 'CommonElectricityPaymentApi';
    }
}