/*
 * Api呼出返却レスポンス共通
 */
public virtual with sharing class CommonApiResponseData {
    public String result{ get; set; }
    public String code{ get; set; }
    public String message{ get; set; }
    public List<CommonApiErrorResponseDto> errors{ get; set; }
}