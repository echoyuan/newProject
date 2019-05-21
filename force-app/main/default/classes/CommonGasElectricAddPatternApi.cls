public class CommonGasElectricAddPatternApi {
    /** リクエスト */
    private HttpRequest request;
    /** レスポンス */
    private HttpResponse response;
    /** ドメインURL */
    private static final String DOMAIN_URL = 'https://tgcrm-acp-api.azure-api.net/test/';
    /** SubApiパス */
    private static final String CONTRACT_SUB_URL = 'electric-add-pattern';
    /** セキュリティキー */
    private static final String SECURITY_KEY = '219f7e405cbc4adf949c066b8dca5b00';
    /** URL */
    private static final String SYOKY_NO_URL_KEY = 'syoky_no';
    
    public HttpRequest getRequest() {
        return request;
    }
    public CommonGasElectricAddPatternApi(String syokyNo) {
        request = new HttpRequest();
        // リクエスト情報（ヘッダ等）の設定
        setRequestInfo(syokyNo);
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
    * @param syokyNo　
    *       使用契約番号
    * */
    public void setRequestInfo(String syokyNo) {
        request.setHeader('Content-Length', '0');     
        request.setMethod(ConstantsUtil.GET);
        String url = DOMAIN_URL + CONTRACT_SUB_URL + ConstantsUtil.QUERY_MARK + SYOKY_NO_URL_KEY + ConstantsUtil.EQUAL_MARK  + syokyNo;
        request.setEndpoint(url);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Ocp-Apim-Subscription-Key', SECURITY_KEY);
        
    }
    
    /**
    * 電気料金合算パターン情報を取得
    * 
    * @return 　
    *       電気料金合算パターン情報を戻る
    * */
    public CommonGasElectricAddPatternResponseDto getGasElectricAddPatternInfo() {
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
        // 画面項目「電力合算」の表示文字
        String dgsnptn = '';
        // 他システム使用契約特定結果
        String tasyskyExist = data.tasysky_exist;
        // 電気料金合算パターン/コード
        String dgsnptnExist = data.dgsnptn_exist;
        
        // 他システム使用契約特定結果＝「未特定」
        if (ConstantsUtil.TASYSKY_EXIST_MITOKUTEYI.equals(tasyskyExist)) {
            // 「電力合算」の表示文字:電力契約なし
            dgsnptn = ConstantsUtil.DGSNPTN_TEXT;
            // 他システム使用契約特定結果＝「特定済」  
        } else if (ConstantsUtil.TASYSKY_EXIST_TOKUTEYIZUMI.equals(tasyskyExist)) {
            // 電気料金合算パターン/コード＝「未取得」
            if (ConstantsUtil.DGSNPTN_EXIST_MISYUTOKU.equals(dgsnptnExist)) {
                dgsnptn = ConstantsUtil.DGSNPTN_TEXT;
                // 電気料金合算パターン/コード＝電気料金合算パターンコード
            } else {
                dgsnptn = data.electric_add_pattern;
            }
        }
        
        CommonGasElectricAddPatternResponseDto dto = new CommonGasElectricAddPatternResponseDto(
            data.syoky_no,
            data.tasysky_exist,
            data.dgsnptn_exist,
            data.electric_add_pattern,
            dgsnptn
        );
        return dto;
    }
    
    private class ResponseData {
        // お客さま番号
        private String syoky_no;
        // 他システム使用契約特定結果
        private String tasysky_exist;
        // 電気料金合算パターン/コード
        private String dgsnptn_exist;
        // 電気料金合算パターン/コード（デコード）
        private String electric_add_pattern;
        // 電力合算
        private String electric_add;
        // エラー
        private Error error;

        public ResponseData(String syoky_no, String tasysky_exist, String dgsnptn_exist,
                String electric_add_pattern, String electric_add, Error error) {
            this.syoky_no = syoky_no;
            this.tasysky_exist = tasysky_exist;
            this.dgsnptn_exist = dgsnptn_exist;
            this.electric_add_pattern = electric_add_pattern;
            this.electric_add = electric_add;
            this.error = error;
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