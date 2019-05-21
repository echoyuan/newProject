/**
 * [域外]契約情報APIレスポンスDto
 */
public with sharing class CommonOutsideTheAreaContractResponseDto {
    // お客さま番号		
    @AuraEnabled public String 	customerCd	{ get; set; }
    // 名前(漢字)		
    @AuraEnabled public String 	customerNm	{ get; set; }
    // 名前(カナ)		
    @AuraEnabled public String 	customerNmK	{ get; set; }
    // 電話番号(トリブル：電話番号に電話番号、携帯番号を改行で設定用)
    @AuraEnabled public String 	telNos	{ get; set; }
    // 電話番号		
    @AuraEnabled public String 	telNo	{ get; set; }
    // 携帯番号		
    @AuraEnabled public String 	mobileNo	{ get; set; }
    // 郵便番号		
    @AuraEnabled public String 	postalCd	{ get; set; }
    // 住所(表示用)
    @AuraEnabled public String 	addressDisplay	{ get; set; }
    // 住所		
    @AuraEnabled public String 	address	{ get; set; }
    // 住所予備		
    @AuraEnabled public String 	addressSub	{ get; set; }
    // 供給地点特定番号		
    @AuraEnabled public String 	kyokyuNo	{ get; set; }
    // 供給状態
    @AuraEnabled public String 	kyokyuStatus	{ get; set; }
    // ガス導管網エリア		
    @AuraEnabled public String 	gasArea	{ get; set; }
    // 基準検針日		
    @AuraEnabled public String 	standMr	{ get; set; }
    // 総合設定		
    @AuraEnabled public String 	sougou	{ get; set; }
    // 形態コード		
    @AuraEnabled public String 	keitaiCd	{ get; set; }
    // 形態名称		
    @AuraEnabled public String 	keitaiNm	{ get; set; }
    // 営業担当者名		
    @AuraEnabled public String 	salespersonNm	{ get; set; }
    // 契約プランコード		
    @AuraEnabled public String 	planCd	{ get; set; }
    // 契約プラン名称		
    @AuraEnabled public String 	planNm	{ get; set; }
    // 料金３部制区分		
    @AuraEnabled public String 	charge3Kbn	{ get; set; }
    // 支払方法コード		
    @AuraEnabled public String 	paymentCd	{ get; set; }
    // 支払方法		
    @AuraEnabled public String 	paymentNm	{ get; set; }
    // 申込書受領日		
    @AuraEnabled public String 	receiptDt	{ get; set; }
    // 契約成立日		
    @AuraEnabled public String 	contractDt	{ get; set; }
    // お知らせ発行日		
    @AuraEnabled public String 	oshiraseDt	{ get; set; }
    // 供給開始予定日		
    @AuraEnabled public String 	supplyDt	{ get; set; }
    // 解約日		
    @AuraEnabled public String 	cancelDt	{ get; set; }
    // 閉栓処理日		
    @AuraEnabled public String 	closeDt	{ get; set; }
    // 支払者名称(漢字)		
    @AuraEnabled public String 	pCustomerNm	{ get; set; }
    // 支払者名称(カナ)		
    @AuraEnabled public String 	pCustomerNmK	{ get; set; }
    // 支払者電話番号		
    @AuraEnabled public String 	pTelNo	{ get; set; }
    // 支払者郵便番号		
    @AuraEnabled public String 	pPostalCd	{ get; set; }
    // 支払者住所		
    @AuraEnabled public String 	pAddress	{ get; set; }
    // 支払者住所予備		
    @AuraEnabled public String 	pAddressSub	{ get; set; }
    // 申込取消		
    @AuraEnabled public String 	contractCancel	{ get; set; }
    
    public CommonOutsideTheAreaContractResponseDto() {
    }
}