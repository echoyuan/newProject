public without sharing class CommonGasReceiveHistoryResponseDto implements Comparable {
    // お客さま番号
    @AuraEnabled public String cstRegNo { get; set; }
    // 接客/年月日
    @AuraEnabled public String skkYmd { get; set; }
    // 接客/時刻
    @AuraEnabled public String skkJkk { get; set; }
    // 業務詳細区分/コード
    @AuraEnabled public String gymSysikbnCd { get; set; }
    // 業務詳細区分/コード(デコード)
    @AuraEnabled public String gymSysikbnCdDcd { get; set; }
    // 業務内容識別/コード
    @AuraEnabled public String gymNyoSybtCd { get; set; }
    // 業務内容識別/コード(デコード)
    @AuraEnabled public String gymNyoSybtCdDcd { get; set; }
    // 作業予定・実施/年月日
    @AuraEnabled public String sgyoyoteJsYmd { get; set; }
    // 作業予定時間帯/コード
    @AuraEnabled public String sgyoyoteJktCd { get; set; }
    // 作業予定時間帯/コード(デコード)
    @AuraEnabled public String sgyoyoteJktCdDcd { get; set; }
    // 作業予定時刻/コード
    @AuraEnabled public String sgyYteJkkCd { get; set; }
    // 作業予定時刻/コード(デコード)
    @AuraEnabled public String sgyYteJkkCdDcd { get; set; }
    // 作業担当箇所/漢字
    @AuraEnabled public String sgyoTntksyKj { get; set; }
    // 接客担当者氏名/漢字
    @AuraEnabled public String systntnamKj { get; set; }
    // 特記事項/説明
    @AuraEnabled public String tokkiJiko { get; set; }
    // 時間帯
    @AuraEnabled public String jkt { get; set; }
    
    public CommonGasReceiveHistoryResponseDto() {
    }
    
    public Integer compareTo(Object compareTo) {
        CommonGasReceiveHistoryResponseDto compareToHistory = (CommonGasReceiveHistoryResponseDto)compareTo;
        Integer returnValue = 0;
        if (skkYmd > compareToHistory.skkYmd) {
            returnValue = -1;
        } else if (skkYmd < compareToHistory.skkYmd) {
            returnValue = 1;
        }
        return returnValue;       
    }
}