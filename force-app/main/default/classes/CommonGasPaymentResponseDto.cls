public without sharing class CommonGasPaymentResponseDto {
    // お客さま番号
    @AuraEnabled public String shrkyNo { get; set; }
    // 内容有効開始/年月日
    @AuraEnabled public String effctYmd { get; set; }
    // 内容有効期限/年月日
    @AuraEnabled public String limitYmd { get; set; }
    // 料金支払方法/コード
    @AuraEnabled public String rknShrHohCd { get; set; }
    // 料金支払方法/コード(デコード)
    @AuraEnabled public String rknShrHohCdDcd { get; set; }
    // 支払指定日識別/コード
    @AuraEnabled public String shrStDdSbCd { get; set; }
    // 支払指定日識別/コード(デコード)
    @AuraEnabled public String shrStDdSbCdDcd { get; set; }
    // 支払指定/日
    @AuraEnabled public String shrStDd { get; set; }
    // 金融機関/コード
    @AuraEnabled public String bnkCd { get; set; }
    // 金融機関名称
    @AuraEnabled public String kiKinyunmg { get; set; }
    // 支店名称
    @AuraEnabled public String kiSitennmg { get; set; }
    // 預金種別/コード
    @AuraEnabled public String yokinSybCd { get; set; }
    // 預金種別/コード(デコード)
    @AuraEnabled public String yokinSybCdDcd { get; set; }
    // お客さま口座/番号
    @AuraEnabled public String cstKozaNo { get; set; }
    // 支払者/お客さま登録/番号
    @AuraEnabled public String shrsCstRegNo { get; set; }
    // 請求サービス/コード
    @AuraEnabled public String seiqSvcCd { get; set; }
    // 請求サービス/コード(デコード)
    @AuraEnabled public String seiqSvcCdDcd { get; set; }
    // 振替指定日
    @AuraEnabled public String transferDate { get; set; }

    public CommonGasPaymentResponseDto() {

    }
}