public without sharing class CommonGasElectricAddPatternResponseDto {
    // お客さま番号
    @AuraEnabled public String syokyNo { get; set; }
    // 他システム使用契約特定結果
    @AuraEnabled public String tasyskyExist { get; set; }
    // 電気料金合算パターン/コード
    @AuraEnabled public String dgsnptnExist { get; set; }
    // 電気料金合算パターン/コード（デコード）
    @AuraEnabled public String electricAddPattern { get; set; }
    // 電力合算
    @AuraEnabled public String electricAdd { get; set; }
    
    public CommonGasElectricAddPatternResponseDto(String syokyNo, String tasyskyExist, String dgsnptnExist,
            String electricAddPattern, String electricAdd) {
        this.syokyNo = syokyNo;
        this.tasyskyExist = tasyskyExist;
        this.dgsnptnExist = dgsnptnExist;
        this.electricAddPattern = electricAddPattern;
        this.electricAdd = electricAdd;
    }

}