public class CommonResponseSimpleMtgDto {

    @AuraEnabled public String serviceKey { get; set; }
    @AuraEnabled public String status { get; set; }
    @AuraEnabled public String startDate { get; set; }
    @AuraEnabled public String endDate { get; set; }
    @AuraEnabled public String mtgCategory { get; set; }
    @AuraEnabled public String point { get; set; }
    
    public CommonResponseSimpleMtgDto(
          String serviceKey
        , String status
        , String startDate
        , String endDate
        , String mtgCategory
        , String point){
        this.serviceKey = serviceKey;
        this.status = status;
        this.startDate = startDate;
        this.endDate = endDate;
        this.mtgCategory = mtgCategory;
        this.point = point;
    }
}