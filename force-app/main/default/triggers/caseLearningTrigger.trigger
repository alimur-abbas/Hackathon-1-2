trigger caseLearningTrigger on case (before insert,after insert,after update) {
    switch on Trigger.OperationType {
        when BEFORE_INSERT  {
            CaseLearningTriggerController.beforeInsert(trigger.new);
        }
        when AFTER_INSERT  {
            CaseLearningTriggerController.afterInsert(trigger.new);
        }
        when AFTER_UPDATE  {
            CaseLearningTriggerController.afterUpdate(trigger.new, trigger.oldMap);
        }
        // when AFTER_DELETE  {
        //     CaseLearningTriggerController.afterDelete(trigger.old);
        // }
        
    }

}