//
//  LoginView.swift
//  SafeBox
//
//  Created by Ryan Zi on 3/28/21.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    
    @State var inputPassword: String = ""
    @State var showAlert: Bool = false
    @State var authenticateMsg: String = ""
    private let context = LAContext()
    
    @AppStorage("needsAuth") var needsAuth: Bool?
    
    var body: some View {
        VStack {
            Spacer()
            Text("SafeBox")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack() {
                    SecureField("Master Password", text: $inputPassword)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(5)
                
                Button(action: {
                    if !validatePassword() {
                        self.authenticateMsg = "Password does not match"
                        self.showAlert = true
                    }
                }) {
                    Image(systemName:"key")
                        .font(.title2)
                        .foregroundColor(Color("BtnBlue"))
                }
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 40)
            
            Button(action: {
                UserDefaults.standard.set(true, forKey: "KBIOMETRICS_ID")
                authenticate()
            }) {
                if (context.biometryType == .faceID) {
                    Image(systemName: "faceid")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color("BtnBlue"))
                } else if (context.biometryType == .touchID) {
                    Image(systemName: "touchid")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color("BtnBlue"))
                }
            }

            Spacer()
        }//: VSTACK
        .padding()
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Error"), message: Text(self.authenticateMsg), dismissButton: .default(Text("Try Again")))
        })
        .onAppear(perform: {
            authenticate()
        })
    }
    
    init() {
    }
    func validatePassword() -> Bool{
        if UserDefaults.standard.object(forKey: "KMASTER_PASSWORD") != nil {
            let storedPassword = UserDefaults.standard.object(forKey: "KMASTER_PASSWORD") as! String
            if (storedPassword == inputPassword.md5()) {
                needsAuth = false
                return true
            }
        }
        return false
    }
    func authenticate() {
        var error: NSError?
        let bioEnabled = UserDefaults.standard.object(forKey: "KBIOMETRICS_ID") as? Bool ?? false
        
        if bioEnabled && context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate to unlock"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:{(success, authenticateError) in
                DispatchQueue.main.async {
                    if success {
                        UserDefaults.standard.set(true, forKey: "KBIOMETRICS_ID")
                        self.needsAuth = false
                    } else {
                        // TODO: Check for error ID and handle properly
                        switch authenticateError!._code {
                        case LAError.appCancel.rawValue:
                            authenticateMsg = authenticateError?.localizedDescription ?? "App canceled"
                        case LAError.authenticationFailed.rawValue:
                            authenticateMsg = "Authenticate failed"
                            self.showAlert = true
                        case LAError.userCancel.rawValue:
                            authenticateMsg = "User canceled authentication"
                        case LAError.userFallback.rawValue:
                            //When two auth attempts failed and promoted to user "Enter Password"
                            UserDefaults.standard.set(false, forKey: "KBIOMETRICS_ID")
                            authenticateMsg = "User choose fallback"
                        case LAError.biometryNotEnrolled.rawValue:
                            UserDefaults.standard.set(false, forKey: "KBIOMETRICS_ID")
                            authenticateMsg = "Biometry authentication not enrolled"
                        default:
                            authenticateMsg = "Other reason"
                        }
                    }
                }
            })
        }//: If
    }
}

struct LoginView_PreviewHelper: View {
    var body: some View {
        LoginView()
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView_PreviewHelper()
            
            LoginView_PreviewHelper()
        }
    }
}
