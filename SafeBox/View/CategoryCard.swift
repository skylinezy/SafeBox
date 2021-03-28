//
//  CategoryCard.swift
//  SafeBox
//
//  Created by Ryan Zi on 12/10/20.
//

import SwiftUI

struct CategoryCard: View {
    
    var icon : String
    var title: String
    var backgroundGradientColors: [Color]
    
    var body: some View {
        HStack(){
            Image(systemName: icon)
                .font(Font.system(size: 24, weight: .regular))
                .foregroundColor(Color.white)
                .frame(width: 32, height: 30)
                .modifier(TextDropShadow())
            Text(title)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .modifier(TextDropShadow())
            Spacer()
            
        }
        .padding()
        .frame(width: 320)
        .background(LinearGradient(gradient: Gradient(colors:backgroundGradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(10)
    }
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard(icon: "globe", title: "Credential", backgroundGradientColors: SBColors().BankCard)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
