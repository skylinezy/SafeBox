//
//  DetailHeaderView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/11/20.
//

import SwiftUI

struct DetailHeaderView: View {
    //MARK: - Properties
    var icon:  String
    var title: String
    
    //MARK: - Body
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.white)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                .frame(width: 30, height: 30)
                .padding(.horizontal, 10)
                
            Text(title)
                .foregroundColor(Color.white)
                .font(.title2)
                .fontWeight(.bold)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
            
            Spacer()
        }//: HSTACK
    }
}

struct DetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeaderView(icon: "creditcard", title: "Bank Card")
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
