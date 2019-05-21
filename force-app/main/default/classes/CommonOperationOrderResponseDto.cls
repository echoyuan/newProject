/**
 * [電力]指図情報APIレスポンスDto
 */
public with sharing class CommonOperationOrderResponseDto {
    // 電力契約番号		
    @AuraEnabled public String 	saId	{ get; set; }
    // お客さま登録番号		
    @AuraEnabled public String 	x3X	{ get; set; }
    // 指図番号		
    @AuraEnabled public String 	xOperationOrderId	{ get; set; }
    // 指図タイプ		
    @AuraEnabled public String 	xOoTypeCd	{ get; set; }
    // 指図タイプ(デコード)		
    @AuraEnabled public String 	xOoTypeCdLabel	{ get; set; }
    // 受付日		
    @AuraEnabled public String 	xRegistrationDt	{ get; set; }
    // 担当箇所		
    @AuraEnabled public String 	dispGrpCd	{ get; set; }
    // 担当箇所(デコード)		
    @AuraEnabled public String 	dispGrpCdLabel	{ get; set; }
    // 作業希望日		
    @AuraEnabled public String 	xPreffredDt	{ get; set; }
    // 作業希望時間帯		
    @AuraEnabled public String 	xTimeZone	{ get; set; }
    // 作業希望時間帯(デコード)		
    @AuraEnabled public String 	xTimeZoneLabel	{ get; set; }
    // 作業予定日		
    @AuraEnabled public String 	xSchedDt	{ get; set; }
    // 現場作業完了日		
    @AuraEnabled public String 	xFieldWorkDt	{ get; set; }
    // ステータス		
    @AuraEnabled public String 	xOoStatusFlg	{ get; set; }
    // ステータス(デコード)		
    @AuraEnabled public String 	xOoStatusFlgLabel	{ get; set; }
    // サブステータス		
    @AuraEnabled public String 	xOoSubStatusFlg	{ get; set; }
    // サブステータス(デコード)		
    @AuraEnabled public String 	xOoSubStatusFlgLabel	{ get; set; }
    // 接客者		
    @AuraEnabled public String 	xPersonInService	{ get; set; }
    // 使用開始理由		
    @AuraEnabled public String 	xStartReason	{ get; set; }
    // 使用開始理由(デコード)		
    @AuraEnabled public String 	xStartReasonLabel	{ get; set; }
    // 使用中止理由		
    @AuraEnabled public String 	xStopReason	{ get; set; }
    // 使用中止理由(デコード)		
    @AuraEnabled public String 	xStopReasonLabel	{ get; set; }
    // 申込日		
    @AuraEnabled public String 	xApplicationDt	{ get; set; }
    // 申出人＿関係者種別		
    @AuraEnabled public String 	xOrderConcernedCat	{ get; set; }
    // 申出人＿関係者種別(デコード)		
    @AuraEnabled public String 	xOrderConcernedCatLabel	{ get; set; }
    // 申出人＿おなまえ		
    @AuraEnabled public String 	xOrderName	{ get; set; }
    // 申出人＿連絡先		
    @AuraEnabled public String 	xOrderPhone	{ get; set; }
    // 代行受付箇所		
    @AuraEnabled public String 	xLifevalNwCd	{ get; set; }
    // 料金メニュー		
    @AuraEnabled public String 	rsCd	{ get; set; }
    // 料金メニュー(デコード)		
    @AuraEnabled public String 	rsCdLabel	{ get; set; }
    // 契約電流		
    @AuraEnabled public String 	xContractCur	{ get; set; }
    // 契約容量		
    @AuraEnabled public String 	xContractCap	{ get; set; }
    // 契約電力		
    @AuraEnabled public String 	xContractOp	{ get; set; }
    // 契約タイプ		
    @AuraEnabled public String 	saTypeCd	{ get; set; }
    // 契約タイプ(デコード)		
    @AuraEnabled public String 	saTypeCdLabel	{ get; set; }
    // 更新日時
    @AuraEnabled public String 	xUpdDttm	{ get; set; }
    // エラーコード		
    @AuraEnabled public String	code	{ get; set; }
    // エラーメッセージ		
    @AuraEnabled public String 	message	{ get; set; }
    
    public CommonOperationOrderResponseDto(){
        
    }
}