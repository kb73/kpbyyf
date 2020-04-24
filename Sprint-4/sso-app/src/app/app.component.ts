import { Component } from '@angular/core';
import { OAuthService, JwksValidationHandler } from 'angular-oauth2-oidc';


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'sso-app';
}

constructor(private oauthService: OAuthService) {
  this.oauthService.redirectUri = window.location.origin;
  this.oauthService.clientId = '0oaacvajrfiUWMmyb4x6';
  this.oauthService.scope = 'kpbowers@charter.net';
  this.oauthService.issuer = 'https://dev-396932-admin.okta.com/oauth2/default';
  this.oauthService.tokenValidationHandler = new JwksValidationHandler();

  // Load Discovery Document and then try to login the user
  this.oauthService.loadDiscoveryDocumentAndTryLogin();
}
