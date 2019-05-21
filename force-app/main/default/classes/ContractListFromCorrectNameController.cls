/**
 * 名義訂正画面契約リスト用コントローラ
 */
public with sharing class ContractListFromCorrectNameController {
    /**
     * 会員IDによって、契約リストを取得する
     * 
     * @param id　
     *       会員ID
     * @return 
     *       契約リスト
     * */
    @AuraEnabled
    public static CommonResponseDto getContractList(String id) {
        List<List<CommonKeySearchResponseDto>> contractList = null;
        try {
            // ケース情報取得
            Case caseInfo = getCaseInfo(id);
            if (caseInfo == null 
                || String.isBlank(caseInfo.BeforeCorrectNameOfKana__r.ClientId__c)) {
                    return new CommonResponseDto(40, '契約情報取得失敗', null);
                }
            CommonKeySearchApi searchApi = new CommonKeySearchApi(
                CommonConstantsUtil.CONTRACT_LIST_SERVICES, new List<String>{caseInfo.BeforeCorrectNameOfKana__r.ClientId__c});
            // リクエストの発送
            searchApi.send();
            // 共通メソッドで契約一覧の取得
            contractList = searchApi.getContractList();
            return new CommonResponseDto(0, null, contractList);
        } catch (ApiCallOutErrorException e) {
            return new CommonResponseDto(40, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.COMMON_KEY_API, null);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
            //return new CommonResponseDto(100, 'システムエラー', null);
        } 
    }

    /**
     * ガスメータ設置箇所情報を取得する
     * 
     * @param serviceKey　
     *       ガス契約キー
     * @param status　
     *       ガス状態
     * @return 
     *       メータ状態情報
     * */
    @AuraEnabled
    public static CommonResponseDto getGasMeterSetList(String serviceKey, String status) {
        Map<String, String> returnMap = new Map<String, String>();
        CommonGasMeterSetApi meterApi = new CommonGasMeterSetApi(null, serviceKey, null, null);
        try {
            // リクエストの発送
            meterApi.send();
            // レスポンス結果を解析すること
            meterApi.parseResponseData();
            // 共通メソッドでメータ状態を取得
            List<CommonGasMeterSetResponseDto> returnInfo = meterApi.getGasMeterSetListInfoBy4X();
            if (returnInfo == null || returnInfo.isEmpty()) {
                // ガスメータ開閉栓一覧が複数ではない場合、画面上に反映されないため、40で設定する
                return new CommonResponseDto(40, null, returnMap);
            }
            // ガスメータ設置箇所情報取得
            returnMap = CommonConvertUtil.getGasMeterInfo(returnInfo, returnMap, status);
        } catch (ApiCallOutErrorException e) {
            return new CommonResponseDto(40, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.GAS_METERSET_API, null);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
            //return new CommonResponseDto(100, 'システムエラー', null);
        }
        return new CommonResponseDto(0, null, returnMap);
    }

    /**
     * ガス料金契約種別を取得する
     * 
     * @param serviceKey　
     *       ガス契約キー
     * @return 
     *       ガス料金契約種別
     * */
    @AuraEnabled
    public static CommonResponseDto getGasContractListInfo(String serviceKey) {
        String menu = '';
        CommonGasContractApi gasApi = new CommonGasContractApi(serviceKey, null, null);
        try {
            // リクエストの発送
            gasApi.send();
            // 共通メソッドでガス料金契約種別を取得
            List<CommonGasContractResponseDto> gasInfo = gasApi.getGasContractListInfo();
            if (gasInfo != null && !gasInfo.isEmpty()) {
                menu = gasInfo.get(0).gasKySyb;
            }
        } catch (ApiCallOutErrorException e) {
            return new CommonResponseDto(40, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.GAS_CONTRACT_API, null);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
            //return new CommonResponseDto(100, 'システムエラー', null);
        }
        return new CommonResponseDto(0, null, menu);
    }

    /**
     * 料金表名を取得する
     * 
     * @param userKey　
     *       お客さま番号
     * @return 
     *       料金表名
     * */
    @AuraEnabled
    public static CommonResponseDto getOverseasGasContractInfo(String userKey) {
        //String menu = '';
        CommonOutsideTheAreaContractResponseDto otAInfo = new CommonOutsideTheAreaContractResponseDto();
        CommonOutsideTheAreaContractApi outsideTheAreaApi = new CommonOutsideTheAreaContractApi(userKey);
        try {
            // リクエストの発送
            outsideTheAreaApi.send();
            // 共通メソッドで料金表名を取得
            otAInfo = outsideTheAreaApi.getOverseasGasContractInfo();
            //if (otAInfo != null) {
            //    menu = otAInfo.planNm;
            //}
        } catch (ApiCallOutErrorException e) {
            return new CommonResponseDto(40, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.OUTSIDE_THEAREA_API, null);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
            //return new CommonResponseDto(100, 'システムエラー', null);
        }
        return new CommonResponseDto(0, null, otAInfo);//menu
    }

    /**
     * 料金メニューを取得する
     * 
     * @param serviceKey　
     *       ガス契約キー
     * @return 
     *       料金メニュー
     * */
    @AuraEnabled
    public static CommonResponseDto getElectricityContractInfo(String serviceKey) {
        String menu = '';
        CommonElectricityContractApi electricityApi = new CommonElectricityContractApi(serviceKey);
        try {
            // リクエストの発送
            electricityApi.send();
            // 共通メソッドで料金メニューを取得
            CommonElectricityContractResponseDto electricityInfo = electricityApi.getElectricityContractInfo();
            if (electricityInfo != null) {
                menu = electricityInfo.rsCdLabel;
            }
        } catch (ApiCallOutErrorException e) {
            return new CommonResponseDto(40, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.ELECTRICITY_CONTRACT_API, null);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
            //return new CommonResponseDto(100, 'システムエラー', null);
        }
        return new CommonResponseDto(0, null, menu);
    }

    /**
     * ケース情報取得
     * 
     * @param id　
     *       ケースid
     * @return 
     *       ケースオブジェクト
     * */
    private static Case getCaseInfo(String id) {
        // ケース情報取得
        List<Case> caseInfoList = [SELECT id, BeforeCorrectNameOfKana__r.ClientId__c FROM Case WHERE Id =: id];
        if(caseInfoList==null || caseInfoList.isEmpty()){
            return null;
        }
        return caseInfoList.get(0);
    }
    
    /**
     * 住所を取得する
     * 
     * @param contractGroup　
     *       契約リスト
     * @return 
     *       住所
     * */
    @AuraEnabled
    public static CommonResponseDto getContractListAddressTitle(List<CommonKeySearchResponseDto> contractGroup) {
        Map<String, String> serviceMap = new Map<String, String> {
            CommonConstantsUtil.SERVICE_TYPE_GAS => '001',
            CommonConstantsUtil.SERVICE_TYPE_OUTSIDE => '002',
            CommonConstantsUtil.SERVICE_TYPE_ELECTRICITY => '003',
            CommonConstantsUtil.SERVICE_TYPE_ALARM => '004'
        };
        try {
            String address = '';
            if (contractGroup != null && !contractGroup.isEmpty()) {
                List<CommonKeySearchResponseDto> searchList = new List<CommonKeySearchResponseDto>();
                for (CommonKeySearchResponseDto commonKeySearchResponse: contractGroup) {
                    String userKey = commonKeySearchResponse.userKey;
                    String serviceType = commonKeySearchResponse.serviceType;
                    if (String.isNotBlank(userKey) && serviceMap.containsKey(serviceType)) {
                        commonKeySearchResponse.sortOrder = serviceMap.get(serviceType);
                        searchList.add(commonKeySearchResponse);
					}
                }
                if (!searchList.isEmpty()) {
                    List<Object> orderedList = (List<Object>)CommonConvertUtil.sort(searchList, new List<String>{'sortOrder'}, new List<Boolean>{false}, new List<Boolean>{false});
                    for (Object commonKeySearchResponseObj : orderedList) {
                        CommonKeySearchResponseDto commonKeySearchResponse = (CommonKeySearchResponseDto) commonKeySearchResponseObj;
                        String userKey = commonKeySearchResponse.userKey;
                        String serviceType = commonKeySearchResponse.serviceType;
                        if (serviceType == CommonConstantsUtil.SERVICE_TYPE_GAS || serviceType == CommonConstantsUtil.SERVICE_TYPE_ALARM) {
                            CommonGasAccountApi gasAccountApi = new CommonGasAccountApi(userKey);
                            try {
                                // リクエストの発送
                                gasAccountApi.send();
                                // 共通メソッドで住所を取得
                                CommonGasAccountResponseDto gasAccountResponseDto = gasAccountApi.getAccountInfo();
                                if (gasAccountResponseDto != null && String.isNotBlank(gasAccountResponseDto.jusyo)) {
                                    address = gasAccountResponseDto.jusyo;
                                    break;
                                }
                            } catch (ApiCallOutErrorException e) {
                                return new CommonResponseDto(40, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.GAS_ACCOUNT_API, null);
                            }
                        } else if (serviceType == CommonConstantsUtil.SERVICE_TYPE_OUTSIDE) {
                            CommonOutsideTheAreaContractApi outSTAContractApi = new CommonOutsideTheAreaContractApi(userKey);
                            try {
                                // リクエストの発送
                                outSTAContractApi.send();
                                // 共通メソッドで住所を取得
                                CommonOutsideTheAreaContractResponseDto contractDto = outSTAContractApi.getOverseasGasContractInfo();
                                //住所(表示用)
                                if (contractDto != null && String.isNotBlank(contractDto.addressDisplay)) {
                                    address = contractDto.addressDisplay;
                                    break;
                                }
                            } catch (ApiCallOutErrorException e) {
                                return new CommonResponseDto(40, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.OUTSIDE_THEAREA_API, null);
                            }
                        } else if (serviceType == CommonConstantsUtil.SERVICE_TYPE_ELECTRICITY) {
                            CommonElectricityAccountApi electricityAccountApi = new CommonElectricityAccountApi(userKey);
                            try {
                                // リクエストの発送
                                electricityAccountApi.send();
                                // 共通メソッドで住所を取得
                                CommonElectricityAccountResponseDto electricityAccountResponseDto = electricityAccountApi.getElectricityAccountInfo();
                                if (electricityAccountResponseDto != null && String.isNotBlank(electricityAccountResponseDto.addressDisplay)) {
                                    address = electricityAccountResponseDto.addressDisplay;
                                    break;
                                }
                            } catch (ApiCallOutErrorException e) {
                                return new CommonResponseDto(40, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.ELECTRICITY_ACCOUNT_API, null);
                            }  
                        } 
                    }
                }
            }
            return new CommonResponseDto(0, null, address);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
        }
    }
}