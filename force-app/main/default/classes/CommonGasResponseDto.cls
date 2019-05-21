public class CommonGasResponseDto {
    @AuraEnabled public Integer code { get; set; }
    @AuraEnabled public String message { get; set; }
    @AuraEnabled public List<Object> gasList { get; set; }
    @AuraEnabled public Object gasObject { get; set; }
    
    public CommonGasResponseDto(Integer code, String message, List<Object> gasList, Object gasObject) {
        this.code = code;
        this.message = message;
        this.gasList = gasList;
        this.gasObject = gasObject;
    }
}