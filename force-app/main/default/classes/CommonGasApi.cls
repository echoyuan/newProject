public class CommonGasApi {
    
   
    public CommonGasApi() {
        
    }
    
     /**
     * ガス関連番号を取得
     * 
     * @params cstNo 
     * @return 　
     *       ガス関連番号を戻る
     * */
    public CommonGasResponseDto getGasnoRelationInfo(String cstNo) {
        CommonGasRelationNoResponseDto gasnoRelationInfo = null;
        try {
            CommonGasRelationNoApi apiRequest = new CommonGasRelationNoApi();
            String httpMethod = 'GET';
            String endPoint = 'https://tgcrm-acp-api.azure-api.net/test/yuan-test/GasnoRelation';
            String securityKey = '219f7e405cbc4adf949c066b8dca5b00';
            //URI:https://internal-apis.tg-group.tokyo-gas.co.jp/gas-cis/v1/gasno-relation?cst_no=12345678901
            system.debug('apiRequest'+apiRequest);
            apiRequest.setRequestInfo(endPoint, securityKey);
            apiRequest.send();
            if (apiRequest.getGasRelationNoInfo() == null) {
                return new CommonGasResponseDto(40, 'ガス関連番号取得失敗', null, null);
            }
            gasnoRelationInfo = apiRequest.getGasRelationNoInfo();
            system.debug('gasnoRelationInf=' + gasnoRelationInfo);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new CommonGasResponseDto(100, 'システムエラー', null, null);
        }
        return new CommonGasResponseDto(0, null, null, gasnoRelationInfo);
    }
    
    /**
     * メータ情報を取得
     * 
     * @params gmtSetNo ガスメータ設置場所ID
     * @params syokyNo ガス契約ID
     * @params limitNum 取得レコード件数
     * @params offset 取得レコード開始位置
     * @return 　
     *       メータ情報
     * */
    public CommonGasResponseDto getGasMeterListInfo(String gmtSetNo, String syokyNo, Integer limitNum, Integer offset) {
        List<CommonGasMeterResponseDto> gasMeterList = null;
        try {
            CommonGasMeterApi apiRequest = new CommonGasMeterApi();
            String httpMethod = 'GET';
            String endPoint = 'https://tg.azure-api.net/test/yuan-test/testMeterContract';
            String securityKey = '989092bfe04943eeaa3885338fc24033';
            //URI:https://internal-apis.tg-group.tokyo-gas.co.jp/gas-cis/v1/meter-states?gmt_set_no=12345678901&limit=50&offset=0
            //URI:https://internal-apis.tg-group.tokyo-gas.co.jp/gas-cis/v1/meter-states?syoky_no=45678901234&limit=50&offset=0
            //TODO ガスメータ設置場所ID、ガス契約IDの判定
            apiRequest.setRequestInfo(endPoint, securityKey);
            apiRequest.send();
            if (apiRequest.getGasMeterListInfo() == null) {
                return new CommonGasResponseDto(40, 'メータ情報取得失敗', null, null);
            }
            gasMeterList = apiRequest.getGasMeterListInfo();
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new CommonGasResponseDto(100, 'システムエラー', null, null);
        }
        return new CommonGasResponseDto(0, null, gasMeterList, null);
        
    }
    
    /**
     * ガス契約情報を取得
     * 
     * @params syokyNo ガス契約ID
     * @params limitNum 取得レコード件数
     * @params offset 取得レコード開始位置
     * @return 　
     *       ガス契約情報
     * */
    public CommonGasResponseDto getGasContractListInfo(String syokyNo, Integer limitNum, Integer offset) {
        List<CommonGasContractResponseDto> gasContractList = null;
        try {
            CommonGasContractApi apiRequest = new CommonGasContractApi();
            String httpMethod = 'GET';
            String endPoint = 'https://tg.azure-api.net/test/yuan-test/testGasContract';
            String securityKey = '989092bfe04943eeaa3885338fc24033';
            //URI:https://internal-apis.tg-group.tokyo-gas.co.jp/gas-cis/v1/contracts?syoky_no=45678901234&limit=50&offset=0
            
            apiRequest.setRequestInfo(endPoint, securityKey);
            apiRequest.send();
            if (apiRequest.getGasContractListInfo() == null) {
                return new CommonGasResponseDto(40, 'ガス契約情報取得失敗', null, null);
            }
            gasContractList = apiRequest.getGasContractListInfo();
            system.debug('gasContractList=' + gasContractList);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new CommonGasResponseDto(100, 'システムエラー', null, null);
        }
        return new CommonGasResponseDto(0, null, gasContractList, null); 
    }
    
    /**
     * 接客履歴情報を取得
     * 
     * @params cst_reg_no お客さまID
     * @params limitNum 取得レコード件数
     * @params offset 取得レコード開始位置
     * @return 　
     *       接客履歴情報
     * */
    public CommonGasResponseDto getCustomerHistoryListInfo(String cstRegNo, Integer limitNum, Integer offset) {
        List<CommonReceiveHistoryResponseDto> customerHistoryList = null;
        try {
            CommonReceiveHistoryApi apiRequest = new CommonReceiveHistoryApi();
            String httpMethod = 'GET';
            String endPoint = 'https://tg.azure-api.net/test/yuan-test/testCustomerHistory';
            String securityKey = '989092bfe04943eeaa3885338fc24033';
            //URI:https://internal-apis.tg-group.tokyo-gas.co.jp/gas-cis/v1/contracts?syoky_no=45678901234&limit=50&offset=0
            
            apiRequest.setRequestInfo(endPoint, securityKey);
            apiRequest.send();
            if (apiRequest.getReceiveHistoryListInfo() == null) {
                return new CommonGasResponseDto(40, '接客履歴情報取得失敗', null, null);
            }
            customerHistoryList = apiRequest.getReceiveHistoryListInfo();
            system.debug('customerHistoryList=' + customerHistoryList);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new CommonGasResponseDto(100, 'システムエラー', null, null);
        }
        return new CommonGasResponseDto(0, null, customerHistoryList, null); 
    }
    
    /**
     * お客さま情報を取得
     * 
     * @params cst_reg_no お客さまID
     * @return 　
     *       お客さま情報
     * */
    public CommonGasResponseDto getCustomerInfo(String cstRegNo) {
        CommonAccountResponseDto accountInfo = null;
        try {
            CommonAccountApi apiRequest = new CommonAccountApi();
            String httpMethod = 'GET';
            String endPoint = 'https://tg.azure-api.net/test/yuan-test/testCustomerInfo';
            String securityKey = '989092bfe04943eeaa3885338fc24033';
            //https://internal-apis.tg-group.tokyo-gas.co.jp/gas-cis/v1/customers?cst_reg_no=1234567890
            
            apiRequest.setRequestInfo(endPoint, securityKey);
            apiRequest.send();
            if (apiRequest.getAccountInfo() == null) {
                return new CommonGasResponseDto(40, 'お客さま情報取得失敗', null, null);
            }
            accountInfo = apiRequest.getAccountInfo();
            system.debug('accountInfo=' + accountInfo);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new CommonGasResponseDto(100, 'システムエラー', null, null);
        }
        return new CommonGasResponseDto(0, null, null, accountInfo); 
    }
    
    /**
     * 支払情報を取得
     * 
     * @params shrkyNo 支払契約ID
     * @params limitNum 取得レコード件数
     * @params offset 取得レコード開始位置
     * @return 　
     *       支払情報
     * */
    public CommonGasResponseDto getPaymentListInfo(String shrkyNo, Integer limitNum, Integer offset) {
        List<CommonPaymentResponseDto> paymentList = null;
        try {
            CommonPaymentApi apiRequest = new CommonPaymentApi();

            String endPoint = 'https://tg.azure-api.net/test/yuan-test/testPaymentList';
            String securityKey = '989092bfe04943eeaa3885338fc24033';
            //https://internal-apis.tg-group.tokyo-gas.co.jp/gas-cis/v1/payments?shrky_no=23456789012&limit=50&offset=0
            
            apiRequest.setRequestInfo(endPoint, securityKey);
            apiRequest.send();
            if (apiRequest.getPaymentListInfo() == null) {
                return new CommonGasResponseDto(40, '支払情報取得失敗', null, null);
            }
            paymentList = apiRequest.getPaymentListInfo();
            system.debug('customerInfo=' + paymentList);
      
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new CommonGasResponseDto(100, 'システムエラー', null, null);
        }
        return new CommonGasResponseDto(0, null, paymentList, null); 
    }
    
    /**
     * 電気料金合算パターン情報を取得
     * 
     * @params syokyNo 使用契約番号
     * @return 　
     *       電気料金合算パターン情報
     * */
    public CommonGasResponseDto getElectricAddPatternInfo(String shrkyNo) {
        CommonElectricAddPatternResponseDto electricAddPatternInfo = null;
        try {
            CommonElectricAddPatternApi apiRequest = new CommonElectricAddPatternApi();
            String httpMethod = 'GET';
            String endPoint = 'https://tg.azure-api.net/test/yuan-test/ElectricAddPattern';
            String securityKey = '989092bfe04943eeaa3885338fc24033';
            //https://internal-apis.tg-group.tokyo-gas.co.jp/gas-cis/v1/electric-add-pattern?syoky_no=40199998001
            
            apiRequest.setRequestInfo(endPoint, securityKey);
            apiRequest.send();
            if (apiRequest.getElectricAddPatternInfo() == null) {
                return new CommonGasResponseDto(40, '電気料金合算パターン情報取得失敗', null, null);
            }
            electricAddPatternInfo = apiRequest.getElectricAddPatternInfo();
            system.debug('electricAddPatternInfo=' + electricAddPatternInfo);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new CommonGasResponseDto(100, 'システムエラー', null, null);
        }
        return new CommonGasResponseDto(0, null, null, electricAddPatternInfo); 
    }
    
    /**
     * ガスメータ設置場所情報を取得
     * 
     * @params gmtSetNo ガスメータ設置場所ID
     * @params shokyNo ガス契約ID
     * @params limitNum 取得レコード件数
     * @params offset 取得レコード開始位置
     * @return 　
     *       ガスメータ設置場所情報
     * */
    public CommonGasResponseDto getGasMeterPlaceListInfo(String gmtSetNo, String shokyNo, Integer limitNum, Integer offset) {
        List<CommonGasMeterPlaceResponseDto> gasMeterPlaceList = null;
        try {
            CommonGasMeterPlaceApi apiRequest = new CommonGasMeterPlaceApi();
            String httpMethod = 'GET';
            String endPoint = 'https://tg.azure-api.net/test//yuan-test/GasMeterPlace';
            String securityKey = '989092bfe04943eeaa3885338fc24033';
            //https://internal-apis.tg-group.tokyo-gas.co.jp/gas-cis/v1/meter-places?gmt_set_no=12345678901&limit=50&offset=0
            //https://internal-apis.tg-group.tokyo-gas.co.jp/gas-cis/v1/meter-places?syoky_no=45678901234&limit=50&offset=0
            
            apiRequest.setRequestInfo(endPoint, securityKey);
            apiRequest.send();
            if (apiRequest.getGasMeterPlaceListInfo() == null) {
                return new CommonGasResponseDto(40, 'ガスメータ設置場所情報取得失敗', null, null);
            }
            gasMeterPlaceList = apiRequest.getGasMeterPlaceListInfo();
            system.debug('gasMeterPlaceList=' + gasMeterPlaceList);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new CommonGasResponseDto(100, 'システムエラー', null, null);
        }
        return new CommonGasResponseDto(0, null, gasMeterPlaceList, null); 
    }
    
    
    
   
}