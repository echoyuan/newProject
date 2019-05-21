/**
 * APIリクエスト共通処理
 */
public abstract with sharing class CommonAbstractRequestApi {
    // レスポンスエラーコード
    private String errorCode = null;
    // レスポンスエラーメッセージ
    private String errorMessage = null;
    // リクエスト
    private HttpRequest request = null;
    // レスポンス
    private HttpResponse response = null;
    // ログ出力コンテンツ
    public String message = '';
    // クラス名
    public String className = '';
    // ログ出力またはメール送信重要度
    public Integer notificationLevel = 1;
    // sendのtimeout時間
    public Integer inOutTimeOut = 120000;
    // sendのリトライ間隔時間
    public Integer inOutSleepTime = 0;
    // sendのリトライ回数
    public Integer inOutLoopCnt = 0;
    // プロトコル
    public String protocol = '';
    // 環境Path
    public String environmentPath = '';
    // ケース番号
    public String caseNumber = '';
    // ケース
    public String caseId = '';
    // リトライ済回数
    private Integer loopCnt = 0;
    // 初期実行フラグ
    private boolean isFirst = true;
    // エラースローフラグ
    private boolean isThrow = false;
    // URL パラメータ
    public Integer limitNum;
    public Integer offset;
    // ドメインUR
    private String domainUrl = '';
    // SubApiパス
    private String subUrl = '';
    // セキュリティキー
    public String securityKey = '';
    // 接続URLパス
    public String fullPath = '';
    // APIリクエストタイプ
    public String apiRequestType = '';
    // 環境変数APIタイプ
    public String envApiRequestType = '';
    // ログ登録フラグ(デフォルト：登録)
    public Boolean isInsertFlag = true;
    
	/* 
	 * 取得レコード件数
	 */
    public Integer getLimitNum() {
        return limitNum;
    }  
    
	/* 
	 * 取得レコード開始位置
	 */
    public Integer getOffset() {
        return offset;
    }  
    
	/* 
	 * エラー重要度
	 */
    public Integer getLevel() {
        return notificationLevel;
    }  
    
	/* 
	 * リクエスト取得
	 */
    public HttpRequest getRequest() {
        return request;
    }   
    
	/* 
	 * レスポンス取得
	 */
    public HttpResponse getResponse() {
        return response;
    }
    
	/* 
	 * エラーメッセージ取得
	 */
    public String getErrorMessage() {
        return errorMessage;
    }
    
	/* 
	 * エラーコード取得
	 */
    public String getErrorCode() {
        return errorCode;
    }

    /**
     * リクエストの発送
     * */
    public void send() {
        // リクエスト設定作成
        request = new HttpRequest();
        request.setTimeout(inOutTimeOut);
        Http http = new Http();
        // タイムアウト、リトライ、ログ出力など設定
        setApiCustomerInfo();
        // 接続情報の設定
        setUrlInfo();
        // リクエスト情報設定
        setRequestInfo(request);
        // Send処理を行う
        sendWithcallOutRetry(http);
        
        // レスポンス返却値が異常の場合
        if (response == null) {
            system.debug(Logginglevel.ERROR, message);
            outputApiLog(null);
            throw new ApiCallOutErrorException();
        }
        if (responseError()) {
            system.debug(Logginglevel.ERROR, message + CommonConstantsUtil.ERR_CODE_TXT + response.getStatusCode());
            outputApiLog(null);
            throw new ApiCallOutErrorException();
        }
    }
    
    /**
     * リクエスト(TGM内部用API)の発送
     * */
    public void sendForTGM() {
        // リクエスト設定作成
        request = new HttpRequest();
        request.setTimeout(inOutTimeOut);
        Http http = new Http();
        // タイムアウト、リトライ、ログ出力など設定
        setApiCustomerInfo();
        // 接続情報の設定
        setUrlInfo();
        // リクエスト情報設定
        setRequestInfo(request);
        // Send処理を行う
        sendWithcallOutRetry(http);
        // レスポンス返却値が異常の場合
        if (response == null) {
            system.debug(Logginglevel.ERROR, message);
            outputApiLog(null);
            throw new ApiCallOutErrorException();
        }
    }

    /**
     * タイムアウト、リトライ、ログ出力など設定
     * */
    public abstract void setApiCustomerInfo();
    
    /**
     * リクエストの設定
     * 
     * @param request　
     *       HttpRequest
     * */
    public abstract void setRequestInfo(HttpRequest request);

    /**
     * タイムアウトでリトライ処理を行う
     * */
    private void sendWithcallOutRetry(Http http) {
        // 最初回Send処理で、リトライを行わないようにする
        if (!isFirst) {
            // リトライ間隔時間算出開始の設定
            Long timeDiff = 0;
            DateTime currentTime = System.now();
            do{
                // リトライ間隔時間算出
                timeDiff = System.now().getTime() - currentTime.getTime();
            } while(timeDiff <= inOutSleepTime); 
        }
        loopCnt = loopCnt + 1;
        if (loopCnt <= inOutLoopCnt){
            isFirst = false;
            try{
                response = http.send(request);
                if (response != null  && response.getStatusCode() >= 500) {
                    outputApiLog(null);
                    sendWithcallOutRetry(http);
                }
            } catch (Exception e) {
                outputApiLog(e);
                throw new ApiCallOutErrorException(e);
            }
        }
    }

    /**
     * レスポンス返却値が異常の場合
     * */
    private boolean responseError() {
        // レスポンス返却値が異常の場合
        if (String.isBlank(response.getBody())) {//response.getStatusCode() != 200 || 
            return true;
        }
        return false;
    }

    /**
     * 接続情報の設定
     * */
    private void setUrlInfo() {
        // APIリクエスト情報の取得
        Map<String, Object> apiRequestInfo = CommonConvertUtil.getApiRequest(apiRequestType);
        if (apiRequestInfo != null) {
            // sendのtimeout時間
            inOutTimeOut = CommonConvertUtil.toInteger(apiRequestInfo.get('inOutTimeOut'));
            // sendのリトライ間隔時間
            inOutSleepTime = CommonConvertUtil.toInteger(apiRequestInfo.get('inOutSleepTime'));
            // sendのリトライ回数
            inOutLoopCnt = CommonConvertUtil.toInteger(apiRequestInfo.get('inOutLoopCnt'));
            // ログ出力重要度
            notificationLevel = CommonConvertUtil.toInteger(apiRequestInfo.get('notificationLevel'));
            // SubApiパス
            subUrl = CommonConvertUtil.toBlank(apiRequestInfo.get('subUrl'));
        }
        // 環境変数_API情報の取得
        Map<String, String> envApiRequestInfo = CommonConvertUtil.getEnvApiRequestCommon(envApiRequestType);
        if (envApiRequestInfo != null) {
            // ドメインURL
            domainUrl = CommonConvertUtil.toBlank(envApiRequestInfo.get('domainUrl'));
            // プロトコル
            protocol = CommonConvertUtil.toBlank(envApiRequestInfo.get('protocol'));
            // セキュリティキー
            securityKey = CommonConvertUtil.toBlank(envApiRequestInfo.get('securityKey'));
            // 環境Path
            environmentPath = CommonConvertUtil.toBlank(envApiRequestInfo.get('environmentPath'));
        }
        // フルパスの取得
        fullPath = protocol + '://' + domainUrl + environmentPath + subUrl;
		fullPath = fullPath.replace(CommonConstantsUtil.HALF_SPACE, '').replace(CommonConstantsUtil.ALL_SPACE, '');
    }

    /**
     * 結果が異常の場合、または結果コードがある場合(情報連携キー用)
     * */
    public void resultError(CommonKeyApiResponseData data) {
        if (data.errors != null && data.errors.size() > 0) {
            for (CommonKeyApiErrorResponseDto err : data.errors) {
                system.debug(Logginglevel.ERROR, message 
                             + CommonConstantsUtil.ERR_CODE_TXT 
                             + err.code 
                             + CommonConstantsUtil.ERR_CONTENT_TXT 
                             + err.messageSystem);
            }
            throw new ApiCallOutErrorException();
        } else if ('error'.equals(data.result)) {
            system.debug(Logginglevel.ERROR, message);
            throw new ApiCallOutErrorException();
        }
    }

    /**
     * 結果が異常の場合、または結果コードがある場合
     * */
    public void resultError(CommonApiResponseData data) {
        if (data.errors != null && data.errors.size() > 0) {
            for (CommonApiErrorResponseDto err : data.errors) {
                system.debug(Logginglevel.ERROR, message 
                             + CommonConstantsUtil.ERR_CODE_TXT 
                             + err.code 
                             + CommonConstantsUtil.ERR_CONTENT_TXT 
                             + err.message_system);
            }
            throw new ApiCallOutErrorException();
        } else if ('error'.equals(data.result) && String.isNotBlank(data.message)) {
            // 結果コードがある場合
            system.debug(Logginglevel.ERROR, message 
                         + CommonConstantsUtil.ERR_CODE_TXT 
                         + data.code 
                         + CommonConstantsUtil.ERR_CONTENT_TXT 
                         + data.message);
            throw new ApiCallOutErrorException();
        } else if ('error'.equals(data.result)) {
            system.debug(Logginglevel.ERROR, message);
            throw new ApiCallOutErrorException();
        }
    }

    /**
     * ログ登録
     * */
    public void outputApiLog(Exception ex) {
        if (isInsertFlag) {
            CommonLoggingUtil.outputApiLog(
                getRequest()
                , getResponse()
                , ex
                , className
                , caseNumber
                , caseId
                , getLevel());
        }
    }
}