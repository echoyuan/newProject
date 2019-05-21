public class ElectricityContractDetailDto {
    @AuraEnabled public String gasUseContractNumber { get; set; }

    @AuraEnabled public String customerNumber { get; set; }
    @AuraEnabled public String storeName { get; set; }
    @AuraEnabled public String name { get; set; }
    @AuraEnabled public String address { get; set; }
    @AuraEnabled public String postal { get; set; }
    @AuraEnabled public String systemProcCode { get; set; }
    @AuraEnabled public String storeNameKana { get; set; }
    @AuraEnabled public String nameKana { get; set; }
    @AuraEnabled public String phone { get; set; }

    @AuraEnabled public String managementBranch { get; set; }
    @AuraEnabled public String paymentMethod { get; set; }
    @AuraEnabled public String financialInstitution { get; set; }
    @AuraEnabled public String depojistType { get; set; }
    @AuraEnabled public String payerName { get; set; }
    @AuraEnabled public String cardCompany { get; set; }
    @AuraEnabled public String gasPriceContractType { get; set; }
    @AuraEnabled public String paymentMeterReading { get; set; }
    @AuraEnabled public String gasMeterCompanyNumber { get; set; }
    @AuraEnabled public String meterPosition { get; set; }
    @AuraEnabled public String meterState { get; set; }
    @AuraEnabled public String supplyStopMethod { get; set; }
    @AuraEnabled public String recentMeterReadingDay { get; set; }
    @AuraEnabled public String currentBillingStatus { get; set; }
    @AuraEnabled public String otherSystemContractInformation { get; set; }
    @AuraEnabled public String electricPowerSum { get; set; }
    @AuraEnabled public String responseAttention { get; set; }
    @AuraEnabled public String administrativeDistrict { get; set; }
    @AuraEnabled public String designationDateTransfer { get; set; }
    @AuraEnabled public String branchName { get; set; }
    @AuraEnabled public String accountNumber { get; set; }
    @AuraEnabled public String billingService { get; set; }
    @AuraEnabled public String cardExpirationDate { get; set; }
    @AuraEnabled public String amountDesignationReport { get; set; }
    @AuraEnabled public String nextMonthTotal { get; set; }
    @AuraEnabled public String formatNumberItems { get; set; }
    @AuraEnabled public String terminationReason { get; set; }
    @AuraEnabled public String meterReadingReason { get; set; }
    @AuraEnabled public String responseBillding { get; set; }
    @AuraEnabled public String meterReadingMethod { get; set; }
    @AuraEnabled public String meterReadingTimes { get; set; }
    @AuraEnabled public String cardNumber { get; set; }
    @AuraEnabled public String ghpState { get; set; }
    @AuraEnabled public String previousAddressCustomerNumber { get; set; }
    @AuraEnabled public String instructionNumber { get; set; }
    
    public ElectricityContractDetailDto(){
    }
}