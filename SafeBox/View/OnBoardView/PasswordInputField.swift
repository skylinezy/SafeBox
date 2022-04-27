//
//  PasswordInputField.swift
//  SafeBox
//
//  Created by Ryan Zi on 9/13/21.
//

import SwiftUI

struct PasswordInputField: View {
    @State private var isSecureField: Bool = true
    
    var label: String = ""
    @Binding var text: String
    
    var onChange: ((String) -> Void)? = nil
    
    var body: some View {
        HStack() {
            if isSecureField {
                SecureField(label, text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(5)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .onChange(of: text) { newText in
                        if onChange != nil {onChange!(newText)}
                    }
            } else {
                TextField(label, text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(5)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .onChange(of: text) { newText in
                        if onChange != nil {onChange!(newText)}
                    }
            }
            
            Button(action: {
                isSecureField.toggle()
            }) {
                Image(systemName: isSecureField ? "eye" : "eye.slash")
                    .font(.title3)
                    .foregroundColor(Color.blue)
            }
        }
    }
}

struct PasswordInputField_PreviewHelper: View {
    @State var password: String = ""
    var body: some View {
        PasswordInputField(label: "Enter Password", text: $password)
    }
}

struct PasswordInputField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordInputField_PreviewHelper()
    }
}
