/**
 * [電力]契約支払者情報APIレスポンスDto
 */
public without sharing class CommonElectricityPaymentResponseDto {
    // 電力契約番号	 
    @AuraEnabled public String saId  { get; set; }
    // 支払方法	 
    @AuraEnabled public String xPayMethod  { get; set; }
    // 支払方法(名称)	 
    @AuraEnabled public String xPayMethodLabel  { get; set; }
    // 支払者郵送先	 
    @AuraEnabled public String xPayerTo  { get; set; }
    // 支払者郵送先(名称)	 
    @AuraEnabled public String xPayerToLabel  { get; set; }
    // 支払者名	 
    @AuraEnabled public String xPayerName  { get; set; }
    // 支払者名(カナ) 	 
    @AuraEnabled public String xPayerNameKana  { get; set; }
    // 支払者_店名・屋号	 
    @AuraEnabled public String xPayerShopName  { get; set; }
    // 支払者_店名・屋号(カナ)	 
    @AuraEnabled public String xPayerShopNameKana  { get; set; }
    // 支払者郵便番号	 
    @AuraEnabled public String xPayerPostal  { get; set; }
    // 支払者住所和名	 
    @AuraEnabled public String xPayerAddress1  { get; set; }
    // 支払者建物名	 
    @AuraEnabled public String xPayerAddress2  { get; set; }
    // 支払者棟番	 
    @AuraEnabled public String xPayerNum1  { get; set; }
    // 支払者部屋番	 
    @AuraEnabled public String xPayerAddress4  { get; set; }
    
    public CommonElectricityPaymentResponseDto(){
        
    }
}