/**
 * [ガス]ガス関連番号情報APIリクエスト共通処理
 */
public with sharing class CommonGasRelationNoApi extends CommonAbstractRequestApi {
    // API通信エラーメッセージ
    private final String messageHeader = '[ガス関連番号情報API]の通信に失敗しました。';
    /** ドメインURL */
    private static final String DOMAIN_URL = 'https://tgcrm-acp-api.azure-api.net/test/';
    /** SubApiパス */
    private static final String CONTRACT_SUB_URL = 'gasno-relation';
    /** セキュリティキー */
    private static final String SECURITY_KEY = '219f7e405cbc4adf949c066b8dca5b00';
    /** お客さまID */
    private static final String CST_REG_NO = 'cst_reg_no';
    private String cstNo = '';

    public CommonGasRelationNoApi(String cstNo) {
        this.cstNo = cstNo;
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
        request.setEndpoint(
            DOMAIN_URL
            + CONTRACT_SUB_URL
            + CommonConst.QUERY_MARK
            + CST_REG_NO
            + CommonConst.EQUAL_MARK
            + cstNo);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Ocp-Apim-Subscription-Key', SECURITY_KEY);
    }
    
    /**
     * ガス関連番号を取得
     * 
     * @return 　
     *       ガス関連番号を戻る
     * */
    public CommonGasRelationNoResponseDto getGasRelationNoInfo() {
        CommonGasRelationNoResponseDto commonGasRelationNoResponseDto = new CommonGasRelationNoResponseDto();
        
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
            //API定義(編集仕様)
            commonGasRelationNoResponseDto.cstNo = CommonConvertUtil.formatNoStr(data.cst_no);
            commonGasRelationNoResponseDto.gmtSetNo = CommonConvertUtil.formatNoStr(data.gmt_set_no);
            commonGasRelationNoResponseDto.shrkyNo = CommonConvertUtil.formatNoStr(data.shrky_no);
            commonGasRelationNoResponseDto.cstRegNo = CommonConvertUtil.formatNoStr(data.cst_reg_no);
            commonGasRelationNoResponseDto.syokyNo = CommonConvertUtil.formatNoStr(data.syoky_no);
            return commonGasRelationNoResponseDto;   
        }
        
        // 結果が異常の場合、または結果コードがある場合
        resultError(data);
        
        return null;
    }

    private class ResponseData extends CommonApiResponseData {
       // 表示用お客さま番号
        private String cst_no{ get; set; }
        // お客さま番号（1x）
        private String gmt_set_no{ get; set; }
        // お客さま番号（2x）
        private String shrky_no{ get; set; }
        // お客さま番号（3x）
        private String cst_reg_no{ get; set; }
        // お客さま番号（4x）
        private String syoky_no{ get; set; }
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
        className = 'CommonGasRelationNoApi';
    }
}