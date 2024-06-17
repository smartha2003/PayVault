//
//  VerificationView.swift
//  PayVault
//
//  Created by Shubhada Martha on 1/24/24.
//

//IMPLEMENTED TEXTFIELD THAT FITS HW2 BUT STILL NEED TO INTEGRATE THIS WITH HW3
import SwiftUI

struct VerificationView: View {
    @State private var code = "" //store in E64 format
    @State private var text = ""
    @State private var showingErrorOPTMsg = false
    
    let numFields: Int
    @State var enterVal: [String] //store in E64 format
    @FocusState private var isFocused:  Int?
    let checkingCode = ""
    @State private var codeIsGood = false
    @EnvironmentObject var user : UserViewModel
    @State var theformatted: String = ""
    
//    @State var first: String = ""
//    @State var second: String = ""
//    @State var third: String = ""
//    @State var fourth: String = ""
//    @State var fifth: String = ""
//    @State var sixth: String = ""
//    @State var isLoading = false
//    @State var errorString: String?
//    @FocusState var focused
    
    init(numFields: Int) {
        self.numFields = numFields
        self.enterVal = Array(repeating: "\u{200B}", count: numFields)
        self.theformatted = ""
    }
    
//    func onCodeChange() async throws -> String{
//        errorString = nil
//        let digits = [$first, $second, $third, $fourth, $fifth, $sixth]
//        for digit in digits {
//            digit.wrappedValue = ""
//        }
//        
//        for (digit, char) in zip(digits, code) {
//            digit.wrappedValue = String(char)
//        }
//        
//        guard code.count == 6 else { return ""}
//        Task {
//            isLoading = true
//                do {
//                    let response = try await Api.shared.checkVerificationToken(e164PhoneNumber: theformatted, code: code)
//                    print("we're logged in")
//                    isLoading = false
//                    return response
//                } catch let apiError as ApiError {
//                    errorString = apiError.message
//                    isLoading = false
//                    throw apiError // Re-throw the error to be handled by the caller
//                }
//        }
//    }
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                VStack {
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
                    
                    //Instruction to tell users what to do
                    Text("What's the code?")
                        .bold()
                        .font(.title2)
                        .foregroundColor(Color("DarkBrown"))
                    
                    //Instruction to tell users what to do
                    Text("Enter the code sent to \(user.phoneNum)")
                        .font(.title3)
                        .foregroundColor(Color("DarkBrown"))
                    
                    //IMPLEMENTED TEXTFIELD THAT FITS HW2 BUT STILL NEED TO INTEGRATE THIS WITH HW3
//                    VStack {
//                        TextField("", text: $code)
//                            .keyboardType(.numberPad)
//                            .focused($focused)
//                            .foregroundColor(.clear)
//                            .tint(.clear)
//                            .onChange(of: code) {
//                                do {
//                                        let response = try await onCodeChange()
//                                        // Handle the response if needed
//                                    } catch {
//                                        // Handle the error
//                                        print("Error: \(error)")
//                                    }
//                            }
////                        Text("What's the code?").bold()
////                        let phoneNumberString = user.phoneNum
////                        Text("Enter the code we sent to \(phoneNumberString)")
//                        HStack {
//                            DigitText(char: $first)
//                            DigitText(char: $second)
//                            DigitText(char: $third)
//                            DigitText(char: $fourth)
//                            DigitText(char: $fifth)
//                            DigitText(char: $sixth)
//                        }
//                        let _ = print(code)
//                        if let errorString = errorString {
//                            Text(errorString).foregroundStyle(.red)
//                        } else {
//                            Text("OTP accepted")
//                            .task {
//                                let _ = print(theformatted)
//                                let _ = user.setOTP(otp: code) //sets otp to class
//                                let result = await user.checkOTP(phone: theformatted) //checks validity of otp, saves otp and authToken to disk
//                            //                                            let token = user.fetchAuthToken() //fetches authToken from disk
//                            //                                            user.setAuthToken(token: token) //sets authToken to class
//                            
//                                switch result { //based on the validity of the otp entered changes states
//                                case .success:
//                                    let token = user.fetchAuthToken() //fetches authToken from disk
//                                    let _ = user.setAuthToken(token: token) //sets authToken to class
//                                    codeIsGood = true
//                            
//                                case .failure(let error):
//                                    showingErrorOPTMsg = true
//                                    let _ = print(showingErrorOPTMsg)
//                                let _ = print("CheckCode Error: \(error.localizedDescription)")
//                                    codeIsGood = false
//                            }
//                        }
//                    }
//                        if isLoading {
//                            ProgressView()
//                        } else {
//                            ProgressView().tint(.clear)
//                        }
//                        
//                        //resends otp
//                        Button ("Resend Code") {
//                            user.sendCode()
//                            //sendCode(num: theformatted)
//                        }
//                        .padding()
//                        .background(Color("SlimeGreen"))
//                        .foregroundColor(Color("LightPeach"))
//                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
//                        
//                        Spacer(minLength: 200)
//                        
//                        Text("HW 2 - Shubhada Martha ECS 189E")
//                            .font(.caption)
//                            .padding()
//                            .foregroundColor(Color("DarkBrown"))
//                    }
//                    .onAppear {
//                        focused = true
//                    }
//                    .fullScreenCover(isPresented: $codeIsGood) {
//                        HomeView() .environmentObject(user)
//                    }
//                }
                    
                    //OTP Styled textfield
                    HStack {
                        ForEach(0..<numFields, id: \.self) { index in
                            TextField("", text: $enterVal[index])
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color.darkBrown.opacity(0.1))
                                .frame(width: 48, height: 48)
                                .cornerRadius(5.0)
                                .multilineTextAlignment(.center)
                                .focused($isFocused, equals: index)
                                .tag(index)
                                .onChange(of: enterVal[index]) { //when the user types move the cursor accordingly
                                    if enterVal[index].count == 2 && index < 5 { //moving forward
                                        isFocused = (isFocused ?? 0) + 1
                                    } else if enterVal[index].count == 0 && index > 0 { //moving backward
                                        enterVal[index] = "\u{200B}"
                                        isFocused = (isFocused ?? 0) - 1
                                    }
                                    if index == 5 && enterVal[index].count == 2 { //entered otp correct format
                                        let combinedString = enterVal.joined().filter{$0 != "\u{200B}"}
                                        isFocused = nil
                                        //verify code
                                        Task { 
                                            print("CheckCode works")
                                            print(theformatted)
                                            print(combinedString)
                                            user.setOTP(otp: combinedString) //sets otp to class
                                            let result = await user.checkOTP(phone: theformatted) //checks validity of otp, saves otp and authToken to disk
//                                            let token = user.fetchAuthToken() //fetches authToken from disk
//                                            user.setAuthToken(token: token) //sets authToken to class
                                    
                                            switch result { //based on the validity of the otp entered changes states
                                                case .success:
                                                    let token = user.fetchAuthToken() //fetches authToken from disk
                                                    user.setAuthToken(token: token) //sets authToken to class
                                                    if let token = user.fetchAuthToken() {
                                                        try await user.saveUser(authToken: token)
                                                        print(user.user)
                                                    } else {
                                                        print("Error: AuthToken is nil")
                                                    }
                                                    codeIsGood = true
                                                
                                                case .failure(let error):
                                                    showingErrorOPTMsg = true
                                                    print(showingErrorOPTMsg)
                                                    print("CheckCode Error: \(error.localizedDescription)")
                                                    codeIsGood = false
                                            }
                                        }
                                    }
                                    
                                }
                                .alert(isPresented: $showingErrorOPTMsg, content: { //alerts user of the invalidity of the otp
                                    Alert(title:
                                            Text("Invalid OTP Code"), dismissButton:
                                            .default(Text("Click Resend code!")))
                                })

                        }
                    }.ignoresSafeArea(.keyboard) //Ensures the Keyboard to not move the view
                        .padding()
                    
//                        .navigationDestination(isPresented: $codeIsGood) {
//                            HomeView(phonenum: $theformatted) .environmentObject(user)
//                        }
                        .fullScreenCover(isPresented: $codeIsGood) {
                            HomeView() .environmentObject(user)
                        }
                    
