/**
 * [電力]指図情報APIリクエスト共通処理
 */
public with sharing class CommonElectricityOperationOrderApi extends CommonAbstractRequestApi {
    // API通信エラーメッセージ
    private final String messageHeader = '[指図情報API]の通信に失敗しました。';
    /** URL パラメータ*/
    private static final String X3X_PARAM = 'x3X';
    private static final String SA_ID = 'saId';
    private String x3X = '';
    private String saId = '';

    public CommonElectricityOperationOrderApi(String x3X, String saId, Integer limitNumC, Integer offsetC) {
        this.x3X = x3X;
        this.saId = saId;
        limitNum = limitNumC;
        offset = offsetC;
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
        String strParameter = '';
        if (String.isNotBlank(x3X) && String.isNotBlank(saId)) {
            strParameter = 
                X3X_PARAM 
                + CommonConstantsUtil.EQUAL_MARK 
                + x3X 
                + CommonConstantsUtil.AND_MARK 
                + SA_ID 
                + CommonConstantsUtil.EQUAL_MARK 
                + saId;
        } else if (String.isNotBlank(x3X)) {
            strParameter = 
                X3X_PARAM 
                + CommonConstantsUtil.EQUAL_MARK 
                + x3X;
        } else if (String.isNotBlank(saId)) {
            strParameter = 
                SA_ID 
                + CommonConstantsUtil.EQUAL_MARK 
                + saId;
        }
        if (getLimitNum() != null) {
            strParameter += CommonConstantsUtil.AND_MARK 
                + CommonConstantsUtil.LIMIT_URL_KEY 
                + CommonConstantsUtil.EQUAL_MARK  
                + getLimitNum();
        }
        if (getOffset() != null) {
            strParameter += CommonConstantsUtil.AND_MARK 
                + CommonConstantsUtil.OFFSET_URL_KEY 
                + CommonConstantsUtil.EQUAL_MARK  
                + getOffset();
        }
        strParameter = CommonConstantsUtil.QUERY_MARK + strParameter;
        request.setEndpoint(fullPath + strParameter);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Ocp-Apim-Subscription-Key', securityKey);
    }

    /**
     * 指図情報の取得
     * 
     * @return 　
     *       指図情報を返却する
     * */
    public List<CommonOperationOrderResponseDto> getElectricityOperationOrderInfo() {
        List<CommonOperationOrderResponseDto> commonOperationOrderResponseDtoList = new List<CommonOperationOrderResponseDto>();
        
        JSONParser parser = null;
        ResponseData data = null;
        try{
            // レスポンスボディーからデータを取得する
            parser = JSON.createParser(getResponse().getBody());
            data = (ResponseData) parser.readValueAs(ResponseData.class);
        
            // 返却成功の場合
            if ('success'.equals(data.result)) {
                if (data.ResponseContractDto != null) {
                    List<OperationOrderDto> operationOrderDtoList = data.ResponseContractDto;
                    for(OperationOrderDto operationOrderDto : operationOrderDtoList) {
                        CommonOperationOrderResponseDto commonOperationOrderResponseDto = new CommonOperationOrderResponseDto();
                        commonOperationOrderResponseDto.saId = operationOrderDto.sa_id;
                        commonOperationOrderResponseDto.x3X = CommonConvertUtil.formatNoStr(operationOrderDto.x_3x);
                        commonOperationOrderResponseDto.xOperationOrderId = operationOrderDto.x_operation_order_id;
                        commonOperationOrderResponseDto.xOoTypeCd = operationOrderDto.x_oo_type_cd;
                        commonOperationOrderResponseDto.xOoTypeCdLabel = operationOrderDto.x_oo_type_cd_label;
                        commonOperationOrderResponseDto.xRegistrationDt = operationOrderDto.x_registration_dt;
                        commonOperationOrderResponseDto.dispGrpCd = operationOrderDto.disp_grp_cd;
                        commonOperationOrderResponseDto.dispGrpCdLabel = operationOrderDto.disp_grp_cd_label;
                        commonOperationOrderResponseDto.xPreffredDt = CommonConvertUtil.formatDateStr(operationOrderDto.x_preffred_dt);
                        commonOperationOrderResponseDto.xTimeZone = operationOrderDto.x_time_zone;
                        commonOperationOrderResponseDto.xTimeZoneLabel = operationOrderDto.x_time_zone_label;
                        commonOperationOrderResponseDto.xSchedDt = CommonConvertUtil.formatDateStr(operationOrderDto.x_sched_dt);
                        commonOperationOrderResponseDto.xFieldWorkDt = operationOrderDto.x_field_work_dt;
                        commonOperationOrderResponseDto.xOoStatusFlg = operationOrderDto.x_oo_status_flg;
                        commonOperationOrderResponseDto.xOoStatusFlgLabel = operationOrderDto.x_oo_status_flg_label;
                        commonOperationOrderResponseDto.xOoSubStatusFlg = operationOrderDto.x_oo_sub_status_flg;
                        commonOperationOrderResponseDto.xOoSubStatusFlgLabel = operationOrderDto.x_oo_sub_status_flg_label;
                        commonOperationOrderResponseDto.xPersonInService = operationOrderDto.x_person_in_service;
                        commonOperationOrderResponseDto.xStartReason = operationOrderDto.x_start_reason;
                        commonOperationOrderResponseDto.xStartReasonLabel = operationOrderDto.x_start_reason_label;
                        commonOperationOrderResponseDto.xStopReason = operationOrderDto.x_stop_reason;
                        commonOperationOrderResponseDto.xStopReasonLabel = operationOrderDto.x_stop_reason_label;
                        commonOperationOrderResponseDto.xApplicationDt = operationOrderDto.x_application_dt;
                        commonOperationOrderResponseDto.xOrderConcernedCat = operationOrderDto.x_order_concerned_cat;
                        commonOperationOrderResponseDto.xOrderConcernedCatLabel = operationOrderDto.x_order_concerned_cat_label;
                        commonOperationOrderResponseDto.xOrderName = operationOrderDto.x_order_name;
                        commonOperationOrderResponseDto.xOrderPhone = operationOrderDto.x_order_phone;
                        commonOperationOrderResponseDto.xLifevalNwCd = operationOrderDto.x_lifeval_nw_cd;
                        commonOperationOrderResponseDto.rsCd = operationOrderDto.rs_cd;
                        commonOperationOrderResponseDto.rsCdLabel = operationOrderDto.rs_cd_label;
                        commonOperationOrderResponseDto.xContractCur = operationOrderDto.x_contract_cur;
                        commonOperationOrderResponseDto.xContractCap = operationOrderDto.x_contract_cap;
                        commonOperationOrderResponseDto.xContractOp = operationOrderDto.x_contract_op;
                        commonOperationOrderResponseDto.saTypeCd = operationOrderDto.sa_type_cd;
                        commonOperationOrderResponseDto.saTypeCdLabel = operationOrderDto.sa_type_cd_label;
                        try{
                        	commonOperationOrderResponseDto.xUpdDttm = CommonConvertUtil.formatJpTime(operationOrderDto.x_upd_dttm);
                        }catch (Exception e) {
                            commonOperationOrderResponseDto.xUpdDttm = null;
                        }
                        commonOperationOrderResponseDtoList.add(commonOperationOrderResponseDto);
                    }
                }
                return commonOperationOrderResponseDtoList;
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

    private class ResponseData extends CommonApiResponseData {
        private List<OperationOrderDto> ResponseContractDto{ get; set; }
    }  

    /**
     * タイムアウト、リトライ、ログ出力など設定
     * */
    public override void setApiCustomerInfo() {
        // APIリクエストタイプ
        apiRequestType = 'ElectricityOperationOrderApi';
        // 環境変数APIタイプ
        envApiRequestType = CommonConstantsUtil.API_TYPE_ELECTRICITY;
        // API通信エラーメッセージ
        message = this.messageHeader;
        // クラス名
        className = 'CommonElectricityOperationOrderApi';
    }
    
    private class OperationOrderDto {
        // 電力契約番号		
        private String 	sa_id	{ get; set; }
        // お客さま登録番号		
        private String 	x_3x	{ get; set; }
        // 指図番号		
        private String 	x_operation_order_id	{ get; set; }
        // 指図タイプ		
        private String 	x_oo_type_cd	{ get; set; }
        // 指図タイプ(デコード)		
        private String 	x_oo_type_cd_label	{ get; set; }
        // 受付日		
        private String 	x_registration_dt	{ get; set; }
        // 担当箇所		
        private String 	disp_grp_cd	{ get; set; }
        // 担当箇所(デコード)		
        private String 	disp_grp_cd_label	{ get; set; }
        // 作業希望日		
        private String 	x_preffred_dt	{ get; set; }
        // 作業希望時間帯		
        private String 	x_time_zone	{ get; set; }
        // 作業希望時間帯(デコード)		
        private String 	x_time_zone_label	{ get; set; }
        // 作業予定日		
        private String 	x_sched_dt	{ get; set; }
        // 現場作業完了日		
        private String 	x_field_work_dt	{ get; set; }
        // ステータス		
        private String 	x_oo_status_flg	{ get; set; }
        // ステータス(デコード)		
        private String 	x_oo_status_flg_label	{ get; set; }
        // サブステータス		
        private String 	x_oo_sub_status_flg	{ get; set; }
        // サブステータス(デコード)		
        private String 	x_oo_sub_status_flg_label	{ get; set; }
        // 接客者		
        private String 	x_person_in_service	{ get; set; }
        // 使用開始理由		
        private String 	x_start_reason	{ get; set; }
        // 使用開始理由(デコード)		
        private String 	x_start_reason_label	{ get; set; }
        // 使用中止理由		
        private String 	x_stop_reason	{ get; set; }
        // 使用中止理由(デコード)		
        private String 	x_stop_reason_label	{ get; set; }
        // 申込日		
        private String 	x_application_dt	{ get; set; }
        // 申出人＿関係者種別		
        private String 	x_order_concerned_cat	{ get; set; }
        // 申出人＿関係者種別(デコード)		
        private String 	x_order_concerned_cat_label	{ get; set; }
        // 申出人＿おなまえ		
        private String 	x_order_name	{ get; set; }
        // 申出人＿連絡先		
        private String 	x_order_phone	{ get; set; }
        // 代行受付箇所		
        private String 	x_lifeval_nw_cd	{ get; set; }
        // 料金メニュー		
        private String 	rs_cd	{ get; set; }
        // 料金メニュー(デコード)		
        private String 	rs_cd_label	{ get; set; }
        // 契約電流		
        private String 	x_contract_cur	{ get; set; }
        // 契約容量		
        private String 	x_contract_cap	{ get; set; }
        // 契約電力		
        private String 	x_contract_op	{ get; set; }
        // 契約タイプ		
        private String 	sa_type_cd	{ get; set; }
        // 契約タイプ(デコード)		
        private String 	sa_type_cd_label	{ get; set; }
        // 更新日時
        private String 	x_upd_dttm	{ get; set; }
    }
}