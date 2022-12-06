public with sharing class JobPostingManualSharing {
    public static void manualShare(Id recordId, Id hiringManagerId){
        Job_Posting__share jobPostingShare = new Job_Posting__share();
        jobPostingShare.ParentId = recordId;
        jobPostingShare.UserOrGroupId = hiringManagerId;
        jobPostingShare.AccessLevel = 'edit';
        Database.SaveResult saveResult = Database.insert(jobPostingShare, false);
        if(!saveResult.isSuccess()){
            System.debug('Error: ' + saveResult.getErrors()[0].getMessage());
        }
    }
}