                    //resends otp code
                    Button ("Resend Code") {
                        user.sendCode()
                        //sendCode(num: theformatted)
                    }
                    .padding()
                    .background(Color("SlimeGreen"))
                    .foregroundColor(Color("LightPeach"))
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    
                    Spacer(minLength: 200)
                    
                    Text("HW 2 - Shubhada Martha ECS 189E")
                        .font(.caption)
                        .padding()
                        .foregroundColor(Color("DarkBrown"))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .containerRelativeFrame([.horizontal, .vertical])
                .edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true)
                .onTapGesture {
                    //Dismisses the keyboard if you click away
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .onAppear {
                    // Access user instance after it's fully initialized
                    self.theformatted = user.phoneNum
                }
                .padding()
            }
            .ignoresSafeArea(.keyboard)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Gradient(colors: [.teal, .cyan, .green]).opacity(0.6))
        }
    }


//struct DigitText: View {
//    @Binding var char: String
//    
//    var body: some View {
//        ZStack {
//            Text(char)
//                .frame(width: 48, height: 48)
//            Rectangle()
//                .frame(width: 48, height: 48)
//                .foregroundColor(.gray.opacity(0.5))
//                .background(Color.darkBrown.opacity(0.1))
//                .cornerRadius(5.0)
//        }
//        VStack {
//            Text(char).frame(width: 30, height: 30)
//            Rectangle().frame(width: 30, height: 30).foregroundColor(.gray.opacity(0.5)).background(Color.darkBrown.opacity(0.1))
//                                            //.frame(width: 48, height: 48)
//                                            .cornerRadius(5.0)
//        }
//    }
}

func getCurrCount(val: Array<String>) -> Int {
    var count = 0
        for v in val {
            if(v != ""){
                count += 1
            }
        }
    return count
}
