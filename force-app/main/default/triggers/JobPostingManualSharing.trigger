trigger JobPostingManualSharing on Job_Posting__c (After insert) {
    switch on Trigger.OperationType {
        when AFTER_INSERT {
            for(Job_Posting__c jobPosting : Trigger.new) {
                JobPostingManualSharing.manualShare(jobPosting.Id, jobPosting.Hiring_Manager__c);
            }
           
        }
    }

}