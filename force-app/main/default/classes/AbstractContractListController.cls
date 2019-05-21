/**
 * 契約リスト抽象コンポーネント用コントローラ
 */
public with sharing class AbstractContractListController {
    /**
    * 名義変更画面で契約一覧保存処理
    */
    @AuraEnabled
    public static CaseContractResponseDto save(String id, List<List<CommonKeySearchResponseDto>> contractsList, List<String> checkList) {
        try{
            //テスト
            String strRst = changeObjectToJsonForSave(contractsList, checkList);
            case caseTemp = getCaseInfo(id);
            if (caseTemp == null) {
                return new CaseContractResponseDto(40, 'ケース情報取得失敗', null, null, null, null, null, null);
            }
            caseTemp.ContractListJsonText__c = strRst;
            caseTemp.CaseStatus__c = CommonConstantsUtil.CASE_STATUS_WORKING;
            update caseTemp;
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
            //return new CaseContractResponseDto(100, 'システムエラー', null, null, null, null, null, null);
        }
        return new CaseContractResponseDto(0, null, null, null, checkList, null, null, null);
    }
    
    private static String changeObjectToJsonForSave(List<List<CommonKeySearchResponseDto>> contractList, List<String> checkList){
        FormDto data = new FormDto(contractList,checkList);
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeObjectField('contractList', contractList);
        gen.writeObjectField('checkList', checkList);
        gen.writeEndObject();
        String strRst = gen.getAsString();
        return strRst;
    }
    
    private class FormDto{
        List<List<CommonKeySearchResponseDto>> contractList = null;
        List<String> checkList = null;
        private formDto(List<List<CommonKeySearchResponseDto>> contractListTemp, List<String> checkListTemp) {
            contractList = contractListTemp.clone();
            checkList = checkListTemp.clone();
        }
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
        List<Case> caseInfoList = [SELECT id, CaseStatus__c, ContractListJsonText__c FROM Case WHERE Id =: id];
        if(caseInfoList==null || caseInfoList.isEmpty()){
            return null;
        }
        return caseInfoList.get(0);
    }
}