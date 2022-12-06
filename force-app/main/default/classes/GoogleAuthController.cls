/**
 * @description       : 
 * @author            : Mr Md Alimur Rehman Abbas
 * @group             : 
 * @last modified on  : 11-30-2022
 * @last modified by  : Mr Md Alimur Rehman Abbas
**/
public with sharing class GoogleAuthController {
   public String authEndPoint = 'https://accounts.google.com/o/oauth2/v2/auth';
   public String tokenEndPoint = 'https://www.googleapis.com/oauth2/v4/token';
   public String clientKey ='189770941114-4n9ikgbs2lv43g2dl522aosujna81ahk.apps.googleusercontent.com';
   public String clientSecret='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';
   public String redirectUri='https://ali17-dev-dev-ed.lightning.force.com/lightning/o/Task/home';
   public boolean scope=true;
   public String state='123456789';
   public String accessType='offline';
   public String responseType='code';
   public String prompt='consent';
   public String grantType='authorization_code';
   public String authScope='https://www.googleapis.com/auth/calender ';

    public  Pagereference getAuthUrl(){
        String authUrl = authEndPoint + '?client_id=' + clientKey + '&redirect_uri=' + redirectUri + '&scope=' + authScope + '&state=' + state + '&access_type=' + accessType + '&response_type=' + responseType + '&prompt=' + prompt;
        System.debug('authUrl: ' + authUrl);
        PageReference pageRef = new PageReference(authUrl);
        pageRef.setRedirect(true);
        return pageRef;
    }
}
