/**
* [情報連携キー]キー検索APIレスポンスDto
*/
public with sharing class CommonKeySearchResponseDto {
    @AuraEnabled public String viewKey { get; set; }
    @AuraEnabled public String userKey { get; set; }
    @AuraEnabled public String serviceType { get; set; }
    @AuraEnabled public String serviceKey { get; set; }
    @AuraEnabled public String otherKey1 { get; set; }
    @AuraEnabled public String categoryName { get; set; }
    @AuraEnabled public String status { get; set; }
    @AuraEnabled public String startDate { get; set; }
    @AuraEnabled public String endDate { get; set; }
    @AuraEnabled public String menu { get; set; }
    @AuraEnabled public String grayFlag { get; set; }
    //@AuraEnabled public String confirmFlag { get; set; }
    //@AuraEnabled public String confirmName { get; set; }
    //未退会/退会済(webIDリスト:ソート用)
    @AuraEnabled public String withdrawalStatus { get; set; }
    //順番
    @AuraEnabled public String sortOrder { get; set; }
    
    
    public CommonKeySearchResponseDto(){
        this.grayFlag = '';
    }
    
    public CommonKeySearchResponseDto(
          String userKey
        , String serviceType
        , String serviceKey
        , String otherKey1
        , String categoryName
        , String status
        , String startDate
        , String endDate
        , String menu
        //, String confirmFlag
        //, String confirmName
        //, Integer index
    ) {
        this.userKey = userKey;
        this.serviceType = serviceType;
        this.serviceKey = serviceKey;
        this.otherKey1 = otherKey1;
        this.categoryName = categoryName;
        this.status = status;
        this.startDate = startDate;
        this.endDate = endDate;
        this.menu = menu;
        this.grayFlag = '';
        //this.confirmFlag = confirmFlag;
        //this.confirmName = confirmName;
        //this.index = index;
    }
}