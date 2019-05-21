/**
 * [電力]期間限定割情報APIリクエスト共通処理
 */
public with sharing class CommonElectricityTermLimitedApi extends CommonAbstractRequestApi {
    // API通信エラーメッセージ
    private final String messageHeader = '[期間限定割情報API]の通信に失敗しました。';
    /** URL パラメータ*/
    private static final String SA_PARAM = 'sa';
    private String sa = '';

    /**
     * コンストラクタ
     * */
    public CommonElectricityTermLimitedApi(String sa, Integer limitNumC, Integer offsetC) {
        this.sa = sa;
        limitNum = limitNumC;
        offset = offsetC;
    }
    
    /**
    * お客さま情報を取得
    * 
    * @return お客さま情報を取得を返却する
   	* */
    public List<CommonElectricityTermLimitedResponseDto> getElectricityTermLimitedInfo() {
        List<CommonElectricityTermLimitedResponseDto> commonTermLimitedResponseDtoList = new List<CommonElectricityTermLimitedResponseDto>();

        JSONParser parser = null;
        ResponseData data = null;
        try{
            // レスポンスボディーからデータを取得する
            parser = JSON.createParser(getResponse().getBody());
            data = (ResponseData) parser.readValueAs(ResponseData.class); 
            
            // 返却成功の場合
            if ('success'.equals(data.result)) {
                if (data.electricityTermLimitedDtoList != null) {
                    List<ElectricityTermLimitedDto> electricityTermLimitedDtoList = data.electricityTermLimitedDtoList;
                    for(ElectricityTermLimitedDto electricityTermLimitedDto : electricityTermLimitedDtoList) {
                        CommonElectricityTermLimitedResponseDto commonTermLimitedResponseDto = new CommonElectricityTermLimitedResponseDto();
                        commonTermLimitedResponseDto.saId = electricityTermLimitedDto.sa_id;
                        commonTermLimitedResponseDto.xLimitedCp = electricityTermLimitedDto.x_limited_cp;
                        commonTermLimitedResponseDto.xLimitedCpLabel = electricityTermLimitedDto.x_limited_cp_label;
                        commonTermLimitedResponseDto.xLimitedCpStartDt = CommonConvertUtil.formatDateStr(electricityTermLimitedDto.x_limited_cp_start_dt);
                        commonTermLimitedResponseDto.xLimitedCpEndDt = CommonConvertUtil.formatDateStr(electricityTermLimitedDto.x_limited_cp_end_dt);
                        commonTermLimitedResponseDtoList.add(commonTermLimitedResponseDto);
                    }
                    return commonTermLimitedResponseDtoList;
                }
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
     * タイムアウト、リトライ、ログ出力など設定
     * */
    public override void setApiCustomerInfo() {
        // APIリクエストタイプ
        apiRequestType = 'ElectricityTermLimitedApi';
        // 環境変数APIタイプ
        envApiRequestType = CommonConstantsUtil.API_TYPE_ELECTRICITY;
        // API通信エラーメッセージ
        message = this.messageHeader;
        // クラス名
        className = 'CommonElectricityTearmLimitedApi';    
    }
    
    /**
     * リクエストの設定
     * 
     * @param request　
     *       HttpRequest
     * */
    public override void setRequestInfo(HttpRequest request) {
		request.setHeader('Content-Length', '0');     
        request.setMethod(CommonConstantsUtil.GET);
        String url = 
            fullPath
            + CommonConstantsUtil.QUERY_MARK 
            + SA_PARAM 
            + CommonConstantsUtil.EQUAL_MARK  
            + sa;
        if (getLimitNum() != null) {
            url += CommonConstantsUtil.AND_MARK 
                + CommonConstantsUtil.LIMIT_URL_KEY 
                + CommonConstantsUtil.EQUAL_MARK  
                + getLimitNum();
        }
        if (getOffset() != null) {
            url += CommonConstantsUtil.AND_MARK 
                + CommonConstantsUtil.OFFSET_URL_KEY 
                + CommonConstantsUtil.EQUAL_MARK  
                + getOffset();
        }
        request.setEndpoint(url);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Ocp-Apim-Subscription-Key', securityKey);
    }
    
    public class ResponseData extends CommonApiResponseData {
        private List<ElectricityTermLimitedDto> electricityTermLimitedDtoList{ get; set; }  
	}
            
    public class ElectricityTermLimitedDto {
        // 電力契約番号 
        private String sa_id { get; set; }
        // 期間限定割種別 
        private String x_limited_cp { get; set; }
        // 期間限定割種別（名称） 
        private String x_limited_cp_label { get; set; }
        // 期間限定割適用開始日 
        private String x_limited_cp_start_dt { get; set; }
        // 期間限定割適用終了日 
        private String x_limited_cp_end_dt { get; set; }
    }  
}