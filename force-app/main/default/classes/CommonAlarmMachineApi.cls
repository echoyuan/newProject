public with sharing class CommonAlarmMachineApi {
   private Integer statusCode;
   private String errorCode      = null;
   private String errorMessage   = null;
   private HttpRequest request   = null;
   private HttpResponse response = null;

   /** 基盤Apiパス */
   private static final String CONTRACT_BASE_URL = 'https://tgcrm-acp-api.azure-api.net/test';
   /** Apiパス */
   private static final String CONTRACT_SUB_URL = '/keihoukis';
   /** セキュリティToken */
   private static final String CONTRACT_SECURITY_KEY = '219f7e405cbc4adf949c066b8dca5b00';
   /** 機器ID */
   private static final String KIKI_ID = 'kiki_id';
   /** 契約ID */
   private static final String KY_ID = 'ky_id';
   /** LIMIT */
   private static final String LIMIT_TXT = 'limit';
   /** OFFSET */
   private static final String OFFSET = 'offset';


   public HttpRequest getRequest()
   {
      return(request);
   }

   public String getErrorMessage()
   {
      return(errorMessage);
   }

   public CommonAlarmMachineApi(String kikiId, String kyId)
   {
      request = new HttpRequest();
      setRequestInfo(kikiId, kyId);
   }

   /**
    * リクエストの設定
    *
    * @param dataType　
    *       リクエストタイプ
    * @param endPoint　
    *       URL
    * @param securityKey　
    *       セキュリティToken
    * */
   public void setRequestInfo(String kikiId, String kyId)
   {
      request.setHeader('Content-Length', '0');
      request.setMethod(ConstantsUtil.GET);
      String limittxt  = ConstantsUtil.AND_MARK + LIMIT_TXT + ConstantsUtil.EQUAL_MARK + 20;
      String offsettxt = ConstantsUtil.AND_MARK + OFFSET + ConstantsUtil.EQUAL_MARK + 0;
      if (kikiId != null)
      {
         request.setEndpoint(CONTRACT_BASE_URL + CONTRACT_SUB_URL + ConstantsUtil.QUERY_MARK + KIKI_ID
                             + ConstantsUtil.EQUAL_MARK + kikiId + limittxt + offsettxt);
      }
      if (kyId != null)
      {
         request.setEndpoint(CONTRACT_BASE_URL + CONTRACT_SUB_URL + ConstantsUtil.QUERY_MARK + KY_ID
                             + ConstantsUtil.EQUAL_MARK + kyId + limittxt + offsettxt);
      }
      request.setHeader('Content-type', 'application/json; charset=utf-8');
      request.setHeader('Ocp-Apim-Subscription-Key', CONTRACT_SECURITY_KEY);
   }

   /**
    * リクエストの発送
    *
    * @param requestInput　
    *       発送されるリクエスト
    * */
   public void send()
   {
      Http http = new Http();

      response = http.send(request);
      System.debug(Logginglevel.INFO, 'response code:' + response.getStatusCode());
      System.debug(Logginglevel.INFO, 'response body:' + response.getBody());
   }

   /**
    * 契約詳細情報の取得
    *
    * @return 　
    *       契約詳細情報を戻る
    * */
   public List <CommonAlarmMachineResponseDto> getKhKikiInfo()
   {
      // レスポンス戻る値が異常の場合
      if (response.getStatusCode() != 200)
      {
         // エラーメッセージを設定する
         errorMessage = response.getBody();
         return(null);
      }
      // レスポンスボディーからデータを取得する
      JSONParser parser = JSON.createParser(response.getBody());
      system.debug('=====1' + response.getBody());
      ResponseData data = (ResponseData)parser.readValueAs(ResponseData.class);

      system.debug('=====2' + data);
      if (data == null)
      {
         errorMessage = 'レスポンスフォーマット例外';
         return(null);
      }
      if (data.error != null && data.error.errorCode != null)
      {
         errorCode    = data.error.errorCode;
         errorMessage = data.error.message;
         return(null);
      }
      List <CommonAlarmMachineResponseDto> ret = new List <CommonAlarmMachineResponseDto>();
      for (AlarmMachineResponse alarmMachineResponse : data.response_keihouki_dto_list)
      {
         ret.add(new CommonAlarmMachineResponseDto(alarmMachineResponse.kiki_sts,
                                                   alarmMachineResponse.trituke_ymd,
                                                   alarmMachineResponse.trituke_nw_ksy_nm,
                                                   alarmMachineResponse.trihazsi_ymd,
                                                   alarmMachineResponse.trihazsi_nw_ksy_nm,
                                                   alarmMachineResponse.kehoki_hinmei_brand_cd,
                                                   alarmMachineResponse.maker_cd_dcd,
                                                   alarmMachineResponse.tosyo_trituke_ymd,
                                                   alarmMachineResponse.manryo_yotei_ymd,
                                                   alarmMachineResponse.kehoki_seino_hsy_ymd,
                                                   alarmMachineResponse.furyohin_trk_kais,
                                                   alarmMachineResponse.manryo_trk_cyst_ymd,
                                                   alarmMachineResponse.manryo_trk_nw_ksy_nm,
                                                   alarmMachineResponse.manryo_dm_sign,
                                                   alarmMachineResponse.manryo_dm_youhi_cd_dcd,
                                                   alarmMachineResponse.manryo_trk_cyst_um_cd_dcd,
                                                   alarmMachineResponse.seizo_no,
                                                   alarmMachineResponse.shr_kbn_cd_dcd,
                                                   alarmMachineResponse.zenk_kiki_id,
                                                   alarmMachineResponse.gmt_set_no));
      }
      return(ret);
   }

   private class ResponseData {
      private List <alarmMachineResponse> response_keihouki_dto_list;
      private Error error;

      private ResponseData(List <alarmMachineResponse> response_keihouki_dto_list, Error error)
      {
         this.response_keihouki_dto_list = response_keihouki_dto_list.clone();
         this.error = error.clone();
      }
   }

   private class AlarmMachineResponse {
      public String ky_id   { get; set; }
      public String kiki_id { get; set; }
      public String trituke_sts     { get; set; }
      public String ky_sts  { get; set; }
      public String manryo_trk_tgt  { get; set; }
      private String kiki_sts        { get; set; }
      private String trituke_jiyu_cd { get; set; }
      private String trituke_jiyu_cd_dcd     { get; set; }
      private String trituke_ymd     { get; set; }
      private String trituke_nw_ksy_cd       { get; set; }
      private String trituke_nw_ksy_nm       { get; set; }
      private String trihazsi_ymd    { get; set; }
      private String trihazsi_nw_ksy_cd      { get; set; }
      private String trihazsi_nw_ksy_nm      { get; set; }
      private String kehoki_hinmei_brand_cd  { get; set; }
      private String seizo_no        { get; set; }
      private String maker_cd        { get; set; }
      private String maker_cd_dcd    { get; set; }
      private String setti_basyo_syu_cd      { get; set; }
      private String setti_basyo_syu_cd_dcd  { get; set; }
      private String kehoki_type_cd  { get; set; }
      private String kehoki_type_cd_dcd      { get; set; }
      private String tosyo_trituke_ymd       { get; set; }
      private String manryo_yotei_ymd        { get; set; }
      private String kehoki_seino_hsy_ymd    { get; set; }
      private String furyohin_trk_kais       { get; set; }
      private String manryo_trk_cyst_ymd     { get; set; }
      private String manryo_trk_nw_ksy_cd    { get; set; }
      private String manryo_trk_nw_ksy_nm    { get; set; }
      private String manryo_dm_sign  { get; set; }
      private String manryo_dm_youhi_cd_dcd  { get; set; }
      private String manryo_trk_cyst_um_cd   { get; set; }
      private String manryo_trk_cyst_um_cd_dcd       { get; set; }
      private String shr_kbn_cd      { get; set; }
      private String shr_kbn_cd_dcd  { get; set; }
      private String zenk_kiki_id    { get; set; }
      private String gmt_set_no      { get; set; }

      private AlarmMachineResponse()
      {
      }

      //   private AlarmMachineResponse(
      //                                 String kiki_sts
      //                                , String trituke_jiyu_cd
      //                                , String trituke_jiyu_cd_dcd
      //                                , String trituke_ymd
      //                                , String trituke_nw_ksy_cd
      //                                , String trituke_nw_ksy_nm
      //                                , String trihazsi_ymd
      //                                , String trihazsi_nw_ksy_cd
      //                                , String trihazsi_nw_ksy_nm
      //                                , String kehoki_hinmei_brand_cd
      //                                , String seizo_no
      //                                , String maker_cd
      //                                , String maker_cd_dcd
      //                                , String setti_basyo_syu_cd
      //                                , String setti_basyo_syu_cd_dcd
      //                                , String kehoki_type_cd
      //                                , String kehoki_type_cd_dcd
      //                                , String tosyo_trituke_ymd
      //                                , String manryo_yotei_ymd
      //                                , String kehoki_seino_hsy_ymd
      //                                , String furyohin_trk_kais
      //                                , String manryo_trk_cyst_ymd
      //                                , String manryo_trk_nw_ksy_cd
      //                                , String manryo_trk_nw_ksy_nm
      //                                , String manryo_dm_sign
      //                                , String manryo_dm_youhi_cd_dcd
      //                                , String manryo_trk_cyst_um_cd
      //                                , String manryo_trk_cyst_um_cd_dcd
      //                                , String shr_kbn_cd
      //                                , String shr_kbn_cd_dcd
      //                                , String zenk_kiki_id
      //                                , String gmt_set_no
      //                                )
      //   {

      //      this.kiki_sts                  = kiki_sts;
      //      this.trituke_jiyu_cd           = trituke_jiyu_cd;
      //      this.trituke_jiyu_cd_dcd       = trituke_jiyu_cd_dcd;
      //      this.trituke_ymd               = trituke_ymd;
      //      this.trituke_nw_ksy_cd         = trituke_nw_ksy_cd;
      //      this.trituke_nw_ksy_nm         = trituke_nw_ksy_nm;
      //      this.trihazsi_ymd              = trihazsi_ymd;
      //      this.trihazsi_nw_ksy_cd        = trihazsi_nw_ksy_cd;
      //      this.trihazsi_nw_ksy_nm        = trihazsi_nw_ksy_nm;
      //      this.kehoki_hinmei_brand_cd    = kehoki_hinmei_brand_cd;
      //      this.seizo_no                  = seizo_no;
      //      this.maker_cd                  = maker_cd;
      //      this.maker_cd_dcd              = maker_cd_dcd;
      //      this.setti_basyo_syu_cd        = setti_basyo_syu_cd;
      //      this.setti_basyo_syu_cd_dcd    = setti_basyo_syu_cd_dcd;
      //      this.kehoki_type_cd            = kehoki_type_cd;
      //      this.kehoki_type_cd_dcd        = kehoki_type_cd_dcd;
      //      this.tosyo_trituke_ymd         = tosyo_trituke_ymd;
      //      this.manryo_yotei_ymd          = manryo_yotei_ymd;
      //      this.kehoki_seino_hsy_ymd      = kehoki_seino_hsy_ymd;
      //      this.furyohin_trk_kais         = furyohin_trk_kais;
      //      this.manryo_trk_cyst_ymd       = manryo_trk_cyst_ymd;
      //      this.manryo_trk_nw_ksy_cd      = manryo_trk_nw_ksy_cd;
      //      this.manryo_trk_nw_ksy_nm      = manryo_trk_nw_ksy_nm;
      //      this.manryo_dm_sign            = manryo_dm_sign;
      //      this.manryo_dm_youhi_cd_dcd    = manryo_dm_youhi_cd_dcd;
      //      this.manryo_trk_cyst_um_cd     = manryo_trk_cyst_um_cd;
      //      this.manryo_trk_cyst_um_cd_dcd = manryo_trk_cyst_um_cd_dcd;
      //      this.shr_kbn_cd                = shr_kbn_cd;
      //      this.shr_kbn_cd_dcd            = shr_kbn_cd_dcd;
      //      this.zenk_kiki_id              = zenk_kiki_id;
      //      this.gmt_set_no                = gmt_set_no;
      //   }
   }

   private class Error {
      private String statusCode;
      private String errorCode;
      private String message;

      private Error(String statusCode, String errorCode, String message)
      {
         statusCode = statusCode;
         errorCode  = errorCode;
         message    = message;
      }
   }
}