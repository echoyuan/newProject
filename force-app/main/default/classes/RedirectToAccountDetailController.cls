/**
* 外部システムなどからの顧客詳細への遷移処理用コントローラ
*/
public with sharing class RedirectToAccountDetailController {
    /** バリデーションチェックメッセージ*/
    private static final String ERROR_MSG_1 = '該当する顧客が存在しません';
        
    /**
    * 顧客情報の取得
    * 
    * @param gascontract　
    *       ガス使用契約番号(4x)
    * @param customer　
    *       お客さま登録番号(3x)
    * @param meter　
    *       ガスメーター設置場所番号(1x)
    * @return 
    *       顧客情報
    * */
    @AuraEnabled
    public static CommonResponseDto getAccountInfo(String gascontract, String customer, String meter) {
       // CommonKeySearchApi searchApi = new CommonKeySearchApi(null, getServiceKeys(meter, customer, gascontract));
        try {
            // リクエストの発送
            //searchApi.send();
            // 共通メソッドで顧客IDの取得
            //List<List<CommonKeySearchResponseDto>> contractList = searchApi.getCustomerKey();
            //if (contractList == null || contractList.isEmpty()) {
            //    return new CommonResponseDto(40, ERROR_MSG_1, null);
            //}
            String customerId = '';
           /* for (List<CommonKeySearchResponseDto> dtoList : contractList) {
                if (dtoList != null && !dtoList.isEmpty()) {
                    for (CommonKeySearchResponseDto dto : dtoList) {
                        if (String.isNotBlank(dto.userKey)) {
                            customerId = dto.userKey;
                            break;
                        }
                    }
                }
                if (String.isNotBlank(customerId)) {
                    break;
                }
            }*/
            if (String.isEmpty(customerId)) {
                return new CommonResponseDto(40, ERROR_MSG_1, null);
            }
            // 顧客情報
            List<Account> accountList = [SELECT id,ClientId__c FROM Account WHERE ClientId__c =: customerId];
            if (accountList == null || accountList.isEmpty()) {
                return new CommonResponseDto(40, ERROR_MSG_1, null);
            }
            return new CommonResponseDto(0, null, accountList[0]);
        } catch (ApiCallOutErrorException e) {
            return new CommonResponseDto(40, CommonConstantsUtil.FIRST_OUTPUT + CommonConstantsUtil.COMMON_KEY_API, null);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
        }
    }
    
    /**
    * サービス契約キーの設定
    * 
    * @param no1x　
    *       ガスメーター設置場所番号(1x)
    * @param no3x　
    *       お客さま登録番号(3x)
    * @param no4x　
    *       ガス使用契約番号(4x)
    * @return 
    *       keys
    * */
    private static List<String> getServiceKeys(String no1x, String no3x, String no4x) {
        // サービス契約キー
        List<String> keys = new List<String>();
        if (String.isNotBlank(no4x)) {
            keys.add(no4x);
        }
        if (String.isNotBlank(no3x)) {
            keys.add(no3x);
        }
        if (String.isNotBlank(no1x)) {
            keys.add(no1x);
        }
        return keys;
    }
}