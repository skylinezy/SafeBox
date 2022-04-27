//
//  ListItemView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/13/20.
//

import SwiftUI

struct ListItemView: View {
    //MARK: - Properties
    var title: String
    var icon: String
    var backgroundGradientColors: [Color] = [Color("PrimaryGreen"), Color("PrimaryRed")]
    
    //MARK: - Body
    var body: some View {
        
        HStack(alignment: .center) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.leading, 5)
            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 20)
        .background(LinearGradient(gradient: Gradient(colors:backgroundGradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(12)
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(title: "American Express", icon: "creditcard")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
        
        ListItemView(title: "google.com", icon: "globe")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
