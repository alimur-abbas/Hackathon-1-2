/**
 * @description       : 
 * @author            : Mr Md Alimur Rehman Abbas
 * @group             : 
 * @last modified on  : 11-24-2022
 * @last modified by  : Mr Md Alimur Rehman Abbas
**/
public with sharing class JiraIntegration {
    @future(callout=true)
    public Static void createIssue() {
        Case caseRecord  =[Select subject ,OwnerId from Case limit 1];
        System.debug('caseRecord'+caseRecord);
        // Create a new issue
        String summary = 'New Case: ' + caseRecord.Subject;
        String description = 'New Case: ' + caseRecord.Subject + ' has been created. Please review the case and take necessary action.';
        String issueType = 'Task';
        Integer priorityID=3;
        String Assignee= caseRecord.OwnerId;
        String Reporter= caseRecord.OwnerId;
        String userName ='gogglemailservice17@gmail.com';
        String passWord = 'BByD8Do1EnS9mIp0GzOQAE9A';



        String url = 'https://blackshadow.atlassian.net/rest/api/2/issue';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        Blob headerValue = Blob.valueOf(userName+':'+passWord);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        req.setBody('{ "fields":{"summary": "'+summary+'",  "project":{"key":"BS"},  "issuetype":{"name":"Task"}}}');
        //  "issuetype": {
        //     "key": "Task"
        // }
        Http http = new Http();
        System.debug('req=='+req.getBody());
        HttpResponse res;
        try {
           res = http.send(req);
           System.debug('Response: ' + res.getBody());

        } catch (Exception e) {
            System.debug('Exception: ' + e.getMessage());
            
        }
       
      

    } 
}
