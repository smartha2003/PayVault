//
//  ContentView.swift
//  PayVault
//
//  Created by Shubhada Martha on 1/16/24.
//

import SwiftUI
import PhoneNumberKit

let Apiapi = Api(appId: "QSQEo5xSmENL")
//var formatted: String = ""

struct LogInScreenView: View {
    let phoneNumberKit = PhoneNumberKit()
    @State private var phoneNumber = "" //store in E64 format
    @State var formatted = ""
    @FocusState private var isPhoneNumberFocused: Bool // managed by swift ui
    @State private var text = ""
    @State private var showingErrorMsg = false
    @State private var isCodeSent = false // Track whether the code is sent successfully
    @EnvironmentObject var user : UserViewModel
    
    //Login Screen
    var body: some View {
        NavigationStack {
            GeometryReader { _ in
                ZStack {
                    VStack {
                        VStack(spacing: -100) {
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
                        }
                        
                        //Instruction to tell users what to do
                        Text("Enter your US mobile number")
                            .font(.title3)
                            .foregroundColor(Color("DarkBrown"))
                            
                        //Formats the user input textfield with error checks, button to send OPT, and displays the +1 for country code
                        HStack {
                            Text("+ 1")
                                .padding()
                                .background(Color("SlimeGreen"))
                                .foregroundColor(Color("LightPeach"))
                                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                
                            // User input for phone number
                            ZStack {
                                TextField("(669) 123 - 123", text: $phoneNumber)
                                    .keyboardType(.numberPad)
                                    .focused($isPhoneNumberFocused)
                                    .onTapGesture {
                                        isPhoneNumberFocused = true
                                    }
                                    .onChange(of: phoneNumber) {
                                        let num = PartialFormatter().formatPartial(phoneNumber)
                                            phoneNumber = num
                                    }
                                    .padding()
                                    .background(Color.clear)
                                    .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(Color("DarkBrown"))).frame(width: 200)
                            }
                            .ignoresSafeArea(.keyboard) //Ensures the Keyboard to not move the view
                            .padding()
                        }

                        
                        Button ("Send Code") {
                            do {
                                let parsed = try phoneNumberKit.parse(phoneNumber) //checks validity of phone number
                                formatted = phoneNumberKit.format(parsed, toType: .e164) //formats the phonenumber into +61236618300
                                user.setPhoneNumber(number: formatted) //sets phone number to class
                                user.savephoneNumber(phone: formatted) //saves the phone number to disk
                                user.sendCode() //sends opt
                                //sendCode(num: formatted) //sends opt
                                isCodeSent = true
                                print(parsed)
                                print(formatted)
                            } catch {
                                showingErrorMsg = true
                            }
                            // Dismisses the keyboard when the "Send Code" button is tapped
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        .padding()
                        .background(Color("SlimeGreen"))
                        .foregroundColor(Color("LightPeach"))
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                        .alert(isPresented: $showingErrorMsg) { //Alerts the user of invalid phone number
                                Alert(title:
                                        Text("Invalid Phone Number"), dismissButton:
                                        .default(Text("I'll fix it!")))
                        }
                        
//                        .navigationDestination(isPresented: $isCodeSent) {
//                                VerificationView(theformatted: $formatted, numFields: 6)
//                        }
                        
                        .fullScreenCover(isPresented: $isCodeSent) {
                            VerificationView(numFields: 6).environmentObject(self.user)
                        }
                        
                        Spacer(minLength: 200)
                        
                        //Bottom Footer of My information
                        Text("HW 1 - Shubhada Martha ECS 189E")
                            .font(.caption)
                            .padding()
                            .foregroundColor(Color("DarkBrown"))
        
                        Spacer()
                    }
                
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .ignoresSafeArea(.keyboard)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Gradient(colors: [.teal, .cyan, .green]).opacity(0.6))
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
            .onTapGesture {
                //Dismisses the keyboard if you click away
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

//func sendCode(num : String) {
//    Task {
//        do {
//            let _ = try await Apiapi.sendVerificationToken(e164PhoneNumber:
//            num)
//            print(num)
//        } catch {
//            print("Error sending otp")
//        }
//    }
//}

//#Preview {
//    LogInScreenView()
//}
 
