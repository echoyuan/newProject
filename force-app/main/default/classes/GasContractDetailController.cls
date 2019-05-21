public with sharing class GasContractDetailController {
    
    /**
    * お客さま情報取得
    * 
    * @param nox3
    *       お客さま登録番号(3x)
    * @return 
    *       お客さま情報を戻る
    * */
    @AuraEnabled
    public static CommonResponseDto getGasAccountInfo(String nox3) {
        try {
            //お客さま情報取得
            CommonGasAccountApi gasAccountApi = new CommonGasAccountApi(nox3);
            gasAccountApi.send();
            CommonGasAccountResponseDto gasAccountResponseDto = gasAccountApi.getAccountInfo();
            if (gasAccountResponseDto == null) {
                return new commonResponseDto(40, 'お客さま情報取得失敗', gasAccountResponseDto);
            }
            return new commonResponseDto(0, null, gasAccountResponseDto); 
          } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new commonResponseDto(100, 'システムエラー', null);
        }        
    }
    
    /**
    * ガス契約情報取得
    * 
    * @param nox4
    *       ガス使用契約番号(4x)
    * @return 
    *       ガス契約情報を戻る
    * */
    @AuraEnabled
    public static CommonResponseDto getGasContractListInfo(String nox4) {
        try {
            //ガス契約情報
            CommonGasContractApi gasContractApi = new CommonGasContractApi(nox4, null, null);
            gasContractApi.send();
            List<CommonGasContractResponseDto> gasContractResponseDtoList = gasContractApi.getGasContractListInfo();
            if (gasContractResponseDtoList == null || gasContractResponseDtoList.size() ==  0) {
                return new commonResponseDto(40, 'ガス契約情報取得失敗', null);
            }
            return new commonResponseDto(0, null, gasContractResponseDtoList); 
          } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new commonResponseDto(100, 'システムエラー', null);
        }        
    }
    
    /**
    * 電気料金合算パターン情報取得
    * 
    * @param nox4
    *       ガス使用契約番号(4x)
    * @return 
    *       電気料金合算パターン情報を戻る
    * */
    @AuraEnabled
    public static CommonResponseDto getGasElectricAddInfo(String nox4) {
        Integer errorCode = 0;
        String errorMsg = '';
        try {
            //電気料金合算パターン情報
            CommonGasElectricAddPatternApi gasElectricAddPatternApi = new CommonGasElectricAddPatternApi(nox4);
            gasElectricAddPatternApi.send();
            CommonGasElectricAddPatternResponseDto gasElectricAddPatternResponseDto = gasElectricAddPatternApi.getGasElectricAddPatternInfo();
            if (gasElectricAddPatternResponseDto == null) {
                return new commonResponseDto(40, '電気料金合算パターン情報取得失敗', null);
            }
            return new commonResponseDto(0, null, gasElectricAddPatternResponseDto); 
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new commonResponseDto(100, 'システムエラー', null);
        }        
    }
    
    /**
    * 接客履歴情報取得
    * 
    * @param nox3
    *       お客さま登録番号(3x)
    * @return 
    *       接客履歴情報を戻る
    * */
    @AuraEnabled
    public static CommonResponseDto getGasReceiveHistoryListInfo(String nox3) {
        try {
            //接客履歴情報取得
			CommonGasReceiveHistoryApi gasReceiveHistoryApi = new CommonGasReceiveHistoryApi(nox3, null, null);
            gasReceiveHistoryApi.send();
            List<CommonGasReceiveHistoryResponseDto> gasReceiveHistoryResponseDtoList = gasReceiveHistoryApi.getGasReceiveHistoryListInfo();
            if (gasReceiveHistoryResponseDtoList == null || gasReceiveHistoryResponseDtoList.size() == 0) {
                return new commonResponseDto(40, '接客履歴情報取得失敗', null);
            }
            return new commonResponseDto(0, null, gasReceiveHistoryResponseDtoList); 
          } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new commonResponseDto(100, 'システムエラー', null);
        }        
    }
    
    /**
    * 支払情報取得
    * 
    * @param nox2
    *       支払契約番号(2x)
    * @return 
    *       支払情報を戻る
    * */
    @AuraEnabled
    public static CommonResponseDto getPaymentListInfo(String nox2) {
        try {
            //支払情報取得
            CommonGasPaymentApi gasPaymentApi = new CommonGasPaymentApi(nox2, null, null);
            gasPaymentApi.send();
            List<CommonGasPaymentResponseDto> gasPaymentResponseDtoList = gasPaymentApi.getPaymentListInfo();
            if (gasPaymentResponseDtoList == null || gasPaymentResponseDtoList.size() ==  0) {
                return new commonResponseDto(40, '支払情報取得失敗', null);
            }
            return new commonResponseDto(0, null, gasPaymentResponseDtoList);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new commonResponseDto(100, 'システムエラー', null);
        }        
    }
    
    /**
    * ガスメータ設置場所情報取得
    * 
    * @param nox4
    *       ガス使用契約番号(4x)
    * @param isSogoAtkGmtSu
    *       総合契約判断
    * @return 
    *       ガスメータ設置場所情報を戻る
    * */
    @AuraEnabled
    public static CommonResponseDto getGasMeterSetListInfo(String nox4, boolean isSogoAtkGmtSu) {
        try {
            //ガスメータ設置場所情報API
            CommonGasMeterSetApi gasMeterSetApi = new CommonGasMeterSetApi(null, nox4, null, null);
            gasMeterSetApi.send();
            Object gasMeterSetInfo = null;
            if (isSogoAtkGmtSu) {
                gasMeterSetInfo = gasMeterSetApi.getGasMeterSetListInfoBy4X();                
            } else {
                gasMeterSetInfo = gasMeterSetApi.getGasMeterSetInfoBy4X();
            }
            if (gasMeterSetInfo == null) {
                return new commonResponseDto(40, 'ガスメータ設置場所情報取得失敗', null);
            }
            return new commonResponseDto(0, null, gasMeterSetInfo);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new commonResponseDto(100, 'システムエラー', null);
        }        
    }
    
    /**
    * 警報器機器情報取得
    * 
    * @param nox4
    *       ガス使用契約番号(4x)
    * @return 
    *       警報器機器情報
    * */
    @AuraEnabled
    public static CommonResponseDto getKhKikiInfo(String nox4) {
        try {
            String existStatus = CommonConst.ALARM_NOT_EXIST;
            //警報器機器情報API
            CommonAlarmMachineApi alarmMachineApi = new CommonAlarmMachineApi(null, nox4);
            alarmMachineApi.send();
            List <CommonAlarmMachineResponseDto> alarmMachineResponseDtoList = alarmMachineApi.getKhKikiInfo();
            if (alarmMachineResponseDtoList == null || alarmMachineResponseDtoList.size() ==  0) {
                return new commonResponseDto(40, '警報器機器情報取得失敗', null);
            }
            if (alarmMachineResponseDtoList.size() > 0) {
                existStatus = CommonConst.ALARM_EXIST;
            }
            return new commonResponseDto(0, null, existStatus);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new commonResponseDto(100, 'システムエラー', null);
        }        
    } 
}