public class ConstantsUtil {
/** 請求GET */
    public static final String GET = 'GET';
    /** 請求POST */
    public static final String POST = 'POST';
    /** 削除DELETE */
    public static final String DELETE_METHOD = 'DELETE';
    /** 請求PUT */
    public static final String PUT = 'PUT';
    //検索件数制限定数
    public static final Integer cusSearchLimit = 201;
    //検索件数制限定数
    public static final Integer API_SEARCH_LIMIT = 100;
    //ハイフン
    public static final String hyphen = '-';
    //サービス契約種別(TG-CRM)
    public static final String SERVICE_TYPE_TGCRM = '013';
    //処理ステータス(CaseStatus)
    public static final String STATUS_3 = '対応完了';
    //処理ステータス(CaseStatus)
    public static final String STATUS_4 = '削除済';
    //処理ステータス(CaseStatus)
    public static final String STATUS_1 = '未対応';
    //処理ステータス(CaseStatus)
    public static final String STATUS_2 = '対応中';
    //処理ステータス(CaseStatus)
    public static final String STATUS_5 = '管理者対応中';
    // サービス契約種別（契約一覧）
    public static final List<String> CONTRACT_LIST_SERVICES = new List<String>{'001', '003', '004', '006', '007', '008', '010', '012'};
    //？
    public static final String QUERY_MARK = '?';
    //=
    public static final String EQUAL_MARK = '=';
    //半角スペース
    public static final String HALF_SPACE = ' ';
     ///
    public static final String SLASH_MARK = '/';
    //※
    public static final String FIRST_OUTPUT = '※';
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
    public static final String SYABAN_NO_GENERAL = '総合';
    
    //警報器有
    public static final String ALARM_EXIST = '有';
    
    //警報器無
    public static final String ALARM_NOT_EXIST = '無';
    //エラーコード
    public static final String ERR_CODE_TXT = 'エラーコード：';
    //エラー内容
    public static final String ERR_CONTENT_TXT = '　エラー内容：';
    //ロック状態
    public static final Boolean LOCKED_STATUS_1	 = false;
    //統合
    public static final String CLIENT_STATUS_IN = 'IntegratedClient';
    //未統合
    public static final String CLIENT_STATUS_UN = 'UnintegratedClient';
}