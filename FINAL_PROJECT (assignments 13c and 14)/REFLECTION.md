# Overview
The app I'm creating is actuall a plugin for an existing open source application called Bitbar (see README.md for download) which allows a user to add pretty much anything to their menu bar.

## 13c
For 13c I wrote the preliminary code and got some basic functionality down. I forgot to include what websites I used, but it was mostly just simple syntax things rather than workflow things. I wrote the code locally and then just copied it into Github.
The commit hash is: [ee4a787](https://github.com/kb73/kpbyyf/commit/ee4a7870f706107e064ba8647563fc81cc7e1a96)

## 14
My goal for the final version is to have SSO functionality added so that notes are persistent across multiple platforms, but I'm not entirely sure how that's going to work yet, since I have no idea how to connect Bash to SSO or a Backend, but I will do my best

#### Process
 1. Wrote starting code
 2. Added delete note functionality
 3. Googled how to implement openID Connect as a command-line interface
 4. Found the first link listed below
 5. Article said to install a software called [WS02 Identity Server](https://docs.wso2.com/display/IS570/Installing+on+Linux+or+OS+X) (seemed a little sketch, they asked for my email)
 6. After about an hour of trying to get the software to work I kept running into an issue where the program was able to access java stuffs. Tried deleting and reinstalling jdk that it said it was having issues with and re-exporting the JAVA_HOME folder to the path. Back to square one on trying to add openID Connect to command line interface
 7. It appears Okta might have a [solution](https://developer.okta.com/blog/2018/07/16/oauth-2-command-line)...fortunately I have an okta account from my first go (pun intended) at trying to get SSO to work before Dr. Goggins released the tutorial
 8. Created a new Application for oauth2 in okta
 
 

### Resource Links (or at least the ones I tried to use):
 - https://medium.com/@balaajanthan/openid-flow-from-a-cli-ac45de876ead
 - https://is.docs.wso2.com/en/5.10.0/get-started/quick-start-guide/
 - https://developer.okta.com/blog/2018/07/16/oauth-2-command-line
