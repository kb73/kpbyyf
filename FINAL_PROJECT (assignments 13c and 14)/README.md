# Overview

Notes is a plugin for the application [Bitbar](https://getbitbar.com/) to keep track of a list of whatever you want.

## Use

- First make sure you have [Bitbar](https://getbitbar.com/) installed
- Download the `notes_final.1m.sh` file and the `support_files/` folder from this repository and add them to your Bitbar plugins folder
- In both the `.sh` file and the `support_files/login.php` file, change the paths included from `/Users/kevin/bitbar_plugins/` to the absolute path to your bitbar plugins folder
- Refresh Bitbar and it will show up in the menu bar
- Enter your Okta ID and Secret in the prompts

## Additional Info

 - The `support_files` folder hosts the login script as well as the credentials after the plugin has been set up
 - After 1 single attempt, you will not need to login again
 - To bypass the login (for whomever wants to see the functionality without needing to create an account),  `cd` into your bitbar plugins folder and use the command `echo "pass">support_files/output`. Obviously this wouldn't be included in an actual release, but just to make it easier to show the functionality
 - My credentials for trial purposes: ClientID:0oac5oxzzozyDK3D44x6 ClientSecret:-yQ9NHP9gI9aHGlpbVKTuA2NKvVYNzTqOMDB3ZmW
