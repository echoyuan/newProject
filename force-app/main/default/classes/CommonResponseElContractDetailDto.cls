public class CommonResponseElContractDetailDto {
    
    // お客さま登録番号
    @AuraEnabled public String x3x { get; set; }
    // お客さま番号
    //@AuraEnabled public String x3x { get; set; }
    // ガス使用契約番号(4(x))
    @AuraEnabled
    public String xGas4x { get; set; }
    // 電力使用契約番号(他シス4(x))
    @AuraEnabled public String xEl4x { get; set; }
    // カスタマ番号(8(x))    
    @AuraEnabled public String x8x { get; set; }
    // 電力契約番号    
    @AuraEnabled public String saId　{ get; set; }
    // 供給地点特定番号    
    @AuraEnabled public String xSupplyPointId { get; set; }
    // お客さま名    
    @AuraEnabled public String xPerName { get; set; }    
    // お客さま名(カナ)
    @AuraEnabled public String xPerNameXana { get; set; }
    // 店名・屋号等   
    @AuraEnabled public String xShopName { get; set; }
    // 店名・屋号等(カナ)    
    @AuraEnabled public String xShopNameKana { get; set; }
    //住所
    @AuraEnabled public String address1 { get; set; }
    // 住所(建物名)    
    @AuraEnabled public String address2 { get; set; }
    // 住所(棟番)
    @AuraEnabled public String num1 { get; set; }
    // 住所(部屋番号)   
    @AuraEnabled public String address4 { get; set; }
    // 電話種別    
    @AuraEnabled public String xPhoneCatLabel { get; set; }
    // 電話種別(デコード)    
    @AuraEnabled public String xPhoneCat { get; set; }
    // 連絡先種別    
    @AuraEnabled public String xContactCatLabel { get; set; }
    // 連絡先種別(デコード)    
    @AuraEnabled public String xContactCat { get; set; }
    // 電話番号   
    @AuraEnabled public String phone { get; set; }
    // 確認状態    
    @AuraEnabled public String xPhoneCheckCdLabel { get; set; }
    // 確認状態(デコード)    
    @AuraEnabled public String xPhoneCheckCd { get; set; }
    // 支払方法   
    @AuraEnabled public String xPayMethodLabel { get; set; }
    // 支払方法(デコード)    
    @AuraEnabled public String xPayMethod { get; set; }
    // 基本検針日    
    @AuraEnabled public String xBasicMrDt { get; set; }   
    // 適用日
    @AuraEnabled public String xBasicXrDt { get; set; }
    // 料金メニュー
    @AuraEnabled public String rsCdLabel { get; set; }
    // 料金メニュー(デコード)
    @AuraEnabled public String rsCd { get; set; }
    // 契約電流
    @AuraEnabled public String xContractCur { get; set; }
    // 契約容量
    @AuraEnabled public String xContractCap { get; set; }
    // 契約電力    
    @AuraEnabled public String xContractOp { get; set; }   
    // パック割適用区分
    @AuraEnabled public String val { get; set; }
    // パック割適用開始日
    @AuraEnabled public String startDt { get; set; }
    // パック割適用終了日
    @AuraEnabled public String endDt { get; set; }
    // 期間限定割種別
    @AuraEnabled public String xLimitedCp { get; set; }
    // 期間限定割適用開始日
    @AuraEnabled public String xLimitedCpStartDt { get; set; }
    // 期間限定割適用終了日
    @AuraEnabled public String xLimitedCpEndDt { get; set; }   
    // 指図番号
    @AuraEnabled public String xOperationOrderId { get; set; }
    // 指図タイプ
    @AuraEnabled public String xOoTypeCd { get; set; }
    // ステータス
    @AuraEnabled public String xOoStatusFlgLabel { get; set; }
    // 担当箇所
    @AuraEnabled public String dispGrpCd { get; set; }
    // 作業希望日
    @AuraEnabled public String xPreffredDt { get; set; }
    // 作業予定日
    @AuraEnabled public String xSchedDt { get; set; }
    // 電力契約番号
    //@AuraEnabled public String saId { get; set; }
    // 支払者電力契約番号
    //@AuraEnabled public String saId { get; set; }
    // 支払者契約タイプ(デコード)
    @AuraEnabled public String saTypeCd { get; set; }
    // 支払者支払方法
    //@AuraEnabled public String xPayMethodLabel { get; set; }
    // 支払者支払方法(デコード)
    //@AuraEnabled public String xPayMethod { get; set; }
    // 4x(ガス使用契約番号)
    //@AuraEnabled public String xGas4x { get; set; }
    // 3x(域外ガスお客さま番号)
    //@AuraEnabled public String xEl4x { get; set; }
    
    public CommonResponseElContractDetailDto() {
    }
}