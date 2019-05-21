public without sharing class CommonGasSpecialResponseDto {
    // 表示用お客さま番号
    @AuraEnabled public String cstNo { get; set; }
    // お客さま番号（1x）
    @AuraEnabled public String gmtSetNo { get; set; }
    // お客さま番号（2x）
    @AuraEnabled public String shrkyNo { get; set; }
    // お客さま番号（3x）
    @AuraEnabled public String cstRegNo { get; set; }
    // お客さま番号（4x）
    @AuraEnabled public String syokyNo { get; set; }

    public CommonGasSpecialResponseDto(String cstNo, String gmtSetNo, String shrkyNo, String cstRegNo, String syokyNo) {
        this.cstNo = cstNo;
        this.gmtSetNo = gmtSetNo;
        this.shrkyNo = shrkyNo;
        this.cstRegNo = cstRegNo;
        this.syokyNo = syokyNo;
    }

}