/**
 * [電力]契約情報APIレスポンスDto
 */
public without sharing class CommonElectricityContractResponseDto {
    //	電力契約番号	    
    @AuraEnabled public String 	saId	 { get; set; }
    //	ガス使用契約番号（４X)
    @AuraEnabled public String 	xGas4X	 { get; set; }
    //	電力使用契約番号	    
    @AuraEnabled public String 	xEl4X	 { get; set; }
    //	お客さま登録番号（３X）    
    @AuraEnabled public String 	x3X	 { get; set; }
    //	カスタマ番号（８X)
    @AuraEnabled public String 	x8X	 { get; set; }
    //	開始日	    
    @AuraEnabled public String 	startDt	 { get; set; }
    //	中止日	    
    @AuraEnabled public String 	endDt	 { get; set; }
    //	契約ステータス	    
    @AuraEnabled public String 	saStatusFlg	 { get; set; }
    //	契約ステータス(デコード)
    @AuraEnabled public String 	saStatusFlgLabel	 { get; set; }
    //	使用中止理由	    
    @AuraEnabled public String 	xStopReason	 { get; set; }
    //	使用中止理由(デコード)
    @AuraEnabled public String 	xStopReasonLabel	 { get; set; }
    //	契約タイプ	    
    @AuraEnabled public String 	saTypeCd	 { get; set; }
    //	契約タイプ(デコード)
    @AuraEnabled public String 	saTypeCdLabel	 { get; set; }
    //	NW箇所コード	    
    @AuraEnabled public String 	xPisNwCd	 { get; set; }
    //	NW箇所コード(デコード)
    @AuraEnabled public String 	xPisNwCdLabel	 { get; set; }
    //	基本検針日	    
    @AuraEnabled public String 	xBasicMrDt	 { get; set; }
    //	料金メニュー適用開始日	    
    @AuraEnabled public String 	effdt	 { get; set; }
    //	料金メニュー	    
    @AuraEnabled public String 	rsCd	 { get; set; }
    //	料金メニュー(デコード)
    @AuraEnabled public String 	rsCdLabel	 { get; set; }
    //	契約電流	    
    @AuraEnabled public String 	xContractCur	 { get; set; }
    //	契約容量	    
    @AuraEnabled public String 	xContractCap	 { get; set; }
    //	契約電力	    
    @AuraEnabled public String 	xContractOp	 { get; set; }
    //	パック適用開始日	    
    @AuraEnabled public String 	xCampainStartDt	 { get; set; }
    //	パック適用終了日	    
    @AuraEnabled public String 	xCampainEndDt	 { get; set; }
    //	パック割適用区分	    
    @AuraEnabled public String 	val	 { get; set; }
    //	供給地点特定番号	    
    @AuraEnabled public String 	xSupplyPointId	 { get; set; }
    
    public CommonElectricityContractResponseDto(){
        
    }
}