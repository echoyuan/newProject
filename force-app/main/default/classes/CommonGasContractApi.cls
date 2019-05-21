public class CommonGasContractApi {
	/** リクエスト */
    private HttpRequest request;
    /** レスポンス */
    private HttpResponse response;
    /** ドメインURL */
    private static final String DOMAIN_URL = 'https://tgcrm-acp-api.azure-api.net/test/';
    /** SubApiパス */
    private static final String CONTRACT_SUB_URL = 'contracts';
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
       
    public CommonGasContractApi(String shrkyNo, Integer limitNum, Integer offset) {
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
    
    /**
    * 契約詳細情報の取得
    * 
    * @return 　
    *       契約詳細情報を戻る
    * */
    public List<CommonGasContractResponseDto> getGasContractListInfo() {
        //契約詳細情報リスト
        List<CommonGasContractResponseDto> commonGasContractResponseDtoList = new List<CommonGasContractResponseDto>();
        
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
         
        if (data.gasContractResponseDtoList != null) {
            for(GasContractResponseDto gasContractResponseDto: data.gasContractResponseDtoList) {
                CommonGasContractResponseDto dto = new CommonGasContractResponseDto();
                // ガス料金契約種別の編集
                String gasKySyb = '';
                // ガス料金契約種別/コード="101"かつ福祉/コード≠"0" かつ福祉/コード≠ブランクの場合
                if (ConstantsUtil.GAS_KY_SYB_CD_101.equals(gasContractResponseDto.gas_ky_syb_cd)
                    && String.isNotBlank(gasContractResponseDto.fukusi_cd)
                    && !ConstantsUtil.FUKUSI_CD_0.equals(gasContractResponseDto.fukusi_cd)) {
                        // 福祉/コード（デコード）を表示
                        gasKySyb = gasContractResponseDto.fukusi_cd_dcd;
                    } else {
                        // ガス料金契約種別/コード(デコード)を表示
                        gasKySyb = gasContractResponseDto.gas_ky_syb_cd_dcd;
                    }
                gasContractResponseDto.gas_ky_syb = gasKySyb;
                
                // お客さま番号
                dto.syokyNo = gasContractResponseDto.syoky_no;
                // 内容有効開始/年月日
                dto.effctYmd = gasContractResponseDto.effct_ymd;
                // 内容有効期限/年月日
                dto.limitYmd = gasContractResponseDto.limit_ymd;
                // ガス料金契約種別/コード
                dto.gasKySybCd = gasContractResponseDto.gas_ky_syb_cd;
                // ガス料金契約種別/コード(デコード)
                dto.gasKySybCdDcd = gasContractResponseDto.gas_ky_syb_cd_dcd;
                // 福祉/コード
                dto.fukusiCd = gasContractResponseDto.fukusi_cd;
                // 福祉/コード(デコード)
                dto.fukusiCdDcd = gasContractResponseDto.fukusi_cd_dcd;
                // ガス料金金額指定報告/コード
                dto.gasRknKgshCd = gasContractResponseDto.gas_rkn_kgsh_cd;
                // ガス料金金額指定報告/コード(デコード)
                dto.gasRknKgshCdDcd = gasContractResponseDto.gas_rkn_kgsh_cd_dcd;
                // 総合扱いガスメータ/数
                dto.sogoAtkGmtSu = gasContractResponseDto.sogo_atk_gmt_su;
                // 臨時精算事由/コード
                dto.rnjSesnJiyCd = gasContractResponseDto.rnj_sesn_jiy_cd;
                // 臨時精算事由/コード(デコード)
                dto.rnjSesnJiyCdDcd = gasContractResponseDto.rnj_sesn_jiy_cd_dcd;
                // 使用者/お客さま登録/番号
                dto.userCstRegNo = gasContractResponseDto.user_cst_reg_no;
                // 支払契約/番号
                dto.shrkyNo = gasContractResponseDto.shrky_no;
                // ガス料金契約種別
                dto.gasKySyb = gasContractResponseDto.gas_ky_syb;
                
                commonGasContractResponseDtoList.add(dto);
            }  
        }
        return commonGasContractResponseDtoList;
    }

    private class ResponseData {
        private List<GasContractResponseDto> gasContractResponseDtoList;
        private Error error;
        
        private ResponseData(List<GasContractResponseDto> gasContractResponseDtoList, Error error) {
            gasContractResponseDtoList = gasContractResponseDtoList.clone();
            error = error.clone();
        }
    }
    
    private class GasContractResponseDto {
        // お客さま番号
        private String syoky_no;
        // 内容有効開始/年月日
        private String effct_ymd;
        // 内容有効期限/年月日
        private String limit_ymd;
        // ガス料金契約種別/コード
        private String gas_ky_syb_cd;
        // ガス料金契約種別/コード(デコード)
        private String gas_ky_syb_cd_dcd;
        // 福祉/コード
        private String fukusi_cd;
        // 福祉/コード(デコード)
        private String fukusi_cd_dcd;
        // ガス料金金額指定報告/コード
        private String gas_rkn_kgsh_cd;
        // ガス料金金額指定報告/コード(デコード)
        private String gas_rkn_kgsh_cd_dcd;
        // 総合扱いガスメータ/数
        private String sogo_atk_gmt_su;
        // 臨時精算事由/コード
        private String rnj_sesn_jiy_cd;
        // 臨時精算事由/コード(デコード)
        private String rnj_sesn_jiy_cd_dcd;
        // 使用者/お客さま登録/番号
        private String user_cst_reg_no;
        // 支払契約/番号
        private String shrky_no;
        // ガス料金契約種別
        private String gas_ky_syb;
        
        public GasContractResponseDto(String syoky_no, String effct_ymd, String limit_ymd, String gas_ky_syb_cd,
                String gas_ky_syb_cd_dcd, String fukusi_cd, String fukusi_cd_dcd, String gas_rkn_kgsh_cd,
                String gas_rkn_kgsh_cd_dcd, String sogo_atk_gmt_su, String rnj_sesn_jiy_cd, String rnj_sesn_jiy_cd_dcd,
                String user_cst_reg_no, String shrky_no, String gas_ky_syb) {
            
            this.syoky_no = syoky_no;
            this.effct_ymd = effct_ymd;
            this.limit_ymd = limit_ymd;
            this.gas_ky_syb_cd = gas_ky_syb_cd;
            this.gas_ky_syb_cd_dcd = gas_ky_syb_cd_dcd;
            this.fukusi_cd = fukusi_cd;
            this.fukusi_cd_dcd = fukusi_cd_dcd;
            this.gas_rkn_kgsh_cd = gas_rkn_kgsh_cd;
            this.gas_rkn_kgsh_cd_dcd = gas_rkn_kgsh_cd_dcd;
            this.sogo_atk_gmt_su = sogo_atk_gmt_su;
            this.rnj_sesn_jiy_cd = rnj_sesn_jiy_cd;
            this.rnj_sesn_jiy_cd_dcd = rnj_sesn_jiy_cd_dcd;
            this.user_cst_reg_no = user_cst_reg_no;
            this.shrky_no = shrky_no;
            this.gas_ky_syb = gas_ky_syb;
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