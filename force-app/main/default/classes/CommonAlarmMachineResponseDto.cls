public with sharing class CommonAlarmMachineResponseDto {
   @AuraEnabled public String kikiSts { get; set; }
   @AuraEnabled public String tritukeYmd      { get; set; }
   @AuraEnabled public String tritukeNwKsyNm  { get; set; }
   @AuraEnabled public String trihazsiYmd     { get; set; }
   @AuraEnabled public String trihazsiNwKsyNm { get; set; }
   @AuraEnabled public String kehokiHinmeiBrandCd     { get; set; }
   @AuraEnabled public String makerCdDcd      { get; set; }
   @AuraEnabled public String tosyoTritukeYmd { get; set; }
   @AuraEnabled public String manryoYoteiYmd  { get; set; }
   @AuraEnabled public String kehokiSeinoHsyYmd       { get; set; }
   @AuraEnabled public String furyohinTrkKais { get; set; }
   @AuraEnabled public String manryoTrkCystYmd        { get; set; }
   @AuraEnabled public String manryoTrkNwKsyNm        { get; set; }
   @AuraEnabled public String manryoDmSign    { get; set; }
   @AuraEnabled public String manryoDmYouhiCdDcd      { get; set; }
   @AuraEnabled public String manryoTrkCystUmCdDcd    { get; set; }
   @AuraEnabled public String seizoNo { get; set; }
   @AuraEnabled public String shrKbnCdDcd     { get; set; }
   @AuraEnabled public String zenkKikiId     { get; set; }
   @AuraEnabled public String gmtSetNo     { get; set; }

   public CommonAlarmMachineResponseDto()
   {
   }

   public CommonAlarmMachineResponseDto(String kikiSts
                                        , String tritukeYmd, String tritukeNwKsyNm
                                        , String trihazsiYmd
                                        , String trihazsiNwKsyNm
                                        , String kehokiHinmeiBrandCd
                                        , String makerCdDcd
                                        , String tosyoTritukeYmd
                                        , String manryoYoteiYmd
                                        , String kehokiSeinoHsyYmd
                                        , String furyohinTrkKais
                                        , String manryoTrkCystYmd
                                        , String manryoTrkNwKsyNm
                                        , String manryoDmSign
                                        , String manryoDmYouhiCdDcd
                                        , String manryoTrkCystUmCdDcd
                                        , String seizoNo
                                        , String shrKbnCdDcd
                                        , String zenkKikiId
                                        , String gmtSetNo)
   {
      this.kikiSts              = kikiSts;
      this.tritukeYmd           = tritukeYmd;
      this.tritukeNwKsyNm       = tritukeNwKsyNm;
      this.trihazsiYmd          = trihazsiYmd;
      this.trihazsiNwKsyNm      = trihazsiNwKsyNm;
      this.kehokiHinmeiBrandCd  = kehokiHinmeiBrandCd;
      this.makerCdDcd           = makerCdDcd;
      this.tosyoTritukeYmd      = tosyoTritukeYmd;
      this.manryoYoteiYmd       = manryoYoteiYmd;
      this.kehokiSeinoHsyYmd    = kehokiSeinoHsyYmd;
      this.furyohinTrkKais      = furyohinTrkKais;
      this.manryoTrkCystYmd     = manryoTrkCystYmd;
      this.manryoTrkNwKsyNm     = manryoTrkNwKsyNm;
      this.manryoDmSign         = manryoDmSign;
      this.manryoDmYouhiCdDcd   = manryoDmYouhiCdDcd;
      this.manryoTrkCystUmCdDcd = manryoTrkCystUmCdDcd;
      this.seizoNo              = seizoNo;
      this.shrKbnCdDcd          = shrKbnCdDcd;
      this.zenkKikiId           = zenkKikiId;
      this.gmtSetNo             = gmtSetNo;
   }
}