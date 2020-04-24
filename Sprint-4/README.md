The goal is to build an AngularJS app that uses OpenID Connect to allow a user to access to use certain features of the app

To do this I installed the Angular CLI on my local machine and used `ng new sso-app` to create a new application which I could then edit and could launch to my browser using `ng serve`

I was also able to get this to run on an AWS Ubuntu EC2 instance (3.22.187.3) by installing nginx and nodejs onto the instance and transferring the distribution code for the web app via FileZilla, however I was not able to develop the app enough to put the final project on the ec2 instance. The current page on the ec2 is just proof of concept of how I could get an Angular webpage on it.
