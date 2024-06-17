//
//  rootView.swift
//  PayVault
//
//  Created by Shubhada Martha on 2/3/24.
//


//ISSUES
//1. Loading pops up after verification and then goes to home okay?
//2. sometimes verify otp invalid doesn't show alert
//3. The account display resets and shows no bro exists when old user returns or new user first time enters the home [works after going to settings and back]

import SwiftUI

struct rootView: View {
    @StateObject var user = UserViewModel()
    
    var body: some View {
        NavigationStack {
            // Fetch AuthToken from disk
            //let authToken = user.fetchAuthToken()
            let authToken = UserDefaults.standard.string(forKey: "authToken")
            
            // Check if authentication token exists
            if(authToken != nil){ //old user
                LoadingView()
                .environmentObject(user)
            } else { //new user
                LaunchScreenView()
                .environmentObject(user)
            }
        }
    }
}
