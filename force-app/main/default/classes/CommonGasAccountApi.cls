public class CommonGasAccountApi {
    /** リクエスト */
    private HttpRequest request;
    /** レスポンス */
    private HttpResponse response;
    /** ドメインURL */
    private static final String DOMAIN_URL = 'https://tgcrm-acp-api.azure-api.net/test/';
    /** SubApiパス */
    private static final String CONTRACT_SUB_URL = 'customer';
    /** セキュリティキー */
    private static final String SECURITY_KEY = '219f7e405cbc4adf949c066b8dca5b00';
    /** お客さまID */
    private static final String CST_REG_NO = 'cst_reg_no';
    // お客さま電話/番号
    private String cstTelNo = '';
    // 電話種別/コード(デコード)
    private String telSybCdDcd = '';
    // 電話連絡先種別/コード(デコード)
    private String telRrksSybCdDcd = '';
    
    /**
     * コンストラクタ
     * @param cstRegNo　
     *       お客さまID
     * */
    public CommonGasAccountApi(String cstRegNo) {
        request = new HttpRequest();
        // リクエスト情報（ヘッダ等）の設定
        setRequestInfo(cstRegNo);
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
    * お客さま情報を取得
    * 
    * @return お客さま情報を取得を戻る
   	* */
    public CommonGasAccountResponseDto getAccountInfo() {
        String errorMessage = '';
        CommonGasAccountResponseDto commonGasAccountResponseDto = new CommonGasAccountResponseDto();
        // レスポンスボディーからデータを取得する
        JSONParser parser = JSON.createParser(response.getBody());
        ResponseData data = (ResponseData) parser.readValueAs(ResponseData.class);
        
        if (data == null) {
            errorMessage = 'レスポンスフォーマット例外';
            commonGasAccountResponseDto.code = 100;
            commonGasAccountResponseDto.message = errorMessage;
            commonGasAccountResponseDto.result = '';
        } else {
            // レスポンス戻る値が異常の場合
        	//if (gasAccountResponseDto.code != 200) {
                // エラーメッセージを設定する
                //gasAccountResponseDto.code = data.code;
                //gasAccountResponseDto.message = data.message;
                //gasAccountResponseDto.result = data.result; 
            //} else {
                // お客さま電話/番号、電話種別/コード(デコード)、電話連絡先種別/コード(デコード)の設定
        		setTelNoStr(data.telno_list);
                commonGasAccountResponseDto.cstRegNo = data.cst_reg_no;
                commonGasAccountResponseDto.tenNamYagoKj = data.ten_nam_yago_kj;
                commonGasAccountResponseDto.tenNamYagoKn = data.ten_nam_yago_kn;
                commonGasAccountResponseDto.namKj = data.nam_kj;
                commonGasAccountResponseDto.namKn = data.nam_kn;
                commonGasAccountResponseDto.jusyo = data.jusyo;
                commonGasAccountResponseDto.yubinNo = data.yubin_no;
                commonGasAccountResponseDto.cstTelNo = cstTelNo;
                commonGasAccountResponseDto.telSybCdDcd = telSybCdDcd;
                commonGasAccountResponseDto.telRrksSybCdDcd = telRrksSybCdDcd;
           // }
        }
        return commonGasAccountResponseDto;
    }
    
    /**
     * リクエストの設定
     * @param cstRegNo　
     *       お客さまID
     * */
    public void setRequestInfo(String cstRegNo) {
		request.setHeader('Content-Length', '0');     
        request.setMethod(ConstantsUtil.GET);
        request.setEndpoint(
            DOMAIN_URL
            + CONTRACT_SUB_URL
            + ConstantsUtil.QUERY_MARK 
            + CST_REG_NO 
            + ConstantsUtil.EQUAL_MARK 
            + cstRegNo);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Ocp-Apim-Subscription-Key', SECURITY_KEY);
    }
    
    /**
     * お客さま電話/番号、電話種別/コード(デコード)、電話連絡先種別/コード(デコード)の設定
     * @param telno_list　
     *       電話番号リスト
     * */
    private void setTelNoStr(List<TelNoList> telno_list) {
        if (telno_list != null && !telno_list.isEmpty()){
            // お客さま電話/番号
            for (TelNoList data : telno_list) {
                List<String> telNoList = new List<String>();
                // お客さま電話/番号
                if (String.isNotBlank(data.cst_tel_no)) {
                    telNoList.add(data.cst_tel_no);
                }
                // 電話種別/コード
                if (String.isNotBlank(data.tel_syb_cd)) {
                    telNoList.add(data.tel_syb_cd);
                }
                // 電話種別/コード(デコード)
                if (String.isNotBlank(data.tel_syb_cd_dcd)) {
                    telNoList.add(data.tel_syb_cd_dcd);
                }
                // 電話連絡先種別/コード
                if (String.isNotBlank(data.tel_rrks_syb_cd)) {
                    telNoList.add(data.tel_rrks_syb_cd);
                }
                // 電話連絡先種別/コード(デコード)
                if (String.isNotBlank(data.tel_rrks_syb_cd_dcd)) {
                    telNoList.add(data.tel_rrks_syb_cd_dcd);
                }
                // 確認済/コード
                if (String.isNotBlank(data.kkn_zm_cd)) {
                    telNoList.add(data.kkn_zm_cd);
                }
                // 確認済/コード(デコード)
                if (String.isNotBlank(data.kkn_zm_cd_dcd)) {
                    telNoList.add(data.kkn_zm_cd_dcd);
                }
                
                // お客さま電話/番号
                if (!''.equals(cstTelNo)) {
                    cstTelNo += ConstantsUtil.NEW_LINE_CODE + String.join(telNoList, ConstantsUtil.HALF_SPACE);
                } else {
                    cstTelNo += String.join(telNoList, ConstantsUtil.HALF_SPACE);
                }
                
                // 電話種別/コード(デコード)
                if (!''.equals(telSybCdDcd)) {
                    telSybCdDcd += ConstantsUtil.NEW_LINE_CODE + data.tel_syb_cd_dcd;
                } else {
                    telSybCdDcd += data.tel_syb_cd_dcd;
                }
                // 電話連絡先種別/コード(デコード)
                if (!''.equals(telRrksSybCdDcd)) {
                    telRrksSybCdDcd += ConstantsUtil.NEW_LINE_CODE + data.tel_rrks_syb_cd_dcd;
                } else {
                    telRrksSybCdDcd += data.tel_rrks_syb_cd_dcd;
                }
            }
        }
    }
    private class ResponseData {
        // お客さま登録/番号
        private String cst_reg_no;
        // 店名・屋号
        private String ten_nam_yago_kj;
        // 店名・屋号/カナ
        private String ten_nam_yago_kn;
        // おなまえ
        private String nam_kj;
        // おなまえ/カナ
        private String nam_kn;
        // 住所
        private String jusyo;
        // 郵便/番号
        private String yubin_no;
        // 電話番号リスト
        private List<TelNoList> telno_list;
        
        private Error error;
        // コード
        //private Integer code;
        // 結果
        //private String result;
        // メッセージ
        //private String message;
    
        public ResponseData(String cst_reg_no, String ten_nam_yago_kj, String ten_nam_yago_kn, String nam_kj,
                String nam_kn, String jusyo, String yubin_no, List<TelNoList> telno_list, //Integer code, String result,
                //String message, 
                Error error) {
            
            this.cst_reg_no = cst_reg_no;
            this.ten_nam_yago_kj = ten_nam_yago_kj;
            this.ten_nam_yago_kn = ten_nam_yago_kn;
            this.nam_kj = nam_kj;
            this.nam_kn = nam_kn;
            this.jusyo = jusyo;
            this.yubin_no = yubin_no;
            this.telno_list = telno_list;
            //this.code = code;
            //this.result = result;
            //this.message = message;
            this.error = error.clone();
        }

	}
    
    private class TelNoList {
        // お客さま電話/番号
        private String cst_tel_no;
        // 電話種別/コード
        private String tel_syb_cd;
        // 電話種別/コード(デコード)
        private String tel_syb_cd_dcd;
        // 電話連絡先種別/コード
        private String tel_rrks_syb_cd;
        // 電話連絡先種別/コード(デコード)
        private String tel_rrks_syb_cd_dcd;
        // 確認済/コード
        private String kkn_zm_cd;
        // 確認済/コード(デコード)
        private String kkn_zm_cd_dcd;
        private TelNoList(String cst_tel_no
                          , String tel_syb_cd
                          , String tel_syb_cd_dcd
                          , String tel_rrks_syb_cd
                          , String tel_rrks_syb_cd_dcd
                          , String kkn_zm_cd
                          , String kkn_zm_cd_dcd) {
            cst_tel_no = cst_tel_no;
            tel_syb_cd = tel_syb_cd;
            tel_syb_cd_dcd = tel_syb_cd_dcd;
            tel_rrks_syb_cd = tel_rrks_syb_cd;
            tel_rrks_syb_cd_dcd = tel_rrks_syb_cd_dcd;
            kkn_zm_cd = kkn_zm_cd;
            kkn_zm_cd_dcd = kkn_zm_cd_dcd;
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