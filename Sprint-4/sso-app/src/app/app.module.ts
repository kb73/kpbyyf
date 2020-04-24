import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

import { Routes, RouterModule } from '@angular/router';

// import { OAuthModule } from 'angular-oauth2-oidc';
// import { HomeComponent } from './home/home.component';
// import { AuthGuard } from './shared';


const appRoutes: Routes = [
  // { path: 'search', component: SearchComponent, canActivate: [AuthGuard] },
  // { path: 'home', component: HomeComponent },
  { path: '', redirectTo: '/search', pathMatch: 'full' },
  // { path: '**', redirectTo: 'home' }
];

@NgModule({
  declarations: [
    AppComponent,
    // HomeComponent,
  ],
  imports: [
    FormsModule,
    BrowserModule,
    AppRoutingModule,
    RouterModule.forRoot(appRoutes),
    // OAuthModule.forRoot()
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
