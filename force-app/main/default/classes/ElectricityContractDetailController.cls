/**
 * 契約詳細画面(電力契約)用コントローラ
 */
public with sharing class ElectricityContractDetailController {

    /**
    * 契約お客さま情報取得
    * 
    * @param serviceKey
    *       電力契約番号(SA)
    * @return 
    *       契約お客さま情報を返却する
    * */
    @AuraEnabled
    public static CommonResponseDto getElectricityAccountInfo(String serviceKey) {
        //契約お客さま情報API
        CommonElectricityAccountApi electricityAccountApi = new CommonElectricityAccountApi(serviceKey);
        try {
            electricityAccountApi.send();
            CommonElectricityAccountResponseDto electricityAccountResponseDto = electricityAccountApi.getElectricityAccountInfo();
            return new commonResponseDto(0, null, electricityAccountResponseDto); 
        } catch (ApiCallOutErrorException e) {
            return new CommonResponseDto(40, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.ELECTRICITY_ACCOUNT_API, null);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
            //return new CommonResponseDto(100, 'システムエラー', null);
        }        
    }
    
    /**
    * 契約情報取得
    * 
    * @param serviceKey
    *       電力契約番号(SA)
    * @return 
    *       契約情報を返却する
    * */
    @AuraEnabled
    public static CommonResponseDto getElectricityContractInfo(String serviceKey) {
        //契約情報API
        CommonElectricityContractApi electricityContractApi = new CommonElectricityContractApi(serviceKey);
        try {
            electricityContractApi.send();
            CommonElectricityContractResponseDto electricityContractResponseDto = electricityContractApi.getElectricityContractInfo();
            return new commonResponseDto(0, null, electricityContractResponseDto); 
        } catch (ApiCallOutErrorException e) {
            return new CommonResponseDto(40, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.ELECTRICITY_CONTRACT_API, null);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
            //return new CommonResponseDto(100, 'システムエラー', null);
        }        
    }
    
    /**
    * ガス関連番号取得
    * 
    * @param xGas4X
    *       ガス使用契約番号(4x)
    * @return 
    *       ガス関連番号を返却する
    * */
    @AuraEnabled
    public static CommonResponseDto getGasRelationNoInfo(String xGas4X) {
        //ガス関連番号API
        CommonGasRelationNoApi gasRelationNoApi = new CommonGasRelationNoApi(xGas4X);
        try {
            gasRelationNoApi.send();
            CommonGasRelationNoResponseDto gasRelationNoResponseDto = gasRelationNoApi.getGasRelationNoInfo();
            return new commonResponseDto(0, null, gasRelationNoResponseDto); 
        } catch (ApiCallOutErrorException e) {
            return new CommonResponseDto(40, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.GAS_RELATIONNO_API, null);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
            //return new CommonResponseDto(100, 'システムエラー', null);
        }        
    }
    
    /**
    * 契約支払者情報取得
    * 
    * @param serviceKey
    *       電力契約番号(SA)
    * @return 
    *       契約支払者情報を返却する
    * */
    @AuraEnabled
    public static CommonResponseDto getElectricityPaymentInfo(String serviceKey) {
        //契約支払者情報API
        CommonElectricityPaymentApi electricityPaymentApi = new CommonElectricityPaymentApi(serviceKey);
        try {
            electricityPaymentApi.send();
            CommonElectricityPaymentResponseDto electricityPaymentResponseDto = electricityPaymentApi.getElectricityPaymentInfo();
            return new commonResponseDto(0, null, electricityPaymentResponseDto); 
        } catch (ApiCallOutErrorException e) {
            return new CommonResponseDto(40, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.ELECTRICITY_PAYMENT_API, null);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
            //return new CommonResponseDto(100, 'システムエラー', null);
        }        
    }
    
    /**
    * 期間限定割情報取得
    * 
    * @param serviceKey
    *       電力契約番号(SA)
    * @return 
    *       期間限定割情報を返却する
    * */
    @AuraEnabled
    public static CommonResponseDto getElectricityTermLimitedInfo(String serviceKey) {
        //期間限定割情報API
        CommonElectricityTermLimitedApi electricityTermLimitedApi = new CommonElectricityTermLimitedApi(
            serviceKey
            , CommonConstantsUtil.API_SEARCH_LIMIT
            , null);
        try {
            electricityTermLimitedApi.send();
            List<CommonElectricityTermLimitedResponseDto> electricityTermLimitedResponseDtoList = electricityTermLimitedApi.getElectricityTermLimitedInfo();
            // 請求係数(昇順)
            return new commonResponseDto(
                0, null, CommonConvertUtil.sort(
                    electricityTermLimitedResponseDtoList
                    , new List<String>{'xLimitedCp'}
                    , new List<Boolean>{false}
                    , new List<Boolean>{false}));
        } catch (ApiCallOutErrorException e) {
            return new CommonResponseDto(40, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.ELECTRICITY_TERM_LIMITED_API, null);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
            //return new CommonResponseDto(100, 'システムエラー', null);
        }        
    }
    
    /**
    * 指図情報取得
    * 
    * @param serviceKey
    *       電力契約番号(SA)
    * @return 
    *       指図情報を返却する
    * */
    @AuraEnabled
    public static CommonResponseDto getElectricityOperationOrderInfo(String serviceKey) {
        //指図情報API
        CommonElectricityOperationOrderApi electricityOperationOrderApi = new CommonElectricityOperationOrderApi(
            null
            , serviceKey
            , CommonConstantsUtil.API_SEARCH_LIMIT
            , null);
        try {
            electricityOperationOrderApi.send();
            List<CommonOperationOrderResponseDto> operationOrderResponseDtoList = electricityOperationOrderApi.getElectricityOperationOrderInfo();
            return new commonResponseDto(0, null, CommonConvertUtil.sort(
                    operationOrderResponseDtoList
                    , new List<String>{'xUpdDttm', 'xOoStatusFlg', 'xOperationOrderId'}
                    , new List<Boolean>{true, false, false}
                    , new List<Boolean>{true, false, false})); 
        } catch (ApiCallOutErrorException e) {
            return new CommonResponseDto(40, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.ELECTRICITY_OPERATION_ORDER_API, null);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
            //return new CommonResponseDto(100, 'システムエラー', null);
        }        
    }
}