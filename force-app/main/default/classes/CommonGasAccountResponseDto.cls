public without sharing class CommonGasAccountResponseDto {
    // お客さま登録/番号
    @AuraEnabled public String cstRegNo { get; set; }
    // 店名・屋号
    @AuraEnabled public String tenNamYagoKj { get; set; }
    // 店名・屋号/カナ
    @AuraEnabled public String tenNamYagoKn { get; set; }
    // おなまえ
    @AuraEnabled public String namKj { get; set; }
    // おなまえ/カナ
    @AuraEnabled public String namKn { get; set; }
    // 住所
    @AuraEnabled public String jusyo { get; set; }
    // 郵便/番号
    @AuraEnabled public String yubinNo { get; set; }
    // お客さま電話/番号
    @AuraEnabled public String cstTelNo { get; set; }
    // 電話種別/コード(デコード)
    @AuraEnabled public String telSybCdDcd { get; set; }
    // 電話連絡先種別/コード(デコード)
    @AuraEnabled public String telRrksSybCdDcd { get; set; }
    // コード
    @AuraEnabled public Integer code { get; set; }
    // 結果
    @AuraEnabled public String result { get; set; }
    // メッセージ
    @AuraEnabled public String message { get; set; }

    public CommonGasAccountResponseDto() {
    }
    
    public CommonGasAccountResponseDto(String cstRegNo, String tenNamYagoKj, String tenNamYagoKn, String namKj,
            String namKn, String jusyo, String yubinNo, String cstTelNo, String telSybCdDcd,
            String telRrksSybCdDcd, Integer code, String result, String message) {
        
        this.cstRegNo = cstRegNo;
        this.tenNamYagoKj = tenNamYagoKj;
        this.tenNamYagoKn = tenNamYagoKn;
        this.namKj = namKj;
        this.namKn = namKn;
        this.jusyo = jusyo;
        this.yubinNo = yubinNo;
        this.cstTelNo = cstTelNo;
        this.telSybCdDcd = telSybCdDcd;
        this.telRrksSybCdDcd = telRrksSybCdDcd;
        this.code = code;
        this.result = result;
        this.message = message;
    }

}