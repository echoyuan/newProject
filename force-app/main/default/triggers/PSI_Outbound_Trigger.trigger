trigger PSI_Outbound_Trigger on PSI_Outboud__c (after insert) {
	PSI_Product__c pro = [select id,PSI_OutboundTimes__c from PSI_Product__c where id=:trigger.new[0].PSI_Product__c];
    if(pro.PSI_OutboundTimes__c == null) {
        pro.PSI_OutboundTimes__c = 1;
    } else {
        pro.PSI_OutboundTimes__c += 1;
    }
    update pro;
}