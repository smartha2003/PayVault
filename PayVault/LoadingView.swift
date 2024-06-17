//
//  LoadingView.swift
//  PayVault
//
//  Created by Shubhada Martha on 1/30/24.
//

import SwiftUI

struct LoadingView: View {
    @State private var isActive = false
    @EnvironmentObject var user : UserViewModel
    @State var theformatted: String = ""
    let userName = UserDefaults.standard.string(forKey: "userName") //restore username from disk
    let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") //restore phone number from disk
    let authToken = UserDefaults.standard.string(forKey: "authToken") //restore authToken from disk
    let otp = UserDefaults.standard.string(forKey: "otpCode") //restore otp from disk
    
    var body: some View{
        //GeometryReader { geometry in
        NavigationStack {
            VStack(alignment: .center) {
                //Loading Icon
//                Image("loading-bar")
//                    .resizable()
//                    .scaledToFit()
//                    .padding()
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect (4)
                
                Spacer(minLength: 100)
                
                Text("Loading time: \(user.time)")
                
                Spacer(minLength: 200)
                
                //Bottom Footer of My information
                Text("HW 3 - Shubhada Martha ECS 189E")
                    .font(.caption)
                    .padding()
                    .foregroundColor(Color("DarkBrown"))
                
                Spacer()
                
            }
            .onAppear {
                let _ = handleSave(authToken: authToken ?? "", userName: userName ?? "", phoneNumber: phoneNumber ?? "", otp: otp ?? "")

                //user.findTime()
                user.getTime()
                
                // Schedule navigation after a delay
                DispatchQueue.main.asyncAfter(deadline: .now() + user.time) {
                    self.isActive = true
                }
            }
            .fullScreenCover(isPresented: $isActive) {
                HomeView() .environmentObject(user)
            }
            .frame(width: 200, height: 200)
            .navigationBarBackButtonHidden(true)
            //.frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.9)
            .padding()
            //}
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Gradient(colors: [.teal, .cyan, .green]).opacity(0.6))
        }
    }
    
    func handleSave(authToken: String, userName: String, phoneNumber: String, otp: String) {
        Task{
            
            // SET PHONENUMBER BACK TO WHAT IT WAS FROM DISK
            user.setAuthToken(token: authToken)
            
            // SET USERNAME BACK TO WHAT IT WAS FROM DISK
            user.setUsername(name: userName)

            // SET PHONENUMBER BACK TO WHAT IT WAS FROM DISK
            user.setPhoneNumber(number: phoneNumber)
            
            // SET OTP BACK TO WHAT IT WAS FROM DISK
            user.setOTP(otp: otp)
            print("Saved authToken, username and phoneNumber to class")
            
            try await user.findTime()
        }

    }
}



#Preview {
    LoadingView()
}

