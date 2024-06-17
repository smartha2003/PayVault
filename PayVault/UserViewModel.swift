//
//  UserViewModel.swift
//  PayVault
//
//  Created by Shubhada Martha on 1/31/24.
//
import SwiftUI
import Combine

@MainActor //Gets rid of the purple Error
class UserViewModel: ObservableObject { //ObservableObject allows us to access it from different views
    @Published var username: String?
    @Published var authToken: String?
    @Published var phoneNum: String
    @Published var OTPcode: String = ""
    @Published var time: TimeInterval = 0
    @Published var user: User?
    
    let authTokenError = ApiError(errorCode: "authToken_error", message: "Could not fetch authToken")
    let unknownError = ApiError(errorCode: "unknown_client_error", message: "An unknown error happened client side")
    
    init() {
        self.phoneNum = ""
    }
    
    // Function to set the authToken
    func setAuthToken(token: String?) {
        self.authToken = token
    }

    // Function to set the phoneNumber
    func setPhoneNumber(number: String) {
        self.phoneNum = number
    }

    // Function to set the username
    func setUsername(name: String?) {
        self.username = name
    }
    
    // Function to set the otp
    func setOTP(otp: String) {
        self.OTPcode = otp
    }
    
    // Function to update user info based on user input
    func updateUserAttributes(username: String?, authToken: String?, phoneNum: String) {
        setUsername(name: username)
        setAuthToken(token: authToken)
        setPhoneNumber(number: phoneNum)
    }
    
    //checks otp and Sets the token to disk
    func checkOTP(phone: String) async -> Result<String, Error> {
        //calls api checkverification function and saves otp + authToken to disk
        do {
            let checkCode = try await Apiapi.checkVerificationToken(e164PhoneNumber: phone, code: self.OTPcode)
                //setOTP(otp: codeString)
                //setAuthToken(token: checkCode.authToken)
            //UserDefaults.standard.set(self.OTPcode, forKey: "otpCode") //saves otp to disk
            saveOTPCode(otp: self.OTPcode)
                //UserDefaults.standard.set(checkCode.authToken, forKey: "authToken")
            saveAuthToken(token: checkCode.authToken)
                return .success(checkCode.authToken)
            } catch {
                // Handle the error here
                print("Invalid OTP")
                return .failure(error)
            }
    }
    
    //Saves the username to disk
    func saveAuthToken(token: String) {
        UserDefaults.standard.set(token, forKey: "authToken")
    }
    
    //Saves the username to disk
    func saveUserName(userName: String) {
        UserDefaults.standard.set(userName, forKey: "userName")
    }
    
    //Saves the phonenumber to disk
    func savephoneNumber(phone: String) {
        UserDefaults.standard.set(phone, forKey: "phoneNumber")
        
    }
    
    //Saves the OTP to disk
    func saveOTPCode(otp: String) {
        UserDefaults.standard.set(otp, forKey: "otpCode")
        
    }

    func fetchAuthToken() -> String?{
        let token = UserDefaults.standard.string(forKey: "authToken")
        return token
    }
        
        //loaduserinfo
    func loadUserInfo() {
        //gets token from disk after old user logs in and saves it to the user self.whatever =
        self.authToken = fetchAuthToken()
    }
        
        //logout would i need to remove user attribute info too? MIGHT NEED TO UPDATE W OTHER THINGS
    func logout() {
        // Reset authentication-related properties
        self.authToken = nil
        self.username = nil

        // Remove the authentication token from UserDefaults
        UserDefaults.standard.removeObject(forKey: "authToken")
        UserDefaults.standard.removeObject(forKey: "userName")
        //synchronize
    }
    
    func fetchAccountDetails(authToken: String) {
            Task {
                do {
                    let userResponse = try await Api.shared.user(authToken: authToken)
                    self.username = userResponse.user.name
                } catch {
                    print("Error fetching account")
                }
            }
        }
    
    func findTime() async throws{
        let begin = Date()
        Task {
            do {
//                let begin = Date()
                let checkCode = try await Apiapi.checkVerificationToken(e164PhoneNumber: self.phoneNum, code: self.OTPcode)
                guard let checkCode = try? await Apiapi.checkVerificationToken(e164PhoneNumber: self.phoneNum, code: self.OTPcode) else {
                    throw authTokenError
                }
//                let end = Date()
//                let totalTime = end.timeIntervalSince(begin)
                UserDefaults.standard.set(checkCode.authToken, forKey: "authToken")
                //UserDefaults.standard.set(totalTime, forKey: "Time")
            } catch {
                // Handle the error here
                print("Error findtime")
            }
            let end = Date()
            let totalTime = end.timeIntervalSince(begin)
            UserDefaults.standard.set(totalTime, forKey: "Time")
        }
    }
    
    func getTime() {
        if let time = UserDefaults.standard.double(forKey: "Time") as? Double {
            self.time = time
        } else {
            print("Error fetching time")
        }
    }
    
    //Sets user
    func saveUser(authToken: String) async throws {
        guard let userResponse = try? await Apiapi.user(authToken: authToken) else {
                // Handle the error here
            print("No saved user")
            print(authToken)
                throw authTokenError
            }
        print("saved user")
        print(userResponse)
        self.user = userResponse.user
    }
    
    //send otp
    func sendCode() {
        Task {
            do {
                let _ = try await Apiapi.sendVerificationToken(e164PhoneNumber:
                                                                self.phoneNum)
                print(self.phoneNum)
            } catch {
                print("Error sending otp")
            }
        }
    }
    
    //    //needs †o set user info to the things in the class?
    //    func setUserInfo(authToken: String, name: String) async {
    //        do {
    //            _ = try await Apiapi.setUserName(authToken: authToken, name: name)
    //
    //        } catch {
    //            // Handle the error here
    //            print("Error SetUserInfo")
    //        }
    //    }
    
}
