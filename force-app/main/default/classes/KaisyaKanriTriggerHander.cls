public with sharing class KaisyaKanriTriggerHander {
    /** トリガから実行 */
    private Boolean isExecuting = false;
    
    /**
* コンストラクタ
*/
    public KaisyaKanriTriggerHander(boolean isExecutingExt){
        isExecuting = isExecutingExt;
    }
    /**
* 更新後処理
*/
    public void onBeforeUpdate(KAISYA_KANRI__c obj) {
        try{
            if(this.isExecuting) {
                KAISYA_RIREKI__c history = new KAISYA_RIREKI__c(
                    KAISYAMEI__c = obj.KAISYAMEI__c,
                    SETURITU__c = obj.SETURITU__c,
                    KAISYA_KODO__c = obj.KAISYA_KODO__c,
                    GYOSYU__c = obj.GYOSYU__c,
                    SHHNKN__c = obj.SHHNKN__c,
                    KAISYA_KANRI__c	= obj.name,
                    KS_JYD__c = obj.KS_JYD__c);
                //会社名
                //history.KAISYAMEI__c = obj.KAISYAMEI__c;
                //設立日
                //history.SETURITU__c = obj.SETURITU__c;
                //会社コード
                // history.KAISYA_KODO__c = obj.KAISYA_KODO__c;
                //業種
                //history.GYOSYU__c = obj.GYOSYU__c;
                //資本金
                //history.SHHNKN__c = obj.SHHNKN__c;
                //会社管理
                //history.KAISYA_KANRI__c	= obj.name;
                //会社重要度
                //history.KS_JYD__c = obj.KS_JYD__c;
                
                Database.SaveResult result = Database.insert(history);
                if(result.isSuccess()) {
                    system.debug('isSuccess');
                }else{
                    system.debug('isFailure');
                } 
            }
        } catch(Exception e){
            throw e;
        }
    }
}