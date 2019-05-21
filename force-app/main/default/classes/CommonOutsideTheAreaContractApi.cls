/**
 * [域外]契約情報APIリクエスト共通処理
 */
public with sharing class CommonOutsideTheAreaContractApi extends CommonAbstractRequestApi {
    // API通信エラーメッセージ
    private final String messageHeader = '[域外契約情報API]の通信に失敗しました。';
    // くらし番号
    private String gasCustomerCode3xOp = '';
    
	/* 
	 * コンストラクタ 
	 * 
     * @param gasCustomerCode3xOp　
     *       3ｘ
	 */
    public CommonOutsideTheAreaContractApi(String gasCustomerCode3xOp) {
        this.gasCustomerCode3xOp = gasCustomerCode3xOp;
    }
    
    /**
     * リクエストの設定
     * 
     * @param request　
     *       HttpRequest
     * */
    public override void setRequestInfo(HttpRequest request) {
        request.setHeader('Content-Length', '0');
        request.setMethod(CommonConstantsUtil.GET);
        request.setEndpoint(fullPath + '?triple_kanri_id=' + gasCustomerCode3xOp);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Ocp-Apim-Subscription-Key', securityKey);
    }

    /**
     * 域外契約詳細情報の取得
     * 
     * @return 　
     *       域外契約詳細情報を返却する
     * */
    public CommonOutsideTheAreaContractResponseDto getOverseasGasContractInfo() {
        CommonOutsideTheAreaContractResponseDto commonOutsideTheAreaContractResponseDto = new CommonOutsideTheAreaContractResponseDto();
       
        JSONParser parser = null;
        ResponseData data = null;
        try{
            // レスポンスボディーからデータを取得する
            parser = JSON.createParser(getResponse().getBody());
            data = (ResponseData) parser.readValueAs(ResponseData.class);
            
            // 結果が異常の場合、または結果コードがある場合
            resultError(data);
            
            // 返却成功の場合
            //if ('success'.equals(data.result)) {
                //if (data.responseContractDto != null) {
                    //OutsideTheAreaContractResponseDto outsideTheAreaContractDetailDto = data.responseContractDto;
                    commonOutsideTheAreaContractResponseDto.customerCd = data.customer_cd;
                    commonOutsideTheAreaContractResponseDto.customerNm = data.customer_nm;
                    commonOutsideTheAreaContractResponseDto.customerNmK = data.customer_nm_k;
                    // 電話番号
                    String tel = '';
                    List<String> telList = new List<String>();
                    if (String.isNotBlank(data.tel_no)) {
                        telList.add(data.tel_no);
                    }
                    if (String.isNotBlank(data.mobile_no)) {
                        telList.add(data.mobile_no);
                    }
                    if (!telList.isEmpty()) {
                        tel = String.join(telList, CommonConstantsUtil.NEW_LINE_CODE);
                    }
                    // 住所
                    String address = '';
                    List<String> addressList = new List<String>();
                    if (String.isNotBlank(data.address)) {
                        addressList.add(data.address);
                    }
                    if (String.isNotBlank(data.address_sub)) {
                        addressList.add(data.address_sub);
                    }
                    if (!addressList.isEmpty()) {
                        address = String.join(addressList, CommonConstantsUtil.ALL_SPACE);
                    }
                    commonOutsideTheAreaContractResponseDto.telNos = tel;
                    commonOutsideTheAreaContractResponseDto.telNo = data.tel_no;
                    commonOutsideTheAreaContractResponseDto.mobileNo = data.mobile_no;
                    commonOutsideTheAreaContractResponseDto.postalCd = CommonConvertUtil.formatPostNoStr(data.postal_cd);
                    commonOutsideTheAreaContractResponseDto.addressDisplay = address;
                    commonOutsideTheAreaContractResponseDto.address = data.address;
                    commonOutsideTheAreaContractResponseDto.addressSub = data.address_sub;
                    commonOutsideTheAreaContractResponseDto.kyokyuNo = data.kyokyu_no;
                    commonOutsideTheAreaContractResponseDto.gasArea = data.gas_area;
                    commonOutsideTheAreaContractResponseDto.standMr = data.stand_mr;
                    commonOutsideTheAreaContractResponseDto.sougou = data.sougou;
                    commonOutsideTheAreaContractResponseDto.keitaiCd = data.keitai_cd;
                    commonOutsideTheAreaContractResponseDto.keitaiNm = data.keitai_nm;
                    commonOutsideTheAreaContractResponseDto.salespersonNm = data.salesperson_nm;
                    commonOutsideTheAreaContractResponseDto.planCd = data.plan_cd;
                    commonOutsideTheAreaContractResponseDto.planNm = data.plan_nm;
                    commonOutsideTheAreaContractResponseDto.charge3Kbn = data.charge_3_kbn;
                    commonOutsideTheAreaContractResponseDto.paymentCd = data.payment_cd;
                    commonOutsideTheAreaContractResponseDto.paymentNm = data.payment_nm;
                    commonOutsideTheAreaContractResponseDto.receiptDt = CommonConvertUtil.formatDateStr(data.receipt_dt);
                    commonOutsideTheAreaContractResponseDto.contractDt = CommonConvertUtil.formatDateStr(data.contract_dt);
                    commonOutsideTheAreaContractResponseDto.oshiraseDt = CommonConvertUtil.formatDateStr(data.oshirase_dt);
                    commonOutsideTheAreaContractResponseDto.supplyDt = CommonConvertUtil.formatDateStr(data.supply_dt);
                    commonOutsideTheAreaContractResponseDto.cancelDt = CommonConvertUtil.formatDateStr(data.cancel_dt);
                    commonOutsideTheAreaContractResponseDto.closeDt = CommonConvertUtil.formatDateStr(data.close_dt);
                    commonOutsideTheAreaContractResponseDto.pCustomerNm = data.p_customer_nm;
                    commonOutsideTheAreaContractResponseDto.pCustomerNmK = data.p_customer_nm_k;
                    commonOutsideTheAreaContractResponseDto.pTelNo = data.p_tel_no;
                    commonOutsideTheAreaContractResponseDto.pPostalCd = CommonConvertUtil.formatPostNoStr(data.p_postal_cd);
                    commonOutsideTheAreaContractResponseDto.pAddress = data.p_address;
                    commonOutsideTheAreaContractResponseDto.pAddressSub = data.p_address_sub;
                    commonOutsideTheAreaContractResponseDto.contractCancel = data.contract_cancel;
                    String nowDay = CommonConvertUtil.format(Date.today(), null);
                    String supplyDt = CommonConvertUtil.formatDateStr(commonOutsideTheAreaContractResponseDto.supplyDt);
                    String closeDt = CommonConvertUtil.formatDateStr(commonOutsideTheAreaContractResponseDto.closeDt);
                    if (String.isNotBlank(supplyDt) && nowDay < supplyDt) {
                        commonOutsideTheAreaContractResponseDto.kyokyuStatus = '未供給';
                    } else if (String.isNotBlank(supplyDt) 
                        && String.isNotBlank(closeDt) 
                        && nowDay >= supplyDt
                        && nowDay < closeDt) {
                        commonOutsideTheAreaContractResponseDto.kyokyuStatus = '供給中';
                    } else if (String.isNotBlank(closeDt) && nowDay >= closeDt) {
                        commonOutsideTheAreaContractResponseDto.kyokyuStatus = '供給終了';
                    }
                //} 
                return commonOutsideTheAreaContractResponseDto;
            //}
 
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, messageHeader + CommonConstantsUtil.ERR_CONTENT_TXT + e.getMessage());
            CommonLoggingUtil.outputApiLog(
                getRequest()
                , getResponse()
                , e
                , className
                , ''
                , ''
                , getLevel());
            throw new ApiCallOutErrorException(e);
        } 
        
        //return null;
    }

    private class ResponseData extends CommonApiResponseData {
        // お客さま番号
        @AuraEnabled public String 	customer_cd	{ get; set; }
        // 名前(漢字)
        @AuraEnabled public String 	customer_nm	{ get; set; }
        // 名前(カナ)
        @AuraEnabled public String 	customer_nm_k	{ get; set; }
        // 電話番号
        @AuraEnabled public String 	tel_no	{ get; set; }
        // 携帯番号
        @AuraEnabled public String 	mobile_no	{ get; set; }
        // 郵便番号
        @AuraEnabled public String 	postal_cd	{ get; set; }
        // 住所
        @AuraEnabled public String 	address	{ get; set; }
        // 住所予備
        @AuraEnabled public String 	address_sub	{ get; set; }
        // 供給地点特定番号
        @AuraEnabled public String 	kyokyu_no	{ get; set; }
        // ガス導管網エリア
        @AuraEnabled public String 	gas_area	{ get; set; }
        // 基準検針日
        @AuraEnabled public String 	stand_mr	{ get; set; }
        // 総合設定
        @AuraEnabled public String 	sougou	{ get; set; }
        // 形態コード
        @AuraEnabled public String 	keitai_cd	{ get; set; }
        // 形態名称
        @AuraEnabled public String 	keitai_nm	{ get; set; }
        // 営業担当者名
        @AuraEnabled public String 	salesperson_nm	{ get; set; }
        // 契約プランコード
        @AuraEnabled public String 	plan_cd	{ get; set; }
        // 契約プラン名称
        @AuraEnabled public String 	plan_nm	{ get; set; }
        // 料金３部制区分
        @AuraEnabled public String 	charge_3_kbn	{ get; set; }
        // 支払方法コード
        @AuraEnabled public String 	payment_cd	{ get; set; }
        // 支払方法
        @AuraEnabled public String 	payment_nm	{ get; set; }
        // 申込書受領日
        @AuraEnabled public String 	receipt_dt	{ get; set; }
        // 契約成立日
        @AuraEnabled public String 	contract_dt	{ get; set; }
        // お知らせ発行日
        @AuraEnabled public String 	oshirase_dt	{ get; set; }
        // 供給開始予定日
        @AuraEnabled public String 	supply_dt	{ get; set; }
        // 解約日
        @AuraEnabled public String 	cancel_dt	{ get; set; }
        // 閉栓処理日
        @AuraEnabled public String 	close_dt	{ get; set; }
        // 支払者名称(漢字)
        @AuraEnabled public String 	p_customer_nm	{ get; set; }
        // 支払者名称(カナ)
        @AuraEnabled public String 	p_customer_nm_k	{ get; set; }
        // 支払者電話番号
        @AuraEnabled public String 	p_tel_no	{ get; set; }
        // 支払者郵便番号
        @AuraEnabled public String 	p_postal_cd	{ get; set; }
        // 支払者住所
        @AuraEnabled public String 	p_address	{ get; set; }
        // 支払者住所予備
        @AuraEnabled public String 	p_address_sub	{ get; set; }
        // 申込取消
        @AuraEnabled public String 	contract_cancel	{ get; set; }
        //private OutsideTheAreaContractResponseDto responseContractDto{ get; set; }
    }

    /**
     * タイムアウト、リトライ、ログ出力など設定
     * */
    public override void setApiCustomerInfo() {
        // APIリクエストタイプ
        apiRequestType = 'OutsideTheAreaContractApi';
        // 環境変数APIタイプ
        envApiRequestType = CommonConstantsUtil.API_TYPE_OUTSIDETHEAREA;
        // API通信エラーメッセージ
        message = this.messageHeader;
        // クラス名
        className = 'CommonOutsideTheAreaContractApi';
    }
	
    /*
     * APIレスポンス結果Dtoクラス
    public class OutsideTheAreaContractResponseDto {
        // お客さま番号
        @AuraEnabled public String 	customer_cd	{ get; set; }
        // 名前(漢字)
        @AuraEnabled public String 	customer_nm	{ get; set; }
        // 名前(カナ)
        @AuraEnabled public String 	customer_nm_k	{ get; set; }
        // 電話番号
        @AuraEnabled public String 	tel_no	{ get; set; }
        // 携帯番号
        @AuraEnabled public String 	mobile_no	{ get; set; }
        // 郵便番号
        @AuraEnabled public String 	postal_cd	{ get; set; }
        // 住所
        @AuraEnabled public String 	address	{ get; set; }
        // 住所予備
        @AuraEnabled public String 	address_sub	{ get; set; }
        // 供給地点特定番号
        @AuraEnabled public String 	kyokyu_no	{ get; set; }
        // ガス導管網エリア
        @AuraEnabled public String 	gas_area	{ get; set; }
        // 基準検針日
        @AuraEnabled public String 	stand_mr	{ get; set; }
        // 総合設定
        @AuraEnabled public String 	sougou	{ get; set; }
        // 形態コード
        @AuraEnabled public String 	keitai_cd	{ get; set; }
        // 形態名称
        @AuraEnabled public String 	keitai_nm	{ get; set; }
        // 営業担当者名
        @AuraEnabled public String 	salesperson_nm	{ get; set; }
        // 契約プランコード
        @AuraEnabled public String 	plan_cd	{ get; set; }
        // 契約プラン名称
        @AuraEnabled public String 	plan_nm	{ get; set; }
        // 料金３部制区分
        @AuraEnabled public String 	charge_3_kbn	{ get; set; }
        // 支払方法コード
        @AuraEnabled public String 	payment_cd	{ get; set; }
        // 支払方法
        @AuraEnabled public String 	payment_nm	{ get; set; }
        // 申込書受領日
        @AuraEnabled public String 	receipt_dt	{ get; set; }
        // 契約成立日
        @AuraEnabled public String 	contract_dt	{ get; set; }
        // お知らせ発行日
        @AuraEnabled public String 	oshirase_dt	{ get; set; }
        // 供給開始予定日
        @AuraEnabled public String 	supply_dt	{ get; set; }
        // 解約日
        @AuraEnabled public String 	cancel_dt	{ get; set; }
        // 閉栓処理日
        @AuraEnabled public String 	close_dt	{ get; set; }
        // 支払者名称(漢字)
        @AuraEnabled public String 	p_customer_nm	{ get; set; }
        // 支払者名称(カナ)
        @AuraEnabled public String 	p_customer_nm_k	{ get; set; }
        // 支払者電話番号
        @AuraEnabled public String 	p_tel_no	{ get; set; }
        // 支払者郵便番号
        @AuraEnabled public String 	p_postal_cd	{ get; set; }
        // 支払者住所
        @AuraEnabled public String 	p_address	{ get; set; }
        // 支払者住所予備
        @AuraEnabled public String 	p_address_sub	{ get; set; }
        // 申込取消
        @AuraEnabled public String 	contract_cancel	{ get; set; }
    }
     */
}