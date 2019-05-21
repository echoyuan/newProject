/**
 * [ガス]ガスメータ設置場所情報APIリクエスト共通処理
 */
public with sharing class CommonGasMeterSetApi extends CommonAbstractRequestApi {
    // API通信エラーメッセージ
    private final String messageHeader = '[ガスメータ設置場所情報API]の通信に失敗しました。';
    /** URL パラメータ*/
    private static final String GMT_SET_NO_URL_KEY = 'gmt_set_no';
    private static final String SYOKY_NO_URL_KEY = 'syoky_no';
    private String gmtSetNo = '';
    private String syokyNo = '';
    private ResponseData data;
    
    public CommonGasMeterSetApi(String gmtSetNo, String syokyNo, Integer limitNumC, Integer offsetC) {
        this.gmtSetNo = gmtSetNo;
        this.syokyNo = syokyNo;
        limitNum = limitNumC;
        offset = offsetC;
    }
    
    /**
    * レスポンス結果の設定
    * 
    * */
    public void parseResponseData() {
        try{
            // レスポンスボディーからデータを取得する
            JSONParser parser = JSON.createParser(getResponse().getBody());
            data = (ResponseData) parser.readValueAs(ResponseData.class);
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
        String url = fullPath + CommonConstantsUtil.QUERY_MARK;
        if (String.isNotBlank(gmtSetNo)) {
            url += GMT_SET_NO_URL_KEY 
                + CommonConstantsUtil.EQUAL_MARK  
                + gmtSetNo;
        } else {
            url += SYOKY_NO_URL_KEY 
                + CommonConstantsUtil.EQUAL_MARK  
                + syokyNo;
        }
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
    
    /**
    * ガスメータ設置場所情報を取得(クエリパラメータ:ガス契約ID、「ガスメータ特定一覧」画面表示仕様)
    * 
    * @return 　
    *       ガスメータ設置場所情報を返却する
    * */
    public List<CommonGasMeterSetResponseDto> getGasMeterSetListInfoBy4X() {
        List<CommonGasMeterSetResponseDto> commonGasMeterSetResponseDtoList = new List<CommonGasMeterSetResponseDto>();
        // 返却成功の場合
        if ('success'.equals(data.result)) {
            if (data.gasMeterPlaceResponseDtoList != null && !data.gasMeterPlaceResponseDtoList.isEmpty()) {
                for (GasMeterSetResponseDto gasMeterSetResponseDto : data.gasMeterPlaceResponseDtoList) {
                    CommonGasMeterSetResponseDto dto = getGasMeterSetResponseDto(gasMeterSetResponseDto);
                    commonGasMeterSetResponseDtoList.add(dto);
                }
            }
            return commonGasMeterSetResponseDtoList;
        }
        
        try{
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
    * ガスメータ設置場所情報を取得(クエリパラメータ:ガス契約ID、「お客さま基本情報照会」画面表示仕様)
    * 
    * @return 　
    *       ガスメータ設置場所情報を返却する
    * */
    public CommonGasMeterSetResponseDto getGasMeterSetInfoBy4X() {
        // 返却成功の場合
        if ('success'.equals(data.result)) {
            List<GasMeterSetResponseDto> gasMeterPlaceResponseDtoList = data.gasMeterPlaceResponseDtoList;
            if (gasMeterPlaceResponseDtoList != null && !gasMeterPlaceResponseDtoList.isEmpty()) {
                return getGasMeterSetResponseDto(gasMeterPlaceResponseDtoList[0]);
            }
            return null;
        }
        try{
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
    * ガスメータ設置場所情報を取得(クエリパラメータ:ガスメータ設置場所ID、「お客さま基本情報照会」画面表示仕様)
    * 
    * @return 　
    *       ガスメータ設置場所情報を返却する
    * */
    /*public CommonGasMeterSetResponseDto getGasMeterSetInfoBy1X() {
        // 返却成功の場合
        if ('success'.equals(data.result)) {
            List<GasMeterSetResponseDto> gasMeterSetResponseDtoList = data.gasMeterPlaceResponseDtoList;
            if (gasMeterSetResponseDtoList != null && !gasMeterSetResponseDtoList.isEmpty()) {
                return getGasMeterSetResponseDto(gasMeterSetResponseDtoList[0]);
            }
            return null;
        }
        try{
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
    }*/
    
    private CommonGasMeterSetResponseDto getGasMeterSetResponseDto(GasMeterSetResponseDto gasMeterSetResponseDto) {
        CommonGasMeterSetResponseDto dto = new CommonGasMeterSetResponseDto();
        // メータ状態
        String gmtStatus = convertStatus(gasMeterSetResponseDto.gmt_khsen_jt_cd, gasMeterSetResponseDto.kyn_gmt_se_j_cd);
        // PKガスメータ設置場所/番号
        dto.gmtSetNo = CommonConvertUtil.formatNoStr(gasMeterSetResponseDto.gmt_set_no);
        // ガス/使用契約/番号
        dto.syokyNo = gasMeterSetResponseDto.syoky_no;
        // PK社番/番号
        dto.syabanNo = gasMeterSetResponseDto.syaban_no;
        // PK社番通し/番号
        dto.syabanSeqNo = gasMeterSetResponseDto.syaban_seq_no;
        // ガスメータ取付/年月日
        dto.gmtTritukeYmd = CommonConvertUtil.formatDateStr(gasMeterSetResponseDto.gmt_trituke_ymd);
        // ガスメータ取外/年月日
        dto.gmtTrihazsYmd = CommonConvertUtil.formatDateStr(gasMeterSetResponseDto.gmt_trihazs_ymd);
        // PK適用開始/年月日
        dto.startYmd = CommonConvertUtil.formatDateStr(gasMeterSetResponseDto.start_ymd);
        // 適用終了/年月日
        dto.endYmd = CommonConvertUtil.formatDateStr(gasMeterSetResponseDto.end_ymd);
        // 開栓/年月日
        dto.ksenYmd = CommonConvertUtil.formatDateStr(gasMeterSetResponseDto.ksen_ymd);
        // 閉栓/年月日
        dto.hsenYmd = CommonConvertUtil.formatDateStr(gasMeterSetResponseDto.hsen_ymd);
        // 棟番/カナ
        dto.munebanKn = gasMeterSetResponseDto.muneban_kn;
        // 部屋番/カナ
        dto.heyabanKn = gasMeterSetResponseDto.heyaban_kn;
        // 往訪時目標/漢字
        dto.ohojiMokhyoKj = gasMeterSetResponseDto.ohoji_mokhyo_kj;
        // ガスメータ開閉栓状態/コード
        dto.gmtKhsenJtCd = gasMeterSetResponseDto.gmt_khsen_jt_cd;
        // ガスメータ開閉栓状態/コード(デコード)
        dto.gmtKhsenJtCdDcd = gasMeterSetResponseDto.gmt_khsen_jt_cd_dcd;
        // 供内管・メータ設備状態/コード
        dto.kynGmtSeJCd = gasMeterSetResponseDto.kyn_gmt_se_j_cd;
        // 供内管・メータ設備状態/コード(デコード)
        dto.kynGmtSeJCdDcd = gasMeterSetResponseDto.kyn_gmt_se_j_cd_dcd;
        // ガスメータ型式記号/コード
        dto.gmtKataKigCd = gasMeterSetResponseDto.gmt_kata_kig_cd;
        // ガスメータ型式記号/コード(デコード)
        dto.gmtKataKigCdDcd = gasMeterSetResponseDto.gmt_kata_kig_cd_dcd;
        // ガスメータ号数/流量
        dto.gmtGoSu = gasMeterSetResponseDto.gmt_go_su;
        // ＧＨＰメータ設置/コード
        dto.ghpGmtSetCd = gasMeterSetResponseDto.ghp_gmt_set_cd;
        // ＧＨＰメータ設置/コード(デコード)
        dto.ghpGmtSetCdDcd = gasMeterSetResponseDto.ghp_gmt_set_cd_dcd;
        // ガスメータ取付位置/コード
        dto.gmtTrtItiCd = gasMeterSetResponseDto.gmt_trt_iti_cd;
        // ガスメータ取付位置/コード(デコード)
        dto.gmtTrtItiCdDcd = gasMeterSetResponseDto.gmt_trt_iti_cd_dcd;
        // 閉栓手段/コード
        dto.hsenSydnCd = gasMeterSetResponseDto.hsen_sydn_cd;
        // 閉栓手段/コード(デコード)
        dto.hsenSydnCdDcd = gasMeterSetResponseDto.hsen_sydn_cd_dcd;
        dto.gmtStatus = gmtStatus;
        
        return dto;
        
    }
    
    private String convertStatus(String gmtKhsenJtCd, String kynGmtSeJCd) {
        // メータ状態
        String gmtStatus = '';
        
        // ガスメータ開閉栓状態/コード＝"1" && 供内管・メータ設備状態/コード＝"1"の場合
        if (CommonConstantsUtil.GMT_KHSEN_JT_CD_1.equals(gmtKhsenJtCd) && CommonConstantsUtil.KYN_GMT_SE_J_CD_1.equals(kynGmtSeJCd)) {
            // 「メータ状態」＝"開栓中"
            gmtStatus = CommonConstantsUtil.GMT_STATUS_OPENING;
            // ガスメータ開閉栓状態/コード＝"2" && 供内管・メータ設備状態/コード＝"1"の場合
        } else if(CommonConstantsUtil.GMT_KHSEN_JT_CD_2.equals(gmtKhsenJtCd) && CommonConstantsUtil.KYN_GMT_SE_J_CD_1.equals(kynGmtSeJCd)) {
            // 「メータ状態」＝"閉栓中"
            gmtStatus = CommonConstantsUtil.GMT_STATUS_CLOSING;
            // ガスメータ開閉栓状態/コード＝"2" && 供内管・メータ設備状態/コード＝"2"の場合 
        } else if(CommonConstantsUtil.GMT_KHSEN_JT_CD_2.equals(gmtKhsenJtCd) && CommonConstantsUtil.KYN_GMT_SE_J_CD_2.equals(kynGmtSeJCd)) {
            // 「メータ状態」＝"休止中"
            gmtStatus = CommonConstantsUtil.GMT_STATUS_RESTING;
            // ガスメータ開閉栓状態/コード＝"2" && 供内管・メータ設備状態/コード＝"3" or "4"の場合  
        } else if(CommonConstantsUtil.GMT_KHSEN_JT_CD_2.equals(gmtKhsenJtCd)
            && (CommonConstantsUtil.KYN_GMT_SE_J_CD_3.equals(kynGmtSeJCd) || CommonConstantsUtil.KYN_GMT_SE_J_CD_4.equals(kynGmtSeJCd))) {
                // 「メータ状態」＝"撤去済"
                gmtStatus = CommonConstantsUtil.GMT_STATUS_WITHDRAWED;
                // ガスメータ開閉栓状態/コード＝"9" && 供内管・メータ設備状態/コード＝"9"の場合
        } else if(CommonConstantsUtil.GMT_KHSEN_JT_CD_9.equals(gmtKhsenJtCd) && CommonConstantsUtil.KYN_GMT_SE_J_CD_9.equals(kynGmtSeJCd)) {
            // 「メータ状態」＝"抹消"
            gmtStatus = CommonConstantsUtil.GMT_STATUS_ERASE;
        }
        return gmtStatus;
    }
    
    private class ResponseData extends CommonApiResponseData {
        private List<GasMeterSetResponseDto> gasMeterPlaceResponseDtoList{ get; set; }
    }
    
    private class GasMeterSetResponseDto {
        // PKガスメータ設置場所/番号
        private String gmt_set_no{ get; set; }
        // ガス/使用契約/番号
        private String syoky_no{ get; set; }
        // PK社番/番号
        private String syaban_no{ get; set; }
        // PK社番通し/番号
        private String syaban_seq_no{ get; set; }
        // ガスメータ取付/年月日
        private String gmt_trituke_ymd{ get; set; }
        // ガスメータ取外/年月日
        private String gmt_trihazs_ymd{ get; set; }
        // PK適用開始/年月日
        private String start_ymd{ get; set; }
        // 適用終了/年月日
        private String end_ymd{ get; set; }
        // 開栓/年月日
        private String ksen_ymd{ get; set; }
        // 閉栓/年月日
        private String hsen_ymd{ get; set; }
        // 棟番/カナ
        private String muneban_kn{ get; set; }
        // 部屋番/カナ
        private String heyaban_kn{ get; set; }
        // 往訪時目標/漢字
        private String ohoji_mokhyo_kj{ get; set; }
        // ガスメータ開閉栓状態/コード
        private String gmt_khsen_jt_cd{ get; set; }
        // ガスメータ開閉栓状態/コード(デコード)
        private String gmt_khsen_jt_cd_dcd{ get; set; }
        // 供内管・メータ設備状態/コード
        private String kyn_gmt_se_j_cd{ get; set; }
        // 供内管・メータ設備状態/コード(デコード)
        private String kyn_gmt_se_j_cd_dcd{ get; set; }
        // ガスメータ型式記号/コード
        private String gmt_kata_kig_cd{ get; set; }
        // ガスメータ型式記号/コード(デコード)
        private String gmt_kata_kig_cd_dcd{ get; set; }
        // ガスメータ号数/流量
        private String gmt_go_su{ get; set; }
        // ＧＨＰメータ設置/コード
        private String ghp_gmt_set_cd{ get; set; }
        // ＧＨＰメータ設置/コード(デコード)
        private String ghp_gmt_set_cd_dcd{ get; set; }
        // ガスメータ取付位置/コード
        private String gmt_trt_iti_cd{ get; set; }
        // ガスメータ取付位置/コード(デコード)
        private String gmt_trt_iti_cd_dcd{ get; set; }
        // 閉栓手段/コード
        private String hsen_sydn_cd{ get; set; }
        // 閉栓手段/コード(デコード)
        private String hsen_sydn_cd_dcd{ get; set; }
    }

    /**
     * タイムアウト、リトライ、ログ出力など設定
     * */
    public override void setApiCustomerInfo() {
        // APIリクエストタイプ
        apiRequestType = 'GasMeterSetApi';
        // 環境変数APIタイプ
        envApiRequestType = CommonConstantsUtil.API_TYPE_GAS;
        // API通信エラーメッセージ
        message = this.messageHeader;
        // クラス名
        className = 'CommonGasMeterSetApi';
    }
}