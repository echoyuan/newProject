/*******************************************************************************
 *
 * クラス名 : SFProjectCtrl
 * 概要 : [プロジェクト登録・編集]コントローラ
 * 作成者 : 
 * 作成日 : 
 * 変更履歴 :
 *
 ******************************************************************************/
public with sharing class SFProjectCtrl {
    // メッセージ
    private static String cusLabel = System.Label.cutLabel;
    
    /**
     * 画面表示項目のクラスです
     */
    public with sharing class CmpView {
        // フォロー先
        @AuraEnabled public Project__c recordInfo {get;set;}

        // 表示メッセージ項目
        @AuraEnabled public transient List<String> errorMsg {get;set;}

        /**
         * コンストラクタです。
         */
        public CmpView() {
        }
        
        /**
         * コンストラクタです。
         */
        public CmpView(String recordId) {
            this.recordInfo = new Project__c();            
            if (String.isNotBlank(recordId)) {
                Schema.DescribeSObjectResult projectSr = Project__c.SObjectType.getDescribe();
                Map<String, Schema.SObjectField> fMap = projectSr.fields.getMap();
                Schema.DescribeFieldResult fr;
                String strSql = 'SELECT Id, SystemModstamp ';
                for (String fieldKey : fMap.keySet()) {
                    fr = fMap.get(fieldKey).getDescribe();
                    if ((fr.isAutoNumber() || fr.isCreateable()) && fr.isAccessible()) {
                        strSql = strSql + ' ,' + fieldKey;
                        If( fr.getRelationshipName() != null ){
                            strSql = strSql + ' ,' +  fr.getRelationshipName() + '.Id' + ' ,' +  fr.getRelationshipName() + '.Name';
                        }
                    }
                }
                system.debug('strSqlxxxxxxxxxxxxxxxx'+strSql);
                this.recordInfo = Database.query(strSql + ' From Project__c Where Id = \'' + recordId + '\' Limit 1');
            }
        }
    }

    /**
     * 初期化処理
     */
    @AuraEnabled
    public static CmpView initCmpView(String recordId) {
        CmpView cmpView = new CmpView(recordId);
        return cmpView;   
    }

    /**
     * 登録・更新時のチェック処理
     * @param pj 対象オブジェクト
     * @return CmpView 画面対象
     */
    @AuraEnabled
    public static CmpView checkRecordInfo(Project__c pj) {
        CmpView cmpView = new CmpView();
        cmpView.errorMsg = new List<String>();
        // 項目名必須入力チェック
        if (String.isBlank(pj.Name)) {
            cmpView.errorMsg.add(cusLabel);
        }
        
        if (cmpView.errorMsg.size() > 0) {
            return cmpView;
        }
        
        //排他処理を行う
        String exclusiveMsg = exclusiveCheck(pj.id, pj.SystemModstamp);
        //排他処理でエラーがあった場合、返却する
        if(String.isNotBlank(exclusiveMsg)){
            cmpView.errorMsg.add(exclusiveMsg);
            return cmpView;
        }   
        return cmpView;   
    }
    
    /**
     * 保存処理
     * @param pj 対象オブジェクト
     * @return CmpView：画面オブジェクト
     */
    @AuraEnabled
    public static CmpView updatePj(Project__c pj) {
        return savePj(pj);
    }
    
     /**
     * 保存ボタン押下処理
     * @param pj 対象オブジェクト
     * @return CmpView：画面オブジェクト
     */
    private static CmpView savePj(Project__c pj) {
        CmpView cmpView = new CmpView();
        Database.UpsertResult upsertRlt = Database.upsert(pj,false);
        // トリガの場合でエラーを返却するため、Databaseを使う
        if (!upsertRlt.isSuccess()) {
            cmpView.errorMsg = new List<String>();
            for (Database.Error e : upsertRlt.getErrors()){  
                cmpView.errorMsg.add(e.getMessage());
            }
            return cmpView;
        }
        
        cmpView.recordInfo = pj;
        
        return cmpView;
    }
    
    /**
     * 排他チェック
     */
    @AuraEnabled
    public static String exclusiveCheck(String recordId, DateTime modStamp) {
        if(String.isBlank(recordId) || modStamp == null){
            return null;
        }
        List<Project__c> pjList = [Select id, LastModifiedById, LastModifiedBy.Name, SystemModstamp From Project__c Where SystemModstamp > : modStamp And Id = : recordId 
                                     ORDER BY SystemModstamp DESC Limit 1];
        if( pjList.size() > 0){
            return '当該レコードを他人にて更新されました。';
        }
        return null;   
    }
    
    //test
    public List<CommonResponseSimpleContractDto> getContractList() {
        HttpResponse response = new HttpResponse();
        
        List<CommonResponseSimpleContractDto> serviceList = new List<CommonResponseSimpleContractDto>();
        JSONParser parser = JSON.createParser(response.getBody());
        
       
        
        return serviceList;
    }
}