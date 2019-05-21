public without sharing class CommonGasMeterResponseDto implements Comparable {
	// お客さま番号（1x）
    @AuraEnabled public String gmtSetNo { get; set; }
    // ガス/使用契約/番号（4x）
    @AuraEnabled public String gasSyokyNo { get; set; }
    // メータ状態
    @AuraEnabled public String gmtStates { get; set; }
    // メータ作業日タイトル
    @AuraEnabled public String gmtYmdTitle { get; set; }
    // メータ作業日
    @AuraEnabled public String gmtYmd { get; set; }
    // メータ状態事由
    @AuraEnabled public String gmtStatesJiy { get; set; }
    // メータ状態事由
    @AuraEnabled public String gmtStatesStr { get; set; }
    
    
	public CommonGasMeterResponseDto(String gmtSetNo, String gasSyokyNo, String gmtStates, String gmtYmdTitle,
            String gmtYmd, String gmtStatesJiy) {
        this.gmtSetNo = gmtSetNo;
        this.gasSyokyNo = gasSyokyNo;
        this.gmtStates = gmtStates;
        this.gmtYmdTitle = gmtYmdTitle;
        this.gmtYmd = gmtYmd;
        this.gmtStatesJiy = gmtStatesJiy;
    }
    
    public Integer compareTo(Object compareTo) {
        CommonGasMeterResponseDto compareToGasMeter = (CommonGasMeterResponseDto)compareTo;
        Integer returnValue = 0;
        if (gmtSetNo > compareToGasMeter.gmtSetNo) {
            returnValue = 1;
        } else if (gmtSetNo < compareToGasMeter.gmtSetNo) {
            returnValue = -1;
        }
        return returnValue;       
    }
     
}