public without sharing class CommonGasContractResponseDto {
    // お客さま番号
    @AuraEnabled public String syokyNo { get; set; }
    // 内容有効開始/年月日
    @AuraEnabled public String effctYmd { get; set; }
    // 内容有効期限/年月日
    @AuraEnabled public String limitYmd { get; set; }
    // ガス料金契約種別/コード
    @AuraEnabled public String gasKySybCd { get; set; }
    // ガス料金契約種別/コード(デコード)
    @AuraEnabled public String gasKySybCdDcd { get; set; }
    // 福祉/コード
    @AuraEnabled public String fukusiCd { get; set; }
    // 福祉/コード(デコード)
    @AuraEnabled public String fukusiCdDcd { get; set; }
    // ガス料金金額指定報告/コード
    @AuraEnabled public String gasRknKgshCd { get; set; }
    // ガス料金金額指定報告/コード(デコード)
    @AuraEnabled public String gasRknKgshCdDcd { get; set; }
    // 総合扱いガスメータ/数
    @AuraEnabled public String sogoAtkGmtSu { get; set; }
    // 臨時精算事由/コード
    @AuraEnabled public String rnjSesnJiyCd { get; set; }
    // 臨時精算事由/コード(デコード)
    @AuraEnabled public String rnjSesnJiyCdDcd { get; set; }
    // 使用者/お客さま登録/番号
    @AuraEnabled public String userCstRegNo { get; set; }
    // 支払契約/番号
    @AuraEnabled public String shrkyNo { get; set; }
    // ガス料金契約種別
    @AuraEnabled public String gasKySyb { get; set; }

    /*public CommonGasContractResponseDto(String syokyNo, String effctYmd, String limitYmd, String gasKySybCd,
            String gasKySybCdDcd, String fukusiCd, String fukusiCdDcd, String gasRknKgshCd, String gasRknKgshCdDcd,
            String sogoAtkGmtSu, String rnjSesnJiyCd, String rnjSesnJiyCdDcd, String userCstRegNo, String shrkyNo,
            String gasKySyb) {
        this.syokyNo = syokyNo;
        this.effctYmd = effctYmd;
        this.limitYmd = limitYmd;
        this.gasKySybCd = gasKySybCd;
        this.gasKySybCdDcd = gasKySybCdDcd;
        this.fukusiCd = fukusiCd;
        this.fukusiCdDcd = fukusiCdDcd;
        this.gasRknKgshCd = gasRknKgshCd;
        this.gasRknKgshCdDcd = gasRknKgshCdDcd;
        this.sogoAtkGmtSu = sogoAtkGmtSu;
        this.rnjSesnJiyCd = rnjSesnJiyCd;
        this.rnjSesnJiyCdDcd = rnjSesnJiyCdDcd;
        this.userCstRegNo = userCstRegNo;
        this.shrkyNo = shrkyNo;
        this.gasKySyb = gasKySyb;
    }*/
    public CommonGasContractResponseDto() {
        
    }
}