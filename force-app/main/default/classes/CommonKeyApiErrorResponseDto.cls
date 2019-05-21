/**
 * エラー処理共通Dto(情報連携キー)
 */
public with sharing class CommonKeyApiErrorResponseDto {
	/**
     * バリデーションエラー情報
     */
    // 詳細エラーコード		
    @AuraEnabled public String 	code	{ get; set; }
    // エラー対象属性名		
    @AuraEnabled public String 	property	{ get; set; }
    // エラーメッセージ(画面用)		
    @AuraEnabled public String 	messageDisplay	{ get; set; }
    // エラーメッセージ(システム用)		
    @AuraEnabled public String 	messageSystem	{ get; set; }
    
    public CommonKeyApiErrorResponseDto(){
        
    }
}