public class CommonGasReceiveHistoryApi {
	/** リクエスト */
    private HttpRequest request;
    /** レスポンス */
    private HttpResponse response;
    /** ドメインURL */
    private static final String DOMAIN_URL = 'https://tgcrm-acp-api.azure-api.net/test/';
    /** SubApiパス */
    private static final String CONTRACT_SUB_URL = 'customers-historys';
    /** セキュリティキー */
    private static final String SECURITY_KEY = '219f7e405cbc4adf949c066b8dca5b00';
    /** URL */
    private static final String CST_REG_NO = 'cstRegNo';
    /** URL */
    private static final String LIMIT_URL_KEY = 'limit';
    /** URL */
    private static final String OFFSET_URL_KEY = 'offset';
    
    public HttpRequest getRequest() {
        return request;
    }
    
    public CommonGasReceiveHistoryApi(String cstRegNo, Integer limitNum, Integer offset) {
        request = new HttpRequest();
        // リクエスト情報（ヘッダ等）の設定
        setRequestInfo(cstRegNo, limitNum, offset);
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
     * リクエストの設定
     * @param cstRegNo　
     *       お客さまID
     *  @param limitNum　
     *       取得レコード件数
     *  @param offset　
     *       取得レコード開始位置
     * */
    public void setRequestInfo(String cstRegNo, Integer limitNum, Integer offset) {
        request.setHeader('Content-Length', '0');     
        request.setMethod(CommonConst.GET);
        String url = DOMAIN_URL + CONTRACT_SUB_URL + CommonConst.QUERY_MARK + CST_REG_NO + CommonConst.EQUAL_MARK  + cstRegNo;
        if (limitNum != null) {
            url += CommonConst.AND_MARK + LIMIT_URL_KEY + CommonConst.EQUAL_MARK  + limitNum;
        } else if (offset != null) {
            url += CommonConst.AND_MARK + OFFSET_URL_KEY + CommonConst.EQUAL_MARK  + offset;
        }
        request.setEndpoint(url);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Ocp-Apim-Subscription-Key', SECURITY_KEY);
        
    }
    
    /**
    * 接客履歴情報を取得
    * 
    * @return 　
    *       接客履歴情報を戻る
    * */
    public List<CommonGasReceiveHistoryResponseDto> getGasReceiveHistoryListInfo() {
        List<CommonGasReceiveHistoryResponseDto> commonGasReceiveHistoryResponseList = 
            new List<CommonGasReceiveHistoryResponseDto>();
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
            //rrorMessage = data.error.message;
            return null;
        }
        if (data.receiveHistoryResponseDtoList != null) {
            CommonGasReceiveHistoryResponseDto dto = null;
            for(GasReceiveHistoryResponseDto gasReceiveHistoryResponseDto : data.receiveHistoryResponseDtoList) {
            	dto = new CommonGasReceiveHistoryResponseDto();
                //時間帯の編集
                String jkt = '';
                //作業予定時刻/コード（デコード）がブランクの場合
                if (string.isBlank(gasReceiveHistoryResponseDto.sgy_yte_jkk_cd_dcd)) {
                    // 作業予定時間帯/コード（デコード）を表示
                    jkt = gasReceiveHistoryResponseDto.sgyoyote_jkt_cd_dcd;
                } else {
                    // 作業予定時刻/コード(デコード)を表示
                    jkt = gasReceiveHistoryResponseDto.sgy_yte_jkk_cd_dcd;
                }
                // お客さま番号
                dto.cstRegNo = gasReceiveHistoryResponseDto.cst_reg_no;
                // 接客/年月日
                dto.skkYmd = gasReceiveHistoryResponseDto.skk_ymd;
                // 接客/時刻
                String skkJkk = gasReceiveHistoryResponseDto.skk_jkk;
                dto.skkJkk = hhmmFormat(skkJkk);
                // 業務詳細区分/コード
                dto.gymSysikbnCd = gasReceiveHistoryResponseDto.gym_sysikbn_cd;
                // 業務詳細区分/コード(デコード)
                dto.gymSysikbnCdDcd = gasReceiveHistoryResponseDto.gym_sysikbn_cd_dcd;
                // 業務内容識別/コード
                dto.gymNyoSybtCd = gasReceiveHistoryResponseDto.gym_nyo_sybt_cd;
                // 業務内容識別/コード(デコード)
                dto.gymNyoSybtCdDcd = gasReceiveHistoryResponseDto.gym_nyo_sybt_cd_dcd;
                // 作業予定・実施/年月日
                dto.sgyoyoteJsYmd = mmddFormat(gasReceiveHistoryResponseDto.sgyoyote_js_ymd);
                // 作業予定時間帯/コード
                dto.sgyoyoteJktCd = gasReceiveHistoryResponseDto.sgyoyote_jkt_cd;
                // 作業予定時間帯/コード(デコード)
                dto.sgyoyoteJktCdDcd = gasReceiveHistoryResponseDto.sgyoyote_jkt_cd_dcd;
                // 作業予定時刻/コード
                dto.sgyYteJkkCd = gasReceiveHistoryResponseDto.sgy_yte_jkk_cd;
                // 作業予定時刻/コード(デコード)
                dto.sgyYteJkkCdDcd = gasReceiveHistoryResponseDto.sgy_yte_jkk_cd_dcd;
                // 作業担当箇所/漢字
                dto.sgyoTntksyKj = gasReceiveHistoryResponseDto.sgyo_tntksy_kj;
                // 接客担当者氏名/漢字
                dto.systntnamKj = gasReceiveHistoryResponseDto.systntnam_kj;
                // 特記事項/説明
                dto.tokkiJiko = gasReceiveHistoryResponseDto.tokki_jiko;
                //時間帯
        		dto.jkt = jkt;
                
               commonGasReceiveHistoryResponseList.add(dto);
            }
        }
        commonGasReceiveHistoryResponseList.sort();
        
        return commonGasReceiveHistoryResponseList;
    }

