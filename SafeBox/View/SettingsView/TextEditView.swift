//
//  TextEditView.swift
//  SafeBox
//
//  Created by Ryan Zi on 3/31/21.
//

import SwiftUI

struct TextEditView: View {
    var multiLine: Bool = false
    var title: String = "New Value"
    var secured: Bool = false
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(title)
                .padding(.bottom, 5)
            if (multiLine == true) {
                TextEditor(text: $value)
                    .multilineTextAlignment(.leading)
                    .allowsTightening(true)
                    .padding(3.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5.0, style: .circular)
                            .stroke(Color.init(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.3), lineWidth: 0.5)
                    )
            } else {
                if (secured) {
                    SecureField("", text: $value)
                        .font(.title3)
                        .frame(minHeight: 35)
                        .padding(0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                } else {
                    TextField("", text: $value)
                        .font(.title3)
                        .frame(minHeight: 35)
                        .padding(0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            }
            Spacer()
        }
        .padding()
        
    }
}

struct TextEditView_PreviewHelper1: View {
    @State var value: String = "abc"
    var body: some View {
        TextEditView(value: $value)
    }
}

struct TextEditView_PreviewHelper2: View {
    @State var value: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    var body: some View {
        TextEditView(multiLine: true, value: $value)
    }
}

struct TextEditView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditView_PreviewHelper1()
            .previewLayout(.sizeThatFits)
            .padding()
        
        TextEditView_PreviewHelper2()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
