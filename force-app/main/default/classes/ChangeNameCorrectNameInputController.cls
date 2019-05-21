public class ChangeNameCorrectNameInputController {
    // 名義訂正情報
    private static final String MEIGI_TEISEI = '名義訂正情報';
    // 名義変更情報
    private static final String MEIGI_HENKOU = '名義変更情報';
    // 権限チェックメッセージ
    private static final String PERMISSION_MSG = 'お客さま情報更新の処理をする権限がありません。権限が必要な場合はシステム管理者にお問い合わせしてください。';
    
    /**
     * 権限チェック、レコードタイプの取得、コピー用の顧客情報の取得
     * 
     * @param accountId
     *       顧客ID
     * @return 
     *       オブジェクト
     * */
    @AuraEnabled
    public static CommonResponseDto checkPermission(String accountId){
        String meigiteiseiRecTypeId;
        String meigihenkouRecTypeId;
        Map<String, Object> ret = new Map<String, Object>();
        try {
            RecordTypeInfo meigiTeiseiInfo = Schema.SObjectType.Case.getRecordTypeInfosByName().get(MEIGI_TEISEI);
            RecordTypeInfo meigiHenkouInfo = Schema.SObjectType.Case.getRecordTypeInfosByName().get(MEIGI_HENKOU);
            if (meigiTeiseiInfo != null && meigiTeiseiInfo.isAvailable()) {
                meigiteiseiRecTypeId = meigiTeiseiInfo.getRecordTypeId();
            }
            if (meigiHenkouInfo != null && meigiHenkouInfo.isAvailable()) {
                meigihenkouRecTypeId = meigiHenkouInfo.getRecordTypeId();
            }
            ret.put('meigiteiseiRecTypeId', meigiteiseiRecTypeId);
            ret.put('meigihenkouRecTypeId', meigihenkouRecTypeId);
            system.debug(Logginglevel.ERROR, 'accountId:' + accountId);
            ret.put('recordInfo', getRecordInfo(accountId));
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            return new CommonResponseDto(100, 'システムエラー', null);
        }
        if (String.isBlank(meigiteiseiRecTypeId) 
            || String.isBlank(meigihenkouRecTypeId) 
            || !Schema.sObjectType.Case.isCreateable()) {
            return new CommonResponseDto(40, PERMISSION_MSG, null);
        }
        return new CommonResponseDto(0, null, ret);
    }
    
    /**
     * コピー用の顧客情報の取得
     * 
     * @param accountId
     *       顧客ID
     * @return 
     *       顧客情報
     * */
    private static Account getRecordInfo(String accountId){
        Account accountInfo = [SELECT Id, Name//,NameOfKanji__c//, PhoneNumber1__c, PhoneNumber2__c, Address__c,
                                //BuildingName__c, BuildingNumber__c, RoomNumber__c, BillingState, BillingCity, 
                                //BillingStreet 
                               FROM Account WHERE Id =: accountId
                        ];
        return accountInfo != null ? accountInfo : null;
    }
    
    /**
     * 債務の承継時、新規ケースを作成
     * 
     * @param accountId
     *       顧客ID
     * @param recordTypeId
     *       レコードタイプID
     * @return 
     *       新規ケースId
     * */
    @AuraEnabled
    public static ID createNewCase(String accountId, String recordTypeId) {
        //旧名義人 FormerContractor__c	
		//受付チャネル Origin
		//処理ステータス CaseStatus__c
		//状況 Status	
		Case caseRecord = new Case(FormerContractor__c = accountId, Origin = '電話', CaseStatus__c = '対応中', Status='対応中', recordtypeid = recordTypeId);
        insert caseRecord;
		ID caseId = caseRecord.ID;
		return caseId; 
    }
}