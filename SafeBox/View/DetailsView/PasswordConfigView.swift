//
//  PasswordConfigView.swift
//  SafeBox
//
//  Created by Ryan Zi on 8/26/21.
//

import SwiftUI

struct OptionButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .frame(height: 25)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(
                Capsule().strokeBorder(Color("BtnBlue"), lineWidth: 2.0)
            )
    }
}

struct PasswordConfigView: View {
    @Binding var length: Float
    @Binding var hasLowercase: Bool
    @Binding var hasUppercase: Bool
    @Binding var hasSymbols: Bool
    @Binding var hasNumbers: Bool
    
    var onConfigChanged: () -> Void
    
    var body: some View {
        VStack(){
            HStack() {
            Stepper(value: $length,
                    in: 4...16,
                    step: 1.0,
                    onEditingChanged: {editing in
                        onConfigChanged()
                    }, label: {Text("\(length, specifier: "%g") characters")})
                Button(action: {
                    onConfigChanged()
                }) {
                    Image(systemName: "shuffle.circle.fill")
                        .font(.title2)
                        .padding(3)
                        .foregroundColor(Color("BtnBlue"))
                }
            }
            
            HStack(spacing: 20){
                Button(action:{
                    hasLowercase.toggle()
                    onConfigChanged()
                }) {
                    Text("a-z")
                        .overlay(
                            Image(systemName: "nosign")
                                .foregroundColor(Color("BtnRed"))
                                .opacity(hasLowercase ? 0.0 : 1.0)
                                .animation(.easeIn(duration: 0.1))
                        )
                }
                .modifier(OptionButtonModifier())
                
                Button(action:{
                    hasUppercase.toggle()
                    onConfigChanged()
                }) {
                    Text("A-Z")
                        .overlay(
                            Image(systemName: "nosign")
                                .foregroundColor(Color("BtnRed"))
                                .opacity(hasUppercase ? 0.0 : 1.0)
                                .animation(.easeIn(duration: 0.1))
                        )
                }
                .modifier(OptionButtonModifier())
                
                Button(action:{
                    hasSymbols.toggle()
                    onConfigChanged()
                }) {
                    Text("$^..")
                        .overlay(
                            Image(systemName: "nosign")
                                .foregroundColor(Color("BtnRed"))
                                .opacity(hasSymbols ? 0.0 : 1.0)
                                .animation(.easeIn(duration: 0.1))
                        )
                }
                .modifier(OptionButtonModifier())
                
                Button(action:{
                    hasNumbers.toggle()
                    onConfigChanged()
                }) {
                    Text("0-9")
                        .overlay(
                            Image(systemName: "nosign")
                                .foregroundColor(Color("BtnRed"))
                                .opacity(hasNumbers ? 0.0 : 1.0)
                                .animation(.easeIn(duration: 0.1))
                        )
                }
                .modifier(OptionButtonModifier())
            }// :HSTACK
            .padding(.vertical, 5)
        }// :VSTACK
        .padding(.vertical, 5)
        .padding(.horizontal, 30)
    }
}

struct PasswordConfigView_PreviewHelper: View {
    @State var n: Float = 8.0
    @State var hasLowercase = true
    @State var hasUppercase = true
    @State var hasSymbols = true
    @State var hasNumbers = true
    
    
    var body: some View {
        PasswordConfigView(length: $n, hasLowercase: $hasLowercase, hasUppercase: $hasUppercase, hasSymbols: $hasSymbols, hasNumbers: $hasNumbers, onConfigChanged: {})
    }
}

struct PasswordConfigView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordConfigView_PreviewHelper()
    }
}
