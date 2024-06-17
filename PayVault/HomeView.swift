//
//  HomeView.swift
//  PayVault
//
//  Created by Shubhada Martha on 1/26/24.
//

import SwiftUI

struct HomeView: View {
    @State private var isSettings = false
    @EnvironmentObject var user : UserViewModel
    @State var theformatted: String = ""
    @State var authToken: String = ""
    @State var bro: User?
    
    var body: some View{
        NavigationStack {
            VStack{
                //App Logo
                Image("frogVault")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                //App Name
                Text("FroggyVault")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color("DarkBrown"))
                    .padding()
                
                if let userName = user.user?.name {
                    Text("Welcome \(userName)")
                } else {
                    Text("User name is not provided")
                }
                
                //Instruction to tell users what to do
                Text("TOTAL ASSETS")
                    .bold()
                    .font(.headline)
                    .foregroundColor(Color("DarkBrown"))
                
                Text("$0.00")
                    .bold()
                    .font(.title2)
                    .foregroundColor(Color("DarkBrown"))
                
                if let accounts = user.user?.accounts {
                    if accounts.isEmpty{
                        Text("No accounts created")
                    } else {
                        Text("$$$")
                        List(accounts) { account in
                            VStack(alignment: .leading) {
                                Text("Account Name: \(account.name)")
                                Text("Balance: \(account.balanceString())")
                            }
                        }
                    }
                } else {
                    Text("No accounts created")
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Home")
                        .foregroundColor(Color("LightPeach"))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isSettings = true
                        print("Settings button tapped")
                    }) {
                        Image(systemName: "gear")
                    }
                    .navigationDestination(isPresented: $isSettings) {
                        SettingsView(theformatted: theformatted)
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color("SlimeGreen"), for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(Color("DarkBrown"))
            .navigationBarBackButtonHidden(true)
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Gradient(colors: [.teal, .cyan, .green]).opacity(0.6))
            .onAppear {
                theformatted = user.phoneNum
                
                if let unwrappedAuthToken = user.authToken {
                    authToken = unwrappedAuthToken
//                    print(authToken)
//                    print("Home 106")
                } else {
                    // Handle the case where user.authToken is nil, if needed
                    print("User authToken is nil")
                }
                
                save(authToken: authToken)
                bro = user.user
                print(bro)
//                if bro != nil {
//                        print("HomeView User exists")
//                    } else {
//                        print("HomeView No user exists")
//                    }
            }
            .padding()
        }
    }
    
    func save(authToken: String) {
        Task{
            try await user.saveUser(authToken: authToken)
        }
    }
    
}

//#Preview {
//    HomeView()
//}

