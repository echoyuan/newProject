public class CommonResponseSimpleAccountDto {

    @AuraEnabled public String id { get; set; }
    @AuraEnabled public Boolean hasGasContract { get; set; }
    @AuraEnabled public Boolean hasPowerContract { get; set; }
    @AuraEnabled public Boolean hasOther { get; set; }
    
    public CommonResponseSimpleAccountDto(
          String id
        , Boolean hasGasContract
        , Boolean hasPowerContract
        , Boolean hasOther) {
        this.id = id;
        this.hasGasContract = hasGasContract;
        this.hasPowerContract = hasPowerContract;
        this.hasOther = hasOther;
    }
}