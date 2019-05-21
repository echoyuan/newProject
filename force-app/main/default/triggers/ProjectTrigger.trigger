trigger ProjectTrigger on Project__c (before insert, after update) {
    ProjectTriggerHander handler = new ProjectTriggerHander(Trigger.isExecuting);
    
    if(Trigger.isUpdate && Trigger.isAfter){
        handler.onAfterUpdate(Trigger.new);
        //Trigger.newMap.keySet();
    }

}