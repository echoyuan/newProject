public class CommonGasPaymentApi {
    /** リクエスト */
    private HttpRequest request;
    /** レスポンス */
    private HttpResponse response;
     /** ドメインURL */
    private static final String DOMAIN_URL = 'https://tgcrm-acp-api.azure-api.net/test/';
    /** SubApiパス */
    private static final String CONTRACT_SUB_URL = 'payments';
    /** セキュリティキー */
    private static final String SECURITY_KEY = '219f7e405cbc4adf949c066b8dca5b00';
    /** URL */
    private static final String SHRKY_NO_URL_KEY = 'shrky_no';
    /** URL */
    private static final String LIMIT_URL_KEY = 'limit';
    /** URL */
    private static final String OFFSET_URL_KEY = 'offset';
  
    public HttpRequest getRequest() {
        return request;
    }

    public CommonGasPaymentApi(String shrkyNo, Integer limitNum, Integer offset) {
        request = new HttpRequest();
        // リクエスト情報（ヘッダ等）の設定
        setRequestInfo(shrkyNo, limitNum, offset);
    }
    
    /**
    * リクエストの発送
    * 
    * @param requestInput　
    *       発送されるリクエスト
    * */
    public void send() {
        Http http = new Http();
        System.debug('*******request:' + request);
        response = http.send(request);
        System.debug(Logginglevel.INFO, 'response code:' + response.getStatusCode());
        System.debug(Logginglevel.INFO, 'response body:' + response.getBody());
    }
    
    /**
    * 支払情報を取得
    * 
    * @return 　
    *       支払情報を戻る
    * */
    public List<CommonGasPaymentResponseDto> getPaymentListInfo() {
        List<CommonGasPaymentResponseDto> commonGasPaymentResponseDtoList = new List<CommonGasPaymentResponseDto>();
            
        // レスポンス戻る値が異常の場合
        if (response.getStatusCode() != 200) {
            // エラーメッセージを設定する
            //errorMessage = response.getBody();
            return null;
        }
        
        // レスポンスボディーからデータを取得する
        JSONParser parser = JSON.createParser(response.getBody());
        ResponseData data = (ResponseData) parser.readValueAs(ResponseData.class);
        
        if (data == null) {
            //errorMessage = 'レスポンスフォーマット例外';
            return null;
        }
        if (data.error != null && data.error.errorCode != null) {
            //errorCode = data.error.errorCode;
            //errorMessage = data.error.message;
            return null;
        }

        if (data.paymentResponseDtoList != null) {
            for (GasPaymentResponseDto gasPaymentResponseDto : data.paymentResponseDtoList) {
                CommonGasPaymentResponseDto dto = new CommonGasPaymentResponseDto();
                // 振替指定日の編集
                String transferDate = '';
                String shrStDdSbCd = gasPaymentResponseDto.shr_st_dd_sb_cd;
                // 支払指定日識別/コード＝"2"（日指定）の場合
                if (ConstantsUtil.SHR_ST_DD_SB_CD_2.equals(shrStDdSbCd)) {
                    // 支払指定/日＋"日"
                    transferDate = gasPaymentResponseDto.shr_st_dd + ConstantsUtil.DAY_TEXT;
                // 支払指定日識別/コード＝"5"（翌月日指定）の場合
                } else if (ConstantsUtil.SHR_ST_DD_SB_CD_5.equals(shrStDdSbCd)) {
                    // "翌月"＋支払指定/日＋"日"
                    transferDate = ConstantsUtil.NEXT_MONTH_TEXT + gasPaymentResponseDto.shr_st_dd + '日';
                // 支払指定日識別/コード＝"3"（支払期限日）、"4"（月末日）の場合
                } else if (ConstantsUtil.SHR_ST_DD_SB_CD_3.equals(shrStDdSbCd) || ConstantsUtil.SHR_ST_DD_SB_CD_4.equals(shrStDdSbCd)) {
                    // 支払指定日識別/コード（デコード）
                    transferDate = gasPaymentResponseDto.shr_st_dd_sb_cd_dcd;
                }
                
                gasPaymentResponseDto.transfer_date = transferDate;
                // お客さま番号
                dto.shrkyNo = gasPaymentResponseDto.shrky_no;
                // 内容有効開始/年月日
                dto.effctYmd = gasPaymentResponseDto.effct_ymd;
                // 内容有効期限/年月日
                dto.limitYmd = gasPaymentResponseDto.limit_ymd;
                // 料金支払方法/コード
                dto.rknShrHohCd = gasPaymentResponseDto.rkn_shr_hoh_cd;
                // 料金支払方法/コード(デコード)
                dto.rknShrHohCdDcd = gasPaymentResponseDto.rkn_shr_hoh_cd_dcd;
                // 支払指定日識別/コード
                dto.shrStDdSbCd = gasPaymentResponseDto.shr_st_dd_sb_cd;
                // 支払指定日識別/コード(デコード)
                dto.shrStDdSbCdDcd = gasPaymentResponseDto.shr_st_dd_sb_cd_dcd;
                // 支払指定/日
                dto.shrStDd = gasPaymentResponseDto.shr_st_dd;
                // 金融機関/コード
                dto.bnkCd = gasPaymentResponseDto.bnk_cd;
                // 金融機関名称
                dto.kiKinyunmg = gasPaymentResponseDto.ki_kinyunmg;
                // 支店名称
                dto.kiSitennmg = gasPaymentResponseDto.ki_sitennmg;
                // 預金種別/コード
                dto.yokinSybCd = gasPaymentResponseDto.yokin_syb_cd;
                //金融機関/コード＝"0900"（郵便局）の場合
                // 預金種別/コード(デコード)⇒ブランク
                // 以外の場合⇒預金種別/コード＋預金種別/コード(デコード)
                if (ConstantsUtil.YOKIN_SYB_CD_POST.equals(gasPaymentResponseDto.yokin_syb_cd)) {
                    dto.yokinSybCdDcd = '';
                } else {
                    dto.yokinSybCdDcd = gasPaymentResponseDto.yokin_syb_cd + gasPaymentResponseDto.yokin_syb_cd_dcd;
                }
                // お客さま口座/番号
                dto.cstKozaNo = gasPaymentResponseDto.cst_koza_no;
                // 支払者/お客さま登録/番号
                dto.shrsCstRegNo = gasPaymentResponseDto.shrs_cst_reg_no;
                // 請求サービス/コード
                dto.seiqSvcCd = dto.shrkyNo = gasPaymentResponseDto.seiq_svc_cd;
                // 請求サービス/コード(デコード)
                dto.seiqSvcCdDcd = gasPaymentResponseDto.seiq_svc_cd_dcd;
                // 振替指定日
                dto.transferDate = gasPaymentResponseDto.transfer_date;
       
				commonGasPaymentResponseDtoList.add(dto);
            }
        } 
        return commonGasPaymentResponseDtoList;
    }
   
     /**
     * リクエストの設定
     * @param shrkyNo　
     *       ガス契約ID
     * @param limitNum　
     *       取得レコード件数
     * @param offset　
     *       取得レコード開始位置
     * */
    public void setRequestInfo(String shrkyNo, Integer limitNum, Integer offset) {
        request.setHeader('Content-Length', '0');     
        request.setMethod(ConstantsUtil.GET);
        String url = DOMAIN_URL + CONTRACT_SUB_URL + ConstantsUtil.QUERY_MARK + SHRKY_NO_URL_KEY + ConstantsUtil.EQUAL_MARK  + shrkyNo;
        if (limitNum != null) {
            url += ConstantsUtil.AND_MARK + LIMIT_URL_KEY + ConstantsUtil.EQUAL_MARK  + limitNum;
        } else if (offset != null) {
            url += ConstantsUtil.AND_MARK + OFFSET_URL_KEY + ConstantsUtil.EQUAL_MARK  + offset;
        }
        request.setEndpoint(url);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Ocp-Apim-Subscription-Key', SECURITY_KEY);
        
    }
    
    
    private class ResponseData {
        private List<GasPaymentResponseDto> paymentResponseDtoList;
        private Error error;
        
        public ResponseData(List<GasPaymentResponseDto> paymentResponseDtoList, Error error) {
            paymentResponseDtoList = paymentResponseDtoList.clone();
            error = error.clone();
        }
    }
    
    private class GasPaymentResponseDto {
        // お客さま番号
        private String shrky_no;
        // 内容有効開始/年月日
        private String effct_ymd;
        // 内容有効期限/年月日
        private String limit_ymd;
        // 料金支払方法/コード
        private String rkn_shr_hoh_cd;
        // 料金支払方法/コード(デコード)
        private String rkn_shr_hoh_cd_dcd;
        // 支払指定日識別/コード
        private String shr_st_dd_sb_cd;
        // 支払指定日識別/コード(デコード)
        private String shr_st_dd_sb_cd_dcd;
        // 支払指定/日
        private String shr_st_dd;
        // 金融機関/コード
        private String bnk_cd;
        // 金融機関名称
        private String ki_kinyunmg;
        // 支店名称
        private String ki_sitennmg;
        // 預金種別/コード
        private String yokin_syb_cd;
        // 預金種別/コード(デコード)
        private String yokin_syb_cd_dcd;
        // お客さま口座/番号
        private String cst_koza_no;
        // 支払者/お客さま登録/番号
        private String shrs_cst_reg_no;
        // 請求サービス/コード
        private String seiq_svc_cd;
        // 請求サービス/コード(デコード)
        private String seiq_svc_cd_dcd;
        // 振替指定日
        private String transfer_date;
    
        public GasPaymentResponseDto(String shrky_no, String effct_ymd, String limit_ymd, String rkn_shr_hoh_cd,
                String rkn_shr_hoh_cd_dcd, String shr_st_dd_sb_cd, String shr_st_dd_sb_cd_dcd, String shr_st_dd,
                String bnk_cd, String ki_kinyunmg, String ki_sitennmg, String yokin_syb_cd, String yokin_syb_cd_dcd,
                String cst_koza_no, String shrs_cst_reg_no, String seiq_svc_cd, String seiq_svc_cd_dcd,
                String transfer_date) {
    
            this.shrky_no = shrky_no;
            this.effct_ymd = effct_ymd;
            this.limit_ymd = limit_ymd;
            this.rkn_shr_hoh_cd = rkn_shr_hoh_cd;
            this.rkn_shr_hoh_cd_dcd = rkn_shr_hoh_cd_dcd;
            this.shr_st_dd_sb_cd = shr_st_dd_sb_cd;
            this.shr_st_dd_sb_cd_dcd = shr_st_dd_sb_cd_dcd;
            this.shr_st_dd = shr_st_dd;
            this.bnk_cd = bnk_cd;
            this.ki_kinyunmg = ki_kinyunmg;
            this.ki_sitennmg = ki_sitennmg;
            this.yokin_syb_cd = yokin_syb_cd;
            this.yokin_syb_cd_dcd = yokin_syb_cd_dcd;
            this.cst_koza_no = cst_koza_no;
            this.shrs_cst_reg_no = shrs_cst_reg_no;
            this.seiq_svc_cd = seiq_svc_cd;
            this.seiq_svc_cd_dcd = seiq_svc_cd_dcd;
            this.transfer_date = transfer_date;
        }
    }
    
    private class Error {
        private String statusCode;
        private String errorCode;
        private String message;
        
        public Error(String statusCode, String errorCode, String message) {
            this.statusCode = statusCode;
            this.errorCode = errorCode;
            this.message = message;
        }
    }
}