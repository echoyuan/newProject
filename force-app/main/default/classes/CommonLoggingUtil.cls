/**
 * API通信エラーログ登録処理
 */
public with sharing class CommonLoggingUtil {
    private CommonLoggingUtil(){
    }
    /**
     * API通信エラーログ登録
     * 
     * @param request
     *       リクエスト
     * @param response
     *       レスポンス
     * @param ex
     *       異常
     * @param className
     *       クラス名
     * @param caseNumber
     *       ケース番号
     * @param caseId
     *       ケース
     * @param notificationLevel
     *       ログレベル
     * */
    public static void outputApiLog(
        HttpRequest request
        , HttpResponse response
        , Exception ex
        , String className
        , String caseNumber
        , String caseId
        , Integer notificationLevel) {
            // API通信エラーログ
            ApiConnectionErrorLog__c apiConnLog = new ApiConnectionErrorLog__c();
            // クラス名
            apiConnLog.ClassName__c = className;
            // ログレベル
            apiConnLog.LogLevel__c = notificationLevel;
            if (request != null) {
                // リクエストURL
                apiConnLog.RequestUrl__c = request.getEndpoint();
                // リクエストメソッド
                apiConnLog.RequestMethod__c = request.getMethod();
                // リクエストボディ
                apiConnLog.RequestBody__c = request.getBody();
            }
            if (response != null) {
                // HTTPステータスコード
                apiConnLog.HttpStatusCode__c = String.valueOf(response.getStatusCode());
                // レスポンスボディ
                apiConnLog.ResponseBody__c = response.getBody();
            }
            if (ex != null) {
                // エラーメッセージ
                apiConnLog.ErrorMessage__c = ex.getMessage();
                // スタックトレース
                apiConnLog.StackTrace__c = ex.getStackTraceString();
            }
            // ケース番号
            if (String.isNotBlank(caseNumber)) {
                apiConnLog.CaseNumber__c = caseNumber;
            }
            // ケース
            if (String.isNotBlank(caseId)) {
                apiConnLog.Case__c = caseId;
            }
            insert apiConnLog;
    }
     /**
     * API通信エラーログ集合追加
     * 
     * @param apiLogInfoList
     *       List<Map<String, Object>>
     * */
    public static List<ApiConnectionErrorLog__c> addApiLogBulk(
        List<Map<String, Object>> apiLogInfoList) {
            List<ApiConnectionErrorLog__c> retApiConnLogList = new List<ApiConnectionErrorLog__c>();
            for (Map<String, Object> apiLogInfo : apiLogInfoList) {
                HttpRequest request;
                HttpResponse response;
                Exception ex;
                if (apiLogInfo.get('request') != null) {
                    request = (HttpRequest)apiLogInfo.get('request');
                }
                if (apiLogInfo.get('response') != null) {
                    response = (HttpResponse)apiLogInfo.get('response');
                }
                if (apiLogInfo.get('ex') != null) {
                    ex = (Exception)apiLogInfo.get('ex');
                }
                String className = String.valueOf(apiLogInfo.get('className'));
                String caseNumber = String.valueOf(apiLogInfo.get('caseNumber'));
                String caseId = String.valueOf(apiLogInfo.get('caseId')); 
                Integer notificationLevel = Integer.valueOf(apiLogInfo.get('notificationLevel')); 
                // API通信エラーログ
                ApiConnectionErrorLog__c apiConnLog = new ApiConnectionErrorLog__c();
                // クラス名
                apiConnLog.ClassName__c = className;
                // ログレベル
                apiConnLog.LogLevel__c = notificationLevel;
                if (request != null) {
                    // リクエストURL
                    apiConnLog.RequestUrl__c = request.getEndpoint();
                    // リクエストメソッド
                    apiConnLog.RequestMethod__c = request.getMethod();
                    // リクエストボディ
                    apiConnLog.RequestBody__c = request.getBody();
                }
                if (response != null) {
                    // HTTPステータスコード
                    apiConnLog.HttpStatusCode__c = String.valueOf(response.getStatusCode());
                    // レスポンスボディ
                    apiConnLog.ResponseBody__c = response.getBody();
                }
                if (ex != null) {
                    // エラーメッセージ
                    apiConnLog.ErrorMessage__c = ex.getMessage();
                    // スタックトレース
                    apiConnLog.StackTrace__c = ex.getStackTraceString();
                }
                // ケース番号
                if (String.isNotBlank(caseNumber)) {
                    apiConnLog.CaseNumber__c = caseNumber;
                }
                // ケース
                if (String.isNotBlank(caseId)) {
                    apiConnLog.Case__c = caseId;
                }
                retApiConnLogList.add(apiConnLog);
            }
            return  retApiConnLogList;
         }
}