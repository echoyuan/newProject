/**
 * [電力]期間限定割情報APIレスポンスDto
 */
public without sharing class CommonElectricityTermLimitedResponseDto {
    // 電力契約番号 
    @AuraEnabled public String saId { get; set; }
    // 期間限定割種別 
    @AuraEnabled public String xLimitedCp { get; set; }
    // 期間限定割種別（名称） 
    @AuraEnabled public String xLimitedCpLabel { get; set; }
    // 期間限定割適用開始日 
    @AuraEnabled public String xLimitedCpStartDt { get; set; }
    // 期間限定割適用終了日 
    @AuraEnabled public String xLimitedCpEndDt { get; set; }   
    
    public CommonElectricityTermLimitedResponseDto(){
        
    }
}