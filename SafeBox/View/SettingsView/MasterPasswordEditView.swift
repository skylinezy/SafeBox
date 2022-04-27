//
//  SecureTextEditView.swift
//  SafeBox
//
//  Created by Ryan Zi on 8/24/21.
//

import SwiftUI

struct MasterPasswordEditView: View {
    
    @Binding var value: String
    
    @State private var newPassword: String = ""
    @State private var newPasswordConfirm: String = ""
    
    var body: some View {
        VStack(spacing: 10){
            PasswordSetupView(password: $newPassword, confirmPassword: $newPasswordConfirm)
        }
        .navigationBarItems(trailing:
            Button(action:{
                    if newPassword.count > 0 && newPassword == newPasswordConfirm {
                        UserDefaults.standard.set(newPassword.md5(), forKey: "KMASTER_PASSWORD")
                    }
                }) {
                    Image(systemName: "checkmark")
                }
            )
    }
}

struct MasterPasswordEditView_PreviewHelper: View {
    @State var value: String = "123"
    var body: some View {
        MasterPasswordEditView(value: $value)
    }
}

struct MasterPasswordEditView_Previews: PreviewProvider {
    static var previews: some View {
        MasterPasswordEditView_PreviewHelper()
    }
}
