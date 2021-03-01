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
                .modifier(TextDropShadow())
                .frame(width: 30, height: 30)
                .padding(.horizontal, 10)
                
            Text(title)
                .foregroundColor(Color.white)
                .font(.title2)
                .fontWeight(.bold)
                .modifier(TextDropShadow())
            
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