    private class ResponseData {
        private List<GasReceiveHistoryResponseDto> receiveHistoryResponseDtoList;
        private Error error;
        
        public ResponseData(List<GasReceiveHistoryResponseDto> receiveHistoryResponseDtoList, Error error) {
            this.receiveHistoryResponseDtoList = receiveHistoryResponseDtoList.clone();
            this.error = error.clone();
        }
    }
    
    private class GasReceiveHistoryResponseDto {
        // お客さま番号
        private String cst_reg_no;
        // 接客/年月日
        private String skk_ymd;
        // 接客/時刻
        private String skk_jkk;
        // 業務詳細区分/コード
        private String gym_sysikbn_cd;
        // 業務詳細区分/コード(デコード)
        private String gym_sysikbn_cd_dcd;
        // 業務内容識別/コード
        private String gym_nyo_sybt_cd;
        // 業務内容識別/コード(デコード)
        private String gym_nyo_sybt_cd_dcd;
        // 作業予定・実施/年月日
        private String sgyoyote_js_ymd;
        // 作業予定時間帯/コード
        private String sgyoyote_jkt_cd;
        // 作業予定時間帯/コード(デコード)
        private String sgyoyote_jkt_cd_dcd;
        // 作業予定時刻/コード
        private String sgy_yte_jkk_cd;
        // 作業予定時刻/コード(デコード)
        private String sgy_yte_jkk_cd_dcd;
        // 作業担当箇所/漢字
        private String sgyo_tntksy_kj;
        // 接客担当者氏名/漢字
        private String systntnam_kj;
        // 特記事項/説明
        private String tokki_jiko;
    
        public GasReceiveHistoryResponseDto(String cst_reg_no, String skk_ymd, String skk_jkk, String gym_sysikbn_cd,
                String gym_sysikbn_cd_dcd, String gym_nyo_sybt_cd, String gym_nyo_sybt_cd_dcd, String sgyoyote_js_ymd,
                String sgyoyote_jkt_cd, String sgyoyote_jkt_cd_dcd, String sgy_yte_jkk_cd, String sgy_yte_jkk_cd_dcd,
                String sgyo_tntksy_kj, String systntnam_kj, String tokki_jiko) {
            this.cst_reg_no = cst_reg_no;
            this.skk_ymd = skk_ymd;
            this.skk_jkk = skk_jkk;
            this.gym_sysikbn_cd = gym_sysikbn_cd;
            this.gym_sysikbn_cd_dcd = gym_sysikbn_cd_dcd;
            this.gym_nyo_sybt_cd = gym_nyo_sybt_cd;
            this.gym_nyo_sybt_cd_dcd = gym_nyo_sybt_cd_dcd;
            this.sgyoyote_js_ymd = sgyoyote_js_ymd;
            this.sgyoyote_jkt_cd = sgyoyote_jkt_cd;
            this.sgyoyote_jkt_cd_dcd = sgyoyote_jkt_cd_dcd;
            this.sgy_yte_jkk_cd = sgy_yte_jkk_cd;
            this.sgy_yte_jkk_cd_dcd = sgy_yte_jkk_cd_dcd;
            this.sgyo_tntksy_kj = sgyo_tntksy_kj;
            this.systntnam_kj = systntnam_kj;
            this.tokki_jiko = tokki_jiko;
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
   
    private String hhmmFormat (String hhmm) {
        String convert = '';
        if (hhmm != null && hhmm.isNumeric() && hhmm.length() == 4) {
            if ((Integer.valueOf(hhmm) > 2359 || Integer.valueOf(hhmm) < 0)) {
                convert = '';
            } else {
                convert = hhmm.substring(0,2) + ':' + hhmm.substring(2,4);
            }
        }
        return convert;
    }
    
    private String mmddFormat (String yyyymmdd) {
        String convert = '';
        if (yyyymmdd != null && Pattern.matches('[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]', yyyymmdd)) {
            convert = yyyymmdd.substring(5);
        }
        return convert;
    }
    
}