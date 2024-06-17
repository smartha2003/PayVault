//
//  SettingsView.swift
//  PayVault
//
//  Created by Shubhada Martha on 1/30/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var userName: String = ""
    @State private var codeIsGood = false
    @State private var back = false
    @State private var loggedout = false
    @EnvironmentObject var user : UserViewModel
    @State var theformatted: String = ""

    var body: some View{
        NavigationStack {
            GeometryReader { _ in
                VStack{
                    Form {
                        Section(header: Text("User Information")) {
                            TextField("User Name", text: $userName)
                                .onAppear {
                                    // Code inside this closure will be executed when the view appears.
                                    // Check if a username is saved in UserDefaults
                                    if let savedUserName = UserDefaults.standard.string(forKey: "userName") {
                                        // If a username is saved, set the state variable
                                        userName = savedUserName
                                    } else {
                                        // If no username is saved, you can set a default value or leave it blank
                                        userName = ""
                                    }
                            }
                            Text(theformatted)
                                .onAppear {
                                    // Code inside this closure will be executed when the view appears.
                                    // Check if a username is saved in UserDefaults
                                    if let savedPhone = UserDefaults.standard.string(forKey: "phoneNumber") {
                                        // If a username is saved, set the state variable
                                        theformatted = savedPhone
                                    } else {
                                        // If no username is saved, you can set a default value or leave it blank
                                        theformatted = ""
                                    }
                                }
                        }
                    }
                    
                    HStack {
                        Button("Save") {
                                user.setUsername(name: userName)
                                user.saveUserName(userName: userName)
                                print("Saved username to class")
                                codeIsGood = true
                            }.fullScreenCover(isPresented: $codeIsGood) {
                                HomeView() .environmentObject(user)
                        }.padding()
                            .background(Color("SlimeGreen"))
                            .foregroundColor(Color("LightPeach"))
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                            .frame(maxWidth: .infinity)
                        
                        
                        //WHILE LOGGING OUT DO I NEED TO RESET THE USERNAME T00?
                        Button("Logout") {
                            loggedout = true
                            user.logout()
                            // Navigate to the login or registration screen
                        }.padding()
                            .background(Color("SlimeGreen"))
                            .foregroundColor(Color("LightPeach"))
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                            .frame(maxWidth: .infinity)
                    }
                    
                    //Bottom Footer of My information
                    Text("HW 3 - Shubhada Martha ECS 189E")
                        .font(.caption)
                        .padding()
                        .foregroundColor(Color("DarkBrown"))
                    
                    Spacer()
//
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                                        Button(action: {
                                            back = true
                                        }) {
                                            Image(systemName: "arrow.backward")
                                                .foregroundColor(Color("LightPeach"))
                                                .imageScale(.large)
                                                .frame(width: 32, height: 32)
                                        }
                                    }
                    ToolbarItem(placement: .principal) { Text("Settings").foregroundColor(Color("LightPeach")) }
                }
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color("SlimeGreen"), for: .navigationBar)
                //            .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .foregroundColor(Color("DarkBrown"))
                .padding()
                .containerRelativeFrame([.horizontal, .vertical])
                .background(Gradient(colors: [.teal, .cyan, .green]).opacity(0.6))
                .scrollContentBackground(.hidden)
                .onTapGesture {
                    // Dismiss the keyboard when tapping outside of TextField
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .fullScreenCover(isPresented: $back) {
                    HomeView() .environmentObject(user)
                }
                .fullScreenCover(isPresented: $loggedout) {
                    LaunchScreenView() .environmentObject(user)
                }
                .onAppear {
                    // Access user instance after it's fully initialized
                    self.theformatted = user.phoneNum
                }
            }
        }
    }
}

//#Preview {
//    SettingsView()
//}

