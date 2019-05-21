/**
 * エラー処理共通Dto
 */
public with sharing class CommonApiErrorResponseDto {
	/**
     * バリデーションエラー情報
     */
    // 詳細エラーコード		
    @AuraEnabled public String 	code	{ get; set; }
    // エラー対象属性名		
    @AuraEnabled public String 	property	{ get; set; }
    // エラー表示ID		
    @AuraEnabled public String 	property_pass	{ get; set; }
    // エラーメッセージ(画面用)		
    @AuraEnabled public String 	message_display	{ get; set; }
    // エラーメッセージ(システム用)		
    @AuraEnabled public String 	message_system	{ get; set; }
    
    public CommonApiErrorResponseDto(){
        
    }
}