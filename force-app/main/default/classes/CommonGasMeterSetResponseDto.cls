public without sharing class CommonGasMeterSetResponseDto {
    // PKガスメータ設置場所/番号
    @AuraEnabled public String gmtSetNo { get; set; }
    // ガス/使用契約/番号
    @AuraEnabled public String syokyNo { get; set; }
    // PK社番/番号
    @AuraEnabled public String syabanNo { get; set; }
    // PK社番通し/番号
    @AuraEnabled public String syabanSeqNo { get; set; }
    // ガスメータ取付/年月日
    @AuraEnabled public String gmtTritukeYmd { get; set; }
    // ガスメータ取外/年月日
    @AuraEnabled public String gmtTrihazsYmd { get; set; }
    // PK適用開始/年月日
    @AuraEnabled public String startYmd { get; set; }
    // 適用終了/年月日
    @AuraEnabled public String endYmd { get; set; }
    // 開栓/年月日
    @AuraEnabled public String ksenYmd { get; set; }
    // 閉栓/年月日
    @AuraEnabled public String hsenYmd { get; set; }
    // 棟番/カナ
    @AuraEnabled public String munebanKn { get; set; }
    // 部屋番/カナ
    @AuraEnabled public String heyabanKn { get; set; }
    // 往訪時目標/漢字
    @AuraEnabled public String ohojiMokhyoKj { get; set; }
    // ガスメータ開閉栓状態/コード
    @AuraEnabled public String gmtKhsenJtCd { get; set; }
    // ガスメータ開閉栓状態/コード(デコード)
    @AuraEnabled public String gmtKhsenJtCdDcd { get; set; }
    // 供内管・メータ設備状態/コード
    @AuraEnabled public String kynGmtSeJCd { get; set; }
    // 供内管・メータ設備状態/コード(デコード)
    @AuraEnabled public String kynGmtSeJCdDcd { get; set; }
    // ガスメータ型式記号/コード
    @AuraEnabled public String gmtKataKigCd { get; set; }
    // ガスメータ型式記号/コード(デコード)
    @AuraEnabled public String gmtKataKigCdDcd { get; set; }
    // ガスメータ号数/流量
    @AuraEnabled public String gmtGoSu { get; set; }
    // ＧＨＰメータ設置/コード
    @AuraEnabled public String ghpGmtSetCd { get; set; }
    // ＧＨＰメータ設置/コード(デコード)
    @AuraEnabled public String ghpGmtSetCdDcd { get; set; }
    // ガスメータ取付位置/コード
    @AuraEnabled public String gmtTrtItiCd { get; set; }
    // ガスメータ取付位置/コード(デコード)
    @AuraEnabled public String gmtTrtItiCdDcd { get; set; }
    // 閉栓手段/コード
    @AuraEnabled public String hsenSydnCd { get; set; }
    // 閉栓手段/コード(デコード)
    @AuraEnabled public String hsenSydnCdDcd { get; set; }
    // メータ状態
    @AuraEnabled public String gmtStatus { get; set; }


    public CommonGasMeterSetResponseDto() {
        
    }  
}