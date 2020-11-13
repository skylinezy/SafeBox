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
    var backgroundGradientColors: [Color] = [Color("PrimaryPurple"), Color("PrimaryBlue")]
    
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
            
            DetailItemView(title: "Login Username", content: data.username)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            DetailItemView(title: "Login Password", content: data.password)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            DetailItemView(title: "Email", content: data.email)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            DetailItemView(title: "Note", content: data.note)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            Spacer()
            
        }
        .padding(.vertical, 8)
        .background(LinearGradient(gradient: Gradient(colors:backgroundGradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(20)
        .padding(.horizontal, 8)
    }
}

struct CredentialDetailView_Previews: PreviewProvider {
    static let testData = CredentialModel()
    
    static var previews: some View {
        CredentialDetailView(data: testData)
    }
}
