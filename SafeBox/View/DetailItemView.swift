//
//  DetailItemView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/11/20.
//

import SwiftUI

struct DetailItemView: View {
    //MARK: - Properties
    var title : String
    var content: String
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 4) {
            HStack{
                Text(title)
                    .font(.footnote)
                    .foregroundColor(Color.white)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                Spacer()
            }
            HStack{
                
                Text(content)
                    .font(.title2)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color.white)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                Spacer()
                    
            }
        }
    }
}

struct DetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        DetailItemView(title: "Card Number", content: "1234 3423 3434 4534")
            .previewLayout(.sizeThatFits)
            .padding()
        
        DetailItemView(title: "CVV", content: "123")
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 150, height: 60))
            .padding()
    }
}
