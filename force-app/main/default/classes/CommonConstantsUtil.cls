/*
 * 定数共通処理
 */
public with sharing class CommonConstantsUtil {
    private CommonConstantsUtil(){
    }
    /** 請求GET */
    public static final String GET = 'GET';
    /** 請求POST */
    public static final String POST = 'POST';
    /** 削除DELETE */
    public static final String DELETE_METHOD = 'DELETE';
    /** 請求PUT */
    public static final String PUT = 'PUT';
    //検索件数制限定数
    public static final Integer CUS_SEARCH_LIMIT = 201;
    //検索件数制限定数
    public static final Integer API_SEARCH_LIMIT = 100;
    //検索件数制限定数
    public static final Integer API_SEARCH_LIMIT_30 = 30;
    //ハイフン
    public static final String HYPHEN = '-';
    //サービス契約種別(TG-CRM)
    public static final String SERVICE_TYPE_TGCRM = '013';
    //処理ステータス(CaseStatus)
    //public static final String STATUS_3 = '対応完了';
    //処理ステータス(CaseStatus)
    //public static final String STATUS_4 = '削除済';
    //処理ステータス(CaseStatus)
    //public static final String STATUS_1 = '未対応';
    //処理ステータス(CaseStatus)
    //public static final String STATUS_2 = '対応中';
    //処理ステータス(CaseStatus)
    //public static final String STATUS_5 = '管理者対応中';
    // サービス契約種別（契約一覧）
    public static final List<String> CONTRACT_LIST_SERVICES = new List<String>{'001', '003', '004', '006', '007', '008', '010', '012'};
    //？
    public static final String QUERY_MARK = '?';
    //=
    public static final String EQUAL_MARK = '=';
    //半角スペース
    public static final String HALF_SPACE = ' ';
    //全角スペース
    public static final String ALL_SPACE = '　';
    //
    public static final String SLASH_MARK = '/';
    //※
    public static final String FIRST_OUTPUT = '※';
    //:
    public static final String COLON = ':';
    //域外契約API取得失敗エラーメッセージ
    public static final String OUTSIDE_THEAREA_API = '域外契約情報取得に失敗しました。';
    //お客さま情報API取得失敗エラーメッセージ
    public static final String GAS_ACCOUNT_API = 'お客さま情報取得に失敗しました。';
    //ガス契約情報API取得失敗エラーメッセージ
    public static final String GAS_CONTRACT_API = 'ガス契約情報取得に失敗しました。';
    //電気料金合算パターン情報API取得失敗エラーメッセージ
    public static final String ELECTRIC_ADD_API = '電気料金合算パターン情報取得に失敗しました。';
    //接客履歴情報API取得失敗エラーメッセージ
    public static final String GAS_RECEIVE_API = '接客履歴情報取得に失敗しました。';
    //支払情報API取得失敗エラーメッセージ
    public static final String GAS_PAYMENT_API = '支払情報取得に失敗しました。';
    //ガスメータ設置場所情報API取得失敗エラーメッセージ
    public static final String GAS_METERSET_API = 'ガスメータ設置場所情報取得に失敗しました。';
    //メータ状態API取得失敗エラーメッセージ
    public static final String GAS_METER_API = 'メータ状態情報取得に失敗しました。';
    //トリプル割契約情報取得API取得失敗エラーメッセージ
    public static final String TRIPLE_CONTRACT_API = 'トリプル割契約情報取得に失敗しました。';
    //ガス関連番号情報API取得失敗エラーメッセージ
    public static final String GAS_RELATIONNO_API = 'ガス関連番号情報取得に失敗しました。';
    //警報器リース契約情報API取得失敗エラーメッセージ
    public static final String ALARM_CONTRACT_API = '警報器リース契約情報取得に失敗しました。';
    //警報器機器情報API取得失敗エラーメッセージ
    public static final String ALARM_MACHINE_API = '警報器機器情報取得に失敗しました。';
    //名寄せ紐づけAPI通信失敗エラーメッセージ
    public static final String KEY_MERGE_LINKED_API = '名寄せ紐づけ通信に失敗しました。';
    //名寄せ解体API通信失敗エラーメッセージ
    public static final String KEY_MERGE_DISSECTION_API = '名寄せ解体通信に失敗しました。';
    //名寄せ紐づけAPIまたは解体API通信失敗エラーメッセージ
    public static final String KEY_MERGE_API = '名寄せ紐づけまたは解体通信に失敗しました。';
    //電力契約情報API取得失敗エラーメッセージ
    public static final String ELECTRICITY_CONTRACT_API = '電力契約情報取得に失敗しました。';
    //契約お客さま情報API取得失敗エラーメッセージ
    public static final String ELECTRICITY_ACCOUNT_API = '契約お客さま情報取得に失敗しました。';
    //契約支払者情報API取得失敗エラーメッセージ
    public static final String ELECTRICITY_PAYMENT_API = '契約支払者情報取得に失敗しました。';
    //期間限定割情報API取得失敗エラーメッセージ
    public static final String ELECTRICITY_TERM_LIMITED_API = '期間限定割情報取得に失敗しました。';
    //指図情報API取得失敗エラーメッセージ
    public static final String ELECTRICITY_OPERATION_ORDER_API = '指図情報取得に失敗しました。';
    //スぺサポ契約情報API取得失敗エラーメッセージ
    public static final String SPECIAL_CONTRACT_API = 'スぺサポ契約情報取得に失敗しました。';
    //スぺサポ契約申込情報API取得失敗エラーメッセージ
    public static final String SPECIAL_APPLICATION_API = 'スぺサポ契約申込情報取得に失敗しました。';
    //会員情報API
    public static final String MEMBER_BASE_INFORMATION_API = '会員情報取得に失敗しました。';
    //ポイント残高API
    public static final String POINT_BALANCE_API = 'ポイント残高情報取得に失敗しました。';
    //メールサービスAPI
    public static final String EMAIL_SERVICE_API = 'メールサービス情報取得に失敗しました。';
    //契約・サービス一覧取得(キー検索)API
    public static final String COMMON_KEY_API = '契約・サービス一覧取得(キー検索)情報取得に失敗しました。';
    //TMAXAPI
    public static final String T_MAX_API = 'TMAX情報取得に失敗しました。';
     //&
    public static final String AND_MARK = '&';
    
    // 改行コード
    public static final String NEW_LINE_CODE = '\n';
    
    //支払指定日識別/コード（日指定）
    public static final String SHR_ST_DD_SB_CD_2 = '2';
    
    //支払指定日識別/コード（支払期限日）
    public static final String SHR_ST_DD_SB_CD_3 = '3';
    
    //支払指定日識別/コード（月末日）
    public static final String SHR_ST_DD_SB_CD_4 = '4';
    
    //支払指定日識別/コード（翌月日指定）
    public static final String SHR_ST_DD_SB_CD_5 = '5';
    
    //翌月
    public static final String NEXT_MONTH_TEXT = '翌月';
    
    //日
    public static final String DAY_TEXT = '日';
    
    //他システム使用契約特定結果(「未特定」)
    public static final String TASYSKY_EXIST_MITOKUTEYI = '「未特定」';
    
    //他システム使用契約特定結果(「特定済」)
    public static final String TASYSKY_EXIST_TOKUTEYIZUMI = '「特定済」';
    
    //電気料金合算パターン/コード(「未取得」)
    public static final String DGSNPTN_EXIST_MISYUTOKU = '「未取得」';
    
    //「電力合算」表示文字
    public static final String DGSNPTN_TEXT = '電力契約なし';
    
    //ガスメータ開閉栓状態/コード1
    public static final String GMT_KHSEN_JT_CD_1 = '1';
    //ガスメータ開閉栓状態/コード2
    public static final String GMT_KHSEN_JT_CD_2 = '2';
    //ガスメータ開閉栓状態/コード9
    public static final String GMT_KHSEN_JT_CD_9 = '9';
    
    //供内管・メータ設備状態/コード1
    public static final String KYN_GMT_SE_J_CD_1 = '1';
    //供内管・メータ設備状態/コード2
    public static final String KYN_GMT_SE_J_CD_2 = '2';
    //供内管・メータ設備状態/コード3
    public static final String KYN_GMT_SE_J_CD_3 = '3';
    //供内管・メータ設備状態/コード4
    public static final String KYN_GMT_SE_J_CD_4 = '4';
    //供内管・メータ設備状態/コード9
    public static final String KYN_GMT_SE_J_CD_9 = '9';

    //メータ状態(開栓中)
    public static final String GMT_STATUS_OPENING = '開栓中';
    //メータ状態(閉栓中)
    public static final String GMT_STATUS_CLOSING = '閉栓中';
    //メータ状態(休止中)
    public static final String GMT_STATUS_RESTING = '休止中';
    //メータ状態(撤去済)
    public static final String GMT_STATUS_WITHDRAWED = '撤去済';
    //メータ状態(抹消)
    public static final String GMT_STATUS_ERASE = '抹消';
    //メータ状態(解約済)
    public static final String GMT_STATUS_CLOSED = '解約済';
        
    //ガス料金契約種別/コード101
    public static final String GAS_KY_SYB_CD_101 = '101';
        
    //福祉/コード
    public static final String FUKUSI_CD_0 = '0';
    
    //金融機関/コード_郵便局
    public static final String YOKIN_SYB_CD_POST = '0900';
    //PK社番/番号(「総合」)
    //public static final String SYABAN_NO_GENERAL = '総合';
    
    //警報器有
    public static final String ALARM_EXIST = '有';
    
    //警報器無
    public static final String ALARM_NOT_EXIST = '無';
    //エラーコード
    public static final String ERR_CODE_TXT = 'エラーコード：';
    //エラー内容
    public static final String ERR_CONTENT_TXT = '　エラー内容：';
    //統合
    public static final String CLIENT_STATUS_IN = 'IntegratedClient';
    //未統合
    public static final String CLIENT_STATUS_UN = 'UnintegratedClient';
    //処理ステータス・対応中
    public static final String CASE_STATUS_WORKING = 'Working';
    //処理ステータス・対応完了
    public static final String CASE_STATUS_WORKINGDONE = 'WorkingDone';
    //処理ステータス・削除済
    public static final String CASE_STATUS_DELETEDONE = 'DeleteDone';
    //処理ステータス・管理者対応中
    public static final String CASE_STATUS_MANAGERWORKING = 'ManagerWorking';
    //状態・有効
    public static final String STATUS_AVAILABLE = 'Available';
    //状態・無効
    public static final String STATUS_UNAVAILABLE = 'Unavailable';
    //受付チャネル・電話
    public static final String ORIGIN_PHONE = 'Phone';
    // 日時フォーマット
    //public static final String YYYYMMDDHHMMSS = 'yyyy/MM/dd HH:mm:ss';
    //契約電流
    public static final String CURRENT_UNIT = 'A';
    //契約容量
    public static final String CAPACITY_UNIT = 'kVA';
    //契約電力
    public static final String POWER_UNIT = 'kW';
    //初期移行フラグ_メッセージ（"A" or "D"(mTG名義とCIS名義が完全一致したパターン)の場合）
    public static final String TGCRM_INITIAL_TRANSITION_MSG1 = '「mTG登録名義一致(A)」や「mTG登録名義一致(D)」';
    //初期移行フラグ_メッセージ（以外の場合）
    public static final String TGCRM_INITIAL_TRANSITION_MSG2 = 'mTG登録名義不一致';
    //初期移行フラグ（A）
    public static final String TGCRM_INITIAL_TRANSITION_A = 'A';
    //初期移行フラグ（D）
    public static final String TGCRM_INITIAL_TRANSITION_D = 'D';
    /** URL パラメータ*/
    public static final String LIMIT_URL_KEY = 'limit';
    public static final String OFFSET_URL_KEY = 'offset';
    public static final String MEMBER_ID = 'memberId';
    public static final Integer NOTIFICATION_LEVEL = 3;
    // 名寄せ作業
    public static final String MERGE_WORK_GET = '名寄せ作業';
    // 名義訂正情報
    public static final String MEIGI_TEISEI_GET = '名義訂正情報';
    // 名義変更情報
    public static final String MEIGI_HENKOU_GET = '名義変更情報';
    // 名義訂正
    public static final String MEIGI_TEISEI_DISPLAY = '名義訂正';
    // 名義変更
    public static final String MEIGI_HENKOU_DISPLAY = '名義変更';
    // カスタムメタデータ(環境変数_APIリクエスト共通)に定義されたタイプ（電力）
    public static final String API_TYPE_ELECTRICITY = 'Electricity';
    // カスタムメタデータ(環境変数_APIリクエスト共通)に定義されたタイプ（警報器リース）
    public static final String API_TYPE_ALARM = 'Alarm';
    // カスタムメタデータ(環境変数_APIリクエスト共通)に定義されたタイプ（域外ガス）
    public static final String API_TYPE_OUTSIDETHEAREA = 'OutsideTheArea';
    // カスタムメタデータ(環境変数_APIリクエスト共通)に定義されたタイプ（トリプル割）
    public static final String API_TYPE_TRIPLE = 'Triple';
    // カスタムメタデータ(環境変数_APIリクエスト共通)に定義されたタイプ（スペサポ）
    public static final String API_TYPE_SPECIAL = 'Special';
    // カスタムメタデータ(環境変数_APIリクエスト共通)に定義されたタイプ（ガス）
    public static final String API_TYPE_GAS = 'Gas';
    // カスタムメタデータ(環境変数_APIリクエスト共通)に定義されたタイプ（情報連携キー）
    public static final String API_TYPE_KEY = 'Key';
    // カスタムメタデータ(環境変数_APIリクエスト共通)に定義されたタイプ（TGCRM）
    public static final String API_TYPE_TGCRM = 'Tgcrm';
    // カスタムメタデータ(環境変数_APIリクエスト共通)に定義されたタイプ（T-MAX）
    public static final String API_TYPE_TMAX = 'Tmax';
    // カスタムメタデータ(環境変数_APIリクエスト共通)に定義されたタイプ（myTOKYOGAS）
    public static final String API_TYPE_MTG = 'Mtg';
    // Api呼出で開始Offset
    public static final Integer OFFSET_START = 1;
    // フォロー完了(更新なし)
    public static final String DUTYSTATUS_FOLLOWDONENOMODIFY = 'FollowDoneNoModify';
    // フォロー完了(更新あり)
    public static final String DUTYSTATUS_FOLLOWDONEMODIFY = 'FollowDoneModify';
    // プロファイル：統合顧客チーム
    //public static final String INTEGRATECLI = 'IntegratedClientTeam';
    // プロファイル：統合顧客チーム管理者
    public static final String INTEGRATECLIADMIN = 'IntegratedClientTeamManager';
    // プロファイル：システム管理者
    public static final String SYSTEMADMIN = 'SystemAdministrator';
    // プロファイル：バッチユーザ
    public static final String BATCHUSER = 'BatchUser';
    // フォロー要
    //public static final String DUTYSTATUS_UNFOLLOW = 'Unfollow';
    //  フォロー不要(自動紐付け済)
    //public static final String DUTYSTATUS_AUTOMATCHING = 'AutoMatching';
    //カスタムメタデータレコード名
    //public static final String DEVELOPER_NAME_CHARACTER = 'CharacterCase';
    //カスタムメタデータレコード名
    //public static final String DEVELOPER_NAME_SYMBOL = 'SymbolCase';
    //カスタムメタデータレコード名
    //public static final String DEVELOPER_NAME_ADDRESS = 'AddressCase';
    //，
    public static final String COMMA_MARK = ',';
    //"
    public static final String DOUBLE_QUOTES_MARK = '"';
    // 改行コード
    public static final String SPLIT_LINE_CODE = '\\r|\\n';
    // '",","'
    public static final String COMMA_SPECIAL_CODE = '",","';
    // '","COMMA"'
    public static final String COMMA_SPECIA_CODE_CONVERT = '","COMMA"';
    //'"COMMA"'
    public static final String COMMA_STRING = 'COMMA';
    //'""""'
    public static final String DOUBLE_QUOTES_SPECIAL_CODE = '""""';
    //'QUOTES'
    public static final String DOUBLE_QUOTES_STRING = 'QUOTES';
    //'|'
    public static final String OR_MARK = '|';
    //情報連携キーのoutboundAPIの登録リクエストで、登録者ID(User.社員番号)を指定しているところ、
    //社員番号がnullであればダミー値(「TGCRMUSER」)を指定
    public static final String TGCRMUSER = 'TGCRMUSER';
    //Locked
    public static final String LOCKED = 'Locked';
    //Unlocked
    public static final String UNLOCKED = 'Unlocked';
    //サービス契約種別(ガス)
    public static final String SERVICE_TYPE_GAS = '001';
    //サービス契約種別(域外ガス)
    public static final String SERVICE_TYPE_OUTSIDE = '010';
    //サービス契約種別(電気)
    public static final String SERVICE_TYPE_ELECTRICITY = '006';
    //サービス契約種別(警報器リース)
    public static final String SERVICE_TYPE_ALARM = '004';
    //紐付けキー種別
    public static final String ASSOCIATE_KEY_TYPE = '12';
    //照会レベル
    public static final String REFERENCE_LEVEL = '1';
    //サービス契約異動種別：提供中
    public static final String TRANSFER_TYPE_02 = '02';
    //サービス契約異動種別：解約
    public static final String TRANSFER_TYPE_04 = '04';
    //システム種別(TG-CRM)
    public static final String SYSTEMTYPE = '10';
    //基幹キー種別:顧客ID
    public static final String KEYTYPE_CLIENTID = '017';
    //基幹キー種別 (統合顧客ID(Ax))
    public static final String KEYTYPE_INTEGRATEDCLIENTID = '018';
    //ユーザータイプ種別(不定)
    public static final String USER_TYPE_3 = '3';
    //ロール種別:使用者
    public static final String ROLETYPE_USER_01 = '01';
}