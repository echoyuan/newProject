/**
 * [電力]契約お客さま情報APIリクエスト共通処理
 */
public with sharing class CommonElectricityAccountApi extends CommonAbstractRequestApi {
    // API通信エラーメッセージ
    private final String messageHeader = '[契約お客さま情報API]の通信に失敗しました。';
    /** ドメインURL */
    private static final String DOMAIN_URL = 'https://tgcrm-acp-api.azure-api.net/ele/';
    /** SubApiパス */
    private static final String CONTRACT_SUB_URL = 'personInfo';
    /** セキュリティキー */
    private static final String SECURITY_KEY = '219f7e405cbc4adf949c066b8dca5b00';
    /** 電力契約番号(SA)*/
    private String sa = '';
    
    /**
     * コンストラクタ
     * */
    public CommonElectricityAccountApi(String sa) {
        this.sa = sa;
    }
    
    /**
    * お客さま情報を取得
    * 
    * @return お客さま情報を取得を戻る
   	* */
    public CommonElectricityAccountResponseDto getElectricityAccountInfo() {
        CommonElectricityAccountResponseDto commonElectricityAccountResponseDto = new CommonElectricityAccountResponseDto();
        
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
            commonElectricityAccountResponseDto.saId = data.sa_id;
            commonElectricityAccountResponseDto.postal = data.postal;
            commonElectricityAccountResponseDto.address1 = data.address1;
            commonElectricityAccountResponseDto.address2 = data.address2;
            commonElectricityAccountResponseDto.num1 = data.num1;
            commonElectricityAccountResponseDto.address4 = data.address4;
            commonElectricityAccountResponseDto.xPerName = data.x_per_name;
            commonElectricityAccountResponseDto.xPerNameKana = data.x_per_name_kana;
            commonElectricityAccountResponseDto.xShopName = data.x_shop_name;
            commonElectricityAccountResponseDto.xShopNameKana = data.x_shop_name_kana;
            commonElectricityAccountResponseDto.phone = data.phone;
            commonElectricityAccountResponseDto.xPhoneCat = data.x_phone_cat;
            commonElectricityAccountResponseDto.xPhoneCatLabel = data.x_phone_cat_label;
            commonElectricityAccountResponseDto.xContactCat = data.x_contact_cat;
            commonElectricityAccountResponseDto.xContactCatLabel = data.x_contact_cat_label;
            commonElectricityAccountResponseDto.xPhoneCheckCd = data.x_phone_check_cd;
            commonElectricityAccountResponseDto.xPhoneCheckCdLabel = data.x_phone_check_cd_label;
            return commonElectricityAccountResponseDto;
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
        private String sa_id { get; set; }
        // 郵便番号 
        private String postal { get; set; }
        // 住所和名 
        private String address1 { get; set; }
        // 建物名 
        private String address2 { get; set; }
        // 棟番 
        private String num1 { get; set; }
        // 部屋番 
        private String address4 { get; set; }
        // お客さま名 
        private String x_per_name { get; set; }
        // お客さま名(カナ) 
        private String x_per_name_kana { get; set; }
        // 店名・屋号 
        private String x_shop_name { get; set; }
        // 店名・屋号(カナ) 
        private String x_shop_name_kana { get; set; }
        // 電話番号１ 
        private String phone { get; set; }
        // 電話種別 
        private String x_phone_cat { get; set; }
        // 電話種別(名称) 
        private String x_phone_cat_label { get; set; }
        // 連絡先種別 
        private String x_contact_cat { get; set; }
        // 連絡先種別(名称) 
        private String x_contact_cat_label { get; set; }
        // 確認状態 
        private String x_phone_check_cd { get; set; }
        // 確認状態(名称) 
        private String x_phone_check_cd_label { get; set; }
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
        className = 'CommonElectricityAccountApi';
    }
}