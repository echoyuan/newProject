/*******************************************************************************
*
* クラス名 : KaisyaKanriCtrl
* 概要 : [プロジェクト登録・編集]コントローラ
* 作成者 : 
* 作成日 : 
* 変更履歴 :
*
******************************************************************************/
public with sharing class KaisyaKanriCtrl {
    // メッセージ
    private static String cusLabel = System.Label.cutLabel;
    
    /**
* 画面表示項目のクラスです
*/
    public with sharing class CmpView {
        // フォロー先
        @AuraEnabled public KAISYA_KANRI__c recordInfo {get;set;}
        
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
            this.recordInfo = new KAISYA_KANRI__c();            
            if (String.isNotBlank(recordId)) {
                Schema.DescribeSObjectResult projectSr = KAISYA_KANRI__c.SObjectType.getDescribe();
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
                this.recordInfo = Database.query(strSql + ' From KAISYA_KANRI__c Where Id = \'' + recordId + '\' Limit 1');
                system.debug('strSql='+strSql);
                system.debug('recordInfo='+recordInfo);
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
    public static CmpView checkRecordInfo(KAISYA_KANRI__c pj) {
        CmpView cmpView = new CmpView();
        cmpView.errorMsg = new List<String>();
        // 項目名必須入力チェック
        if (String.isBlank(pj.KAISYAMEI__c)) {
            cmpView.errorMsg.add('会社名');
        }
        if (String.isBlank(pj.SYATYO_MEIGI__c)) {
            cmpView.errorMsg.add('社長名義');
        }
        //資本金
        if (pj.SHHNKN__c != null && (pj.SHHNKN__c >= 1000000000000000.0 || pj.SHHNKN__c <= -1000000000000000.0)) {
            cmpView.errorMsg.add('資本金');
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
    public static CmpView updatePj(KAISYA_KANRI__c pj) {
        return savePj(pj);
    }
    
    /**
* 保存ボタン押下処理
* @param pj 対象オブジェクト
* @return CmpView：画面オブジェクト
*/
    private static CmpView savePj(KAISYA_KANRI__c pj) {
        CmpView cmpView = new CmpView();
        //(pj.SYATYO_MEIGI__r = null;如果不设定，会报error)
        //Cannot specify both an external ID reference SYATYO_MEIGI__r and a salesforce id, SYATYO_MEIGI__c
        pj.SYATYO_MEIGI__r = null;
        //update method1
        Database.UpsertResult upsertRlt = Database.upsert(pj,false);
        // トリガの場合でエラーを返却するため、Databaseを使う
        if (!upsertRlt.isSuccess()) {
            cmpView.errorMsg = new List<String>();
            for (Database.Error e : upsertRlt.getErrors()) {  
                cmpView.errorMsg.add(e.getMessage());
            }
            return cmpView;
        }
        //update method2
        //upsert pj;
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
        List<KAISYA_KANRI__c> pjList = [Select id, LastModifiedById, LastModifiedBy.Name, SystemModstamp From KAISYA_KANRI__c Where SystemModstamp > : modStamp And Id = : recordId 
                                        ORDER BY SystemModstamp DESC Limit 1];
        if( pjList.size() > 0){
            return '当該レコードを他人にて更新されました。';
        }
        return null;   
    }
}