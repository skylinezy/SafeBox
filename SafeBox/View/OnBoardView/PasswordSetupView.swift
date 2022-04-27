//
//  OnboardView.swift
//  SafeBox
//
//  Created by Ryan Zi on 8/19/21.
//

import SwiftUI

struct PasswordPolicy: OptionSet {
    let rawValue: Int8
    
    static let hasUppercase = PasswordPolicy(rawValue: 1<<0)
    static let hasLowercase = PasswordPolicy(rawValue: 1<<1)
    static let hasNumber    = PasswordPolicy(rawValue: 1<<2)
    static let hasSymbol    = PasswordPolicy(rawValue: 1<<3)
}

struct PasswordSetupView: View {
    
    @Binding var password: String
    @Binding var confirmPassword: String
    
    var policy: PasswordPolicy = [.hasUppercase, .hasLowercase, .hasNumber, .hasSymbol]
    @State var policyMeet: PasswordPolicy = []
    var minLength: Int = 8
    
    let lc = "abcdefghijklmnopqrstuvwxyz"
    let uc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let nb = "0123456789"
    let sb = "~`!@#$%^&*()-_=+{}[]:;<>,.?/"
    
    func checkPassword() -> Void {
        policyMeet = []
        for l in password {
            if lc.contains(l) {policyMeet.insert(.hasLowercase)}
            if uc.contains(l) {policyMeet.insert(.hasUppercase)}
            if nb.contains(l) {policyMeet.insert(.hasNumber)}
            if sb.contains(l) {policyMeet.insert(.hasSymbol)}
        }
    }
    
    var body: some View {
        
        VStack(){
            PasswordInputField(label: "Enter Password", text: $password, onChange: { _ in
                checkPassword()
            })
            .padding(.horizontal, 10)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack() {
                    Image(systemName: "checkmark.circle")
                        .font(.footnote)
                        .foregroundColor(.green)
                        .opacity(password.count >= minLength ? 1.0 : 0.0)
                    Text("Must be \(minLength) characters or longer")
                        .font(.footnote)
                        .foregroundColor(password.count >= minLength ? .green : .red)
                        .opacity(1.0)
                }
                
                if policy.contains(.hasUppercase) {
                    HStack() {
                        Image(systemName: "checkmark.circle")
                            .font(.footnote)
                            .foregroundColor(.green)
                            .opacity(policyMeet.contains(.hasUppercase) ? 1.0 : 0.0)
                        Text("Must contain at least 1 upper case")
                            .font(.footnote)
                            .foregroundColor(policyMeet.contains(.hasUppercase) ? .green : .red)
                    }
                }
                
                if policy.contains(.hasLowercase) {
                    HStack() {
                        Image(systemName: "checkmark.circle")
                            .font(.footnote)
                            .foregroundColor(.green)
                            .opacity(policyMeet.contains(.hasLowercase) ? 1.0 : 0.0)
                        Text("Must contain at least 1 lower case")
                            .font(.footnote)
                            .foregroundColor(policyMeet.contains(.hasLowercase) ? .green : .red)
                        
                    }
                }
                
                if policy.contains(.hasNumber) {
                    HStack() {
                        Image(systemName: "checkmark.circle")
                            .font(.footnote)
                            .foregroundColor(.green)
                            .opacity(policyMeet.contains(.hasNumber) ? 1.0 : 0.0)
                        Text("Must contain at least 1 number")
                            .font(.footnote)
                            .foregroundColor(policyMeet.contains(.hasNumber) ? .green : .red)
                        
                    }
                }
                
                if policy.contains(.hasSymbol) {
                    HStack() {
                        Image(systemName: "checkmark.circle")
                            .font(.footnote)
                            .foregroundColor(.green)
                            .opacity(policyMeet.contains(.hasSymbol) ? 1.0 : 0.0)
                        Text("Must contain at least 1 symbol")
                            .font(.footnote)
                            .foregroundColor(policyMeet.contains(.hasSymbol) ? .green : .red)
                        
                    }
                }
            }
            
            PasswordInputField(label: "Re-Enter Password", text: $confirmPassword)
                .padding(.horizontal, 10)
            
            HStack() {
                Image(systemName: "checkmark.circle")
                    .font(.footnote)
                    .foregroundColor(.green)
                    .opacity((password.count > 0 && password == confirmPassword) ? 1.0 : 0.0)
                Text("Password match")
                    .font(.footnote)
                    .foregroundColor((password.count > 0 && password == confirmPassword) ? .green : .red)
                    .opacity((password.count > 0 && password == confirmPassword) ? 1.0 : 0.0)
            }
        }
    }
}

struct PasswordSetupView_PreviewHelper: View {
    
    @State var masterPassword: String = ""
    @State var confirmMasterPassword: String = ""
    
    var body: some View {
        PasswordSetupView(password: $masterPassword, confirmPassword: $confirmMasterPassword)
    }
}

struct PasswordSetupView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordSetupView_PreviewHelper()
            
            
    }
}
