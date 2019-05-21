public class CommonResponseSimpleContractDto {

    @AuraEnabled public String userKey { get; set; }
    @AuraEnabled public String serviceType { get; set; }
    @AuraEnabled public String serviceKey { get; set; }
    @AuraEnabled public String categoryName { get; set; }
    @AuraEnabled public String status { get; set; }
    @AuraEnabled public String startDate { get; set; }
    @AuraEnabled public String endDate { get; set; }
    @AuraEnabled public String menu { get; set; }
    @AuraEnabled public String confirmFlag { get; set; }
    @AuraEnabled public String confirmName { get; set; }
    
    public CommonResponseSimpleContractDto(
          String userKey
        , String serviceType
        , String serviceKey
        , String categoryName
        , String status
        , String startDate
        , String endDate
        , String menu
        , String confirmFlag
        , String confirmName) {
        this.userKey = userKey;
        this.serviceType = serviceType;
        this.serviceKey = serviceKey;
        this.categoryName = categoryName;
        this.status = status;
        this.startDate = startDate;
        this.endDate = endDate;
        this.menu = menu;
        this.confirmFlag = confirmFlag;
        this.confirmName = confirmName;
    }
}