//
//  CredentialDetailView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/12/20.
//

import SwiftUI

struct CredentialDetailView: View {
    //MARK: - Properties
    var data: CredentialModel
    @Environment(\.managedObjectContext) private var managedContext
    
    @State var isEditable: Bool = false
    @State var isDeleting: Bool = false
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 8){
            
            Rectangle()
                .frame(width: 120, height: 6)
                .foregroundColor(.white)
                .cornerRadius(3)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                
            DetailHeaderView(icon: "globe", title: data.website)
                .padding(.horizontal, 10)
                .padding(.vertical, 15)
            
            DetailItemView(icon: "person", title: "Login Username", content: data.username, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            DetailItemView(icon: "key", title: "Login Password", content: data.password, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            DetailItemView(icon: "envelope", title: "Email", content: data.email, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            DetailItemView(icon: "note.text", title: "Note", content: data.note, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            Spacer()
            
            DetailToolbarView(isEditable: $isEditable, isDeleting: $isDeleting)
                .padding(20)
            
        }
        .padding(.vertical, 8)
        .background(LinearGradient(gradient: Gradient(colors:SBGradientColors().Credential), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(20)
        .padding(.horizontal, 10)
    }
}

struct CredentialDetailView_Previews: PreviewProvider {
    static let testData = CredentialModel()
    
    static var previews: some View {
        CredentialDetailView(data: testData)
    }
}
