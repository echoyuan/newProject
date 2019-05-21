public class CommonGasMeterApi {
    /** リクエスト */
    private HttpRequest request;
    /** レスポンス */
    private HttpResponse response;
    /** ドメインURL */
    private static final String DOMAIN_URL = 'https://tgcrm-acp-api.azure-api.net/test/';
    /** SubApiパス */
    private static final String CONTRACT_SUB_URL = 'meter-states';
    /** セキュリティキー */
    private static final String SECURITY_KEY = '219f7e405cbc4adf949c066b8dca5b00';
    /** URL */
    private static final String GMT_SET_NO_URL_KEY = 'gmt_set_no';
    /** URL */
    private static final String SYOKY_NO_URL_KEY = 'syoky_no';

    /** URL */
    private static final String LIMIT_URL_KEY = 'limit';
    /** URL */
    private static final String OFFSET_URL_KEY = 'offset';
    
    public HttpRequest getRequest() {
        return request;
    }
    public CommonGasMeterApi(String gmtSetNo, String syokyNo, Integer limitNum, Integer offset) {
        request = new HttpRequest();
        // リクエスト情報（ヘッダ等）の設定
        setRequestInfo(gmtSetNo, syokyNo, limitNum, offset);
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
     * @param gmtSetNo　
     *       ガスメータ設置場所番号
     * @param shrkyNo　
     *       支払契約ID
     * @param limitNum　
     *       取得レコード件数
     * @param offset　
     *       取得レコード開始位置
     * */
    public void setRequestInfo(String gmtSetNo, String syokyNo, Integer limitNum, Integer offset) {
        request.setHeader('Content-Length', '0');     
        request.setMethod(ConstantsUtil.GET);
        String url = DOMAIN_URL + CONTRACT_SUB_URL + ConstantsUtil.QUERY_MARK;
        if (gmtSetNo != null) {
             url += GMT_SET_NO_URL_KEY + ConstantsUtil.EQUAL_MARK  + gmtSetNo;
        } else {
             url += SYOKY_NO_URL_KEY + ConstantsUtil.EQUAL_MARK  + syokyNo;
        }
        if (limitNum != null) {
            url += ConstantsUtil.AND_MARK + LIMIT_URL_KEY + ConstantsUtil.EQUAL_MARK  + limitNum;
        }
        if (offset != null) {
            url += ConstantsUtil.AND_MARK + OFFSET_URL_KEY + ConstantsUtil.EQUAL_MARK  + offset;
        }
        request.setEndpoint(url);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Ocp-Apim-Subscription-Key', SECURITY_KEY);
        
    }
    
    /**
     * メータ状態を取得
     * 
     * @return 　
     *       メータ状態を戻る
     * */
    public List<CommonGasMeterResponseDto> getGasMeterListInfo() {
        List<CommonGasMeterResponseDto> commonGasMeterResponseDto = new List<CommonGasMeterResponseDto>();
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
        if (data.gasMeterResponseDtoList != null) {
            for(GasMeterResponseDto gasMeterResponseDto: data.gasMeterResponseDtoList) {
                CommonGasMeterResponseDto dto = new CommonGasMeterResponseDto(
                    gasMeterResponseDto.gmt_set_no,
                    gasMeterResponseDto.gas_syoky_no,
                    gasMeterResponseDto.gmt_states,
                    gasMeterResponseDto.gmt_ymd_title,
                    gasMeterResponseDto.gmt_ymd,
                    gasMeterResponseDto.gmt_states_jiy   
                );
                commonGasMeterResponseDto.add(dto);
            }
    	}
        commonGasMeterResponseDto.sort();
        return commonGasMeterResponseDto;
    }
    
    private class ResponseData {
        private List<GasMeterResponseDto> gasMeterResponseDtoList;
        private Error error;

        public ResponseData(List<GasMeterResponseDto> gasMeterResponseDtoList, Error error) {
            this.gasMeterResponseDtoList = gasMeterResponseDtoList.clone();
            this.error = error.clone();
        }
    }

    private class GasMeterResponseDto {
        // お客さま番号（1x）
        private String gmt_set_no;
        // ガス/使用契約/番号（4x）
        private String gas_syoky_no;
        // メータ状態
        private String gmt_states;
        // メータ作業日タイトル
        private String gmt_ymd_title;
        // メータ作業日
        private String gmt_ymd;
        // メータ状態事由
        private String gmt_states_jiy;
    
        public GasMeterResponseDto(String gmt_set_no, String gas_syoky_no, String gmt_states, String gmt_ymd_title,
                String gmt_ymd, String gmt_states_jiy) {
            this.gmt_set_no = gmt_set_no;
            this.gas_syoky_no = gas_syoky_no;
            this.gmt_states = gmt_states;
            this.gmt_ymd_title = gmt_ymd_title;
            this.gmt_ymd = gmt_ymd;
            this.gmt_states_jiy = gmt_states_jiy;
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