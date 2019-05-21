/**
 * [電力]契約お客さま情報APIレスポンスDto
 */
public with sharing class CommonElectricityAccountResponseDto {
	// 電力契約番号	    
	@AuraEnabled public String saId  { get; set; }
	// 郵便番号	    
	@AuraEnabled public String postal  { get; set; }
	// 住所
	@AuraEnabled public String address1  { get; set; }
	// 住所(建物名)
	@AuraEnabled public String address2  { get; set; }
	// 住所(棟番)
	@AuraEnabled public String num1  { get; set; }
	// 住所(部屋番号)
	@AuraEnabled public String address4  { get; set; }
	// お客さま名	    
	@AuraEnabled public String xPerName  { get; set; }
	// お客さま名(カナ)	    
	@AuraEnabled public String xPerNameKana  { get; set; }
	// 店名・屋号	    
	@AuraEnabled public String xShopName  { get; set; }
	// 店名・屋号(カナ)	    
	@AuraEnabled public String xShopNameKana  { get; set; }
	// 電話番号
	@AuraEnabled public String phone  { get; set; }
	// 電話種別	    
	@AuraEnabled public String xPhoneCat  { get; set; }
	// 電話種別(デコード)
	@AuraEnabled public String xPhoneCatLabel  { get; set; }
	// 連絡先種別	    
	@AuraEnabled public String xContactCat  { get; set; }
	// 連絡先種別(デコード)
	@AuraEnabled public String xContactCatLabel  { get; set; }
	// 確認状態	   
	@AuraEnabled public String xPhoneCheckCd  { get; set; }
	// 確認状態(デコード)
	@AuraEnabled public String xPhoneCheckCdLabel  { get; set; }
    // 住所(表示用)
    @AuraEnabled public String 	addressDisplay	{ get; set; }
    

    public CommonElectricityAccountResponseDto() {
    }
}