public with sharing class ProjectTriggerHander {
    /** トリガから実行 */
    private Boolean isExecuting = false;
    
    /**
	* コンストラクタ
	*/
    public ProjectTriggerHander(boolean isExecutingExt){
        isExecuting = isExecutingExt;
    }
    
    
    /**
	* 更新後処理
	*/
    public void onAfterUpdate(Project__c[] newObjs){
        try{
            // projectのidを取得
            Set<String> ids = new Set<String>();
            for (Project__c pj : newObjs) {
                ids.add(pj.id);
            }
            List<Messai__c> msList = new List<Messai__c>();            
            
            //-------------------------------Start------------------------------------
            // 方法１
            List<Project__c> pjList = [select id, (select id,price__c from projectMessai__r) from Project__c where id in : ids];
            for (Project__c pj : pjList) {
                if (!pj.projectMessai__r.isEmpty()) {
                    for (Messai__c ms : pj.projectMessai__r) {
                        if (ms.price__c > 0) {
                            // 値段が>0の場合、1001に更新する
                            ms.price__c = 1001;
                            msList.add(ms);
                        }
                    }
                }
            }
            
            // 方法２
            msList = new List<Messai__c>();
            List<Messai__c> meisaiList = [select id, price__c from Messai__c where Project__c in : ids];
            if (!meisaiList.isEmpty()) {
                for (Messai__c ms : meisaiList) {
                    if (ms.price__c > 0) {
                        // 値段が>0の場合、1001に更新する
                        ms.price__c = 1001;
                        msList.add(ms);
                    }
                }
            }
            //-------------------------------End------------------------------------
            
            if (!msList.isEmpty()) {
                // 明細更新
                update msList;
            }
        } catch(Exception e){
            throw e;
        }
    }
}