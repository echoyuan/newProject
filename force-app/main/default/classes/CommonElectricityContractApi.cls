/**
 * [電力]契約情報APIリクエスト共通処理
 */
public with sharing class CommonElectricityContractApi extends CommonAbstractRequestApi {
    private final String messageHeader = '[契約情報API]の通信に失敗しました。';
    /** ドメインURL */
    private static final String DOMAIN_URL = 'https://tgcrm-acp-api.azure-api.net/ele/';
    /** SubApiパス */
    private static final String CONTRACT_SUB_URL = 'contractDetail';
    /** セキュリティキー */
    private static final String SECURITY_KEY = '219f7e405cbc4adf949c066b8dca5b00';
    
    /** 電力契約番号(SA)*/
    private String sa = '';

    /**
     * コンストラクタ
     * */
    public CommonElectricityContractApi(String sa) {
        this.sa = sa;
    }
    
    /**
    * 契約情報を取得
    * 
    * @return 契約情報を戻る
   	* */
    public CommonElectricityContractResponseDto getElectricityContractInfo() {
        CommonElectricityContractResponseDto commonElectricityContractResponseDto = new CommonElectricityContractResponseDto();
        
        JSONParser parser = null;
        ResponseData data = null;
        try{
            // レスポンスボディーからデータを取得する
            parser = JSON.createParser(getResponse().getBody());
            data = (ResponseData) parser.readValueAs(ResponseData.class);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, messageHeader + CommonConst.ERR_CONTENT_TXT + e.getMessage());
            throw new ApiCallOutErrorException(e);
        } 
        
        // 返却成功の場合
        if (data.result == 'success') {
            commonElectricityContractResponseDto.saId = data.sa_id;
            commonElectricityContractResponseDto.xGas4X = data.x_gas_4x;
            commonElectricityContractResponseDto.xEl4X = data.x_el_4x;
            commonElectricityContractResponseDto.x3X = data.x_3x;
            commonElectricityContractResponseDto.x8X = data.x_8x;
            commonElectricityContractResponseDto.startDt = data.start_dt;
            commonElectricityContractResponseDto.endDt = data.end_dt;
            commonElectricityContractResponseDto.saStatusFlg = data.sa_status_flg;
            commonElectricityContractResponseDto.saStatusFlgLabel = data.sa_status_flg_label;
            commonElectricityContractResponseDto.xStopReason = data.x_stop_reason;
            commonElectricityContractResponseDto.xStopReasonLabel = data.x_stop_reason_label;
            commonElectricityContractResponseDto.saTypeCd = data.sa_type_cd;
            commonElectricityContractResponseDto.saTypeCdLabel = data.sa_type_cd_label;
            commonElectricityContractResponseDto.xPisNwCd = data.x_pis_nw_cd;
            commonElectricityContractResponseDto.xPisNwCdLabel = data.x_pis_nw_cd_label;
            commonElectricityContractResponseDto.xBasicMrDt = data.x_basic_mr_dt;
            commonElectricityContractResponseDto.effdt = data.effdt;
            commonElectricityContractResponseDto.rsCd = data.rs_cd;
            commonElectricityContractResponseDto.rsCdLabel = data.rs_cd_label;
            commonElectricityContractResponseDto.xContractCur = data.x_contract_cur;
            commonElectricityContractResponseDto.xContractCap = data.x_contract_cap;
            commonElectricityContractResponseDto.xContractOp = data.x_contract_op;
            commonElectricityContractResponseDto.xCampainStartDt = data.x_campain_start_dt;
            commonElectricityContractResponseDto.xCampainEndDt = data.x_campain_end_dt;
            commonElectricityContractResponseDto.val = data.val;
            commonElectricityContractResponseDto.xSupplyPointId = data.x_supply_point_id;
            return commonElectricityContractResponseDto;
        }
        
        // 結果が異常の場合、または結果コードがある場合
        resultError(data);
        
        return null;
    }
    
    /**
     * リクエストの設定
     * 
     * @param request　
     *       HttpRequest
     * */
    public override void setRequestInfo(HttpRequest request) {
		request.setHeader('Content-Length', '0');     
        request.setMethod(CommonConst.GET);
        request.setEndpoint(DOMAIN_URL + CONTRACT_SUB_URL);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Ocp-Apim-Subscription-Key', SECURITY_KEY);
    }

    private class ResponseData extends CommonApiResponseData {
        // 電力契約番号 
        private String sa_id  { get; set; }
        // ガス使用契約番号 
        private String x_gas_4x  { get; set; }
        // 電力使用契約番号 
        private String x_el_4x  { get; set; }
        // お客さま登録番号 
        private String x_3x  { get; set; }
        // カスタマ番号 
        private String x_8x  { get; set; }
        // 使用開始日 
        private String start_dt  { get; set; }
        // 使用中止日 
        private String end_dt  { get; set; }
        // 契約ステータス 
        private String sa_status_flg  { get; set; }
        // 契約ステータス(名称) 
        private String sa_status_flg_label  { get; set; }
        // 使用中止理由 
        private String x_stop_reason  { get; set; }
        // 使用中止理由(名称) 
        private String x_stop_reason_label  { get; set; }
        // 契約タイプ 
        private String sa_type_cd  { get; set; }
        // 契約タイプ(名称) 
        private String sa_type_cd_label  { get; set; }
        // NW箇所コード 
        private String x_pis_nw_cd  { get; set; }
        // NW箇所コード(名称) 
        private String x_pis_nw_cd_label  { get; set; }
        // 基本検針日 
        private String x_basic_mr_dt  { get; set; }
        // 料金メニュー適用開始日 
        private String effdt  { get; set; }
        // 料金メニュー 
        private String rs_cd  { get; set; }
        // 料金メニュー(名称) 
        private String rs_cd_label  { get; set; }
        // 契約電流 
        private String x_contract_cur  { get; set; }
        // 契約容量 
        private String x_contract_cap  { get; set; }
        // 契約電力 
        private String x_contract_op  { get; set; }
        // キャンペーン適用開始日 
        private String x_campain_start_dt  { get; set; }
        // キャンペーン適用終了日 
        private String x_campain_end_dt  { get; set; }
        // パック割適用区分 
        private String val  { get; set; }
        // 供給地点特定番号 
        private String x_supply_point_id  { get; set; }   
	}

    /**
     * タイムアウト、リトライ、ログ出力など設定
     * */
    public override void setApiCustomerInfo() {
        // sendのtimeout時間
        inOutTimeOut = 120000;
        // sendのリトライ間隔時間
        inOutSleepTime = 2000;
        // sendのリトライ回数
        inOutLoopCnt = 5;
        // ログ出力重要度
        notificationLevel = 1;
        // API通信エラーメッセージ
        message = this.messageHeader;
        // クラス名
        className = 'CommonElectricityContractApi';
    }
}