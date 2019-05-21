/*
 * Api呼出返却レスポンス共通(情報連携キー)
 */
public virtual with sharing class CommonKeyApiResponseData {
    public String result{ get; set; }
    public String code{ get; set; }
    public List<CommonKeyApiErrorResponseDto> errors{ get; set; }
}