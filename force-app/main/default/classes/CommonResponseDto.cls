public class CommonResponseDto {

    @AuraEnabled public Integer code { get; set; }
    @AuraEnabled public String message { get; set; }
    @AuraEnabled public Object displayInfo { get; set; }
    
    public CommonResponseDto(Integer code, String msg, Object displayInfo){
        this.code = code;
        this.message = msg;
        this.displayInfo = displayInfo;
    }
}