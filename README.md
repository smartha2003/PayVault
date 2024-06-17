# FroggyVault

Created by Shubhada Martha

<p align="center">
  <img src="https://github.com/smartha2003/ECS189E/assets/103222835/767993b6-db3a-4515-9c86-ffbdb169ba95" width="300">
</p>

<p align="center">
  <img src="https://github.com/smartha2003/ECS189E/assets/103222835/f05da2f8-15b8-4210-8fe2-ecdca32360a1" width="200">
</p>

FroggyVault is a mobile transaction app in SwiftUI, which can be used in place of physical card transactions!

## App Features
- Dismissing Number Keypad
- TextField Formatting
- Jump TextFields and delete from OPT Textfields
- API server implementation
- Invalid phone number, OPT Code Checker
- Send OPT Code
- Save user info to disk and fetch
- Ability to handle new and returning user info
- Auto displaying user attributes
- Ability to chnage username
- Log out of account

## App Files
- PayVaultApp
- Api
- UserViewModel
- rootView
- LaunchScreenView
- LogInScreenView
- VerificationView
- LoadingView
- HomeView
- SettingsView

## Bugs / things to know
- NOTE: The user attributes are saved to disk and then retrived again when the same user returns to the app [I realized that I'm supposed to only save the authToken to disk which already carries the phone number, name, account info, etc]
- The name and account details on home view are accessed through the userResponse though 
- Initially the account info sometimes isn't loaded properly but navigating to settings page and back displays the right account info
- The loading screen pops up when the information is loading even for a new user
- Sometimes invalid OTP code is recognized and printed to console but the alert doesn't get toggled

## Package Dependency
- PhoneNumberKit found at [https://github.com/marmelroy/PhoneNumberKit](https://github.com/marmelroy/PhoneNumberKit)
