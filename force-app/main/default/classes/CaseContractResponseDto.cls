public class CaseContractResponseDto {
    @AuraEnabled public Integer code { get; set; }
    @AuraEnabled public String message { get; set; }
    @AuraEnabled public List<Object> contractListByApi { get; set; }
    @AuraEnabled public List<Object> contractListByJson { get; set; }
    @AuraEnabled public List<Object> checkListForJson { get; set; }
    @AuraEnabled public String viewModel { get; set; }
    @AuraEnabled public String checkModel { get; set; }
    @AuraEnabled public Boolean editBottenFlg { get; set; }
    
    public CaseContractResponseDto(Integer code, String msg, List<Object> contractListByApi, 
                                   List<Object> contractListByJson, List<Object> checkListForJson, 
                                   String viewModel, String checkModel, Boolean editBottenFlg){
        this.code = code;
        this.message = msg;
        this.contractListByApi = contractListByApi;
        this.contractListByJson = contractListByJson;
        this.checkListForJson = checkListForJson;
        this.viewModel = viewModel;
        this.checkModel = checkModel;
        this.editBottenFlg = editBottenFlg;
    }
}