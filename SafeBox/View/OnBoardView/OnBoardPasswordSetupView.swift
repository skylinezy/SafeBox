//
//  OnBoardPasswordSetupView.swift
//  SafeBox
//
//  Created by Ryan Zi on 9/15/21.
//

import SwiftUI

struct OnBoardPasswordSetupView: View {
    
    @AppStorage("needsAuth") var needsAuth: Bool?
    @AppStorage("isOnBoarding") var isOnBoarding: Bool?
    
    @State var masterPassword: String = ""
    @State var confirmMasterPassword: String = ""
    
    var body: some View {
        VStack() {
            PasswordSetupView(password: $masterPassword, confirmPassword: $confirmMasterPassword)
            
            Button(action:{
                if (masterPassword == confirmMasterPassword) {
                    UserDefaults.standard.set(masterPassword.md5(), forKey: "KMASTER_PASSWORD")
                    needsAuth = false
                    isOnBoarding = false
                }
            }) {
                HStack(){
                    Text("Start")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.blue)
                }
                .padding(15)
                .background(
                    Capsule().strokeBorder(Color.blue, lineWidth: 2.0)
                )
                .accentColor(Color.white)
            }
        }
    }
}

struct OnBoardPasswordSetupView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardPasswordSetupView()
    }
}
