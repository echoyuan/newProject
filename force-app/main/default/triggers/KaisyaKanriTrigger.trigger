trigger KaisyaKanriTrigger on KAISYA_KANRI__c (before update) {
    KaisyaKanriTriggerHander handler = new KaisyaKanriTriggerHander(Trigger.isExecuting);
    if(Trigger.isUpdate && Trigger.isBefore) {
        handler.onBeforeUpdate(Trigger.old[0]);
    }
}