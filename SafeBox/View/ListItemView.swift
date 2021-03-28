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
        HStack {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.white)
                        //.shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                        .frame(width: 20, height: 20)
                        .padding(.horizontal, 4)
                    Text(title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    //.shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                    Spacer()
                }
                .padding(.top, 8)
                
                VStack(alignment: .leading, spacing: 10){
                    Rectangle()
                        .fill(Color(red:0.9, green: 0.9, blue: 0.9, opacity: 0.9))
                        .frame(minWidth: 200, maxWidth: 350, minHeight: 12, maxHeight: 12)
                        .cornerRadius(2)
                    
                    Rectangle()
                        .fill(Color(red:0.9, green: 0.9, blue: 0.9, opacity: 0.9))
                        .frame(minWidth: 160, maxWidth: 250, minHeight: 12, maxHeight: 12)
                        .cornerRadius(2)
                    
                    //Rectangle()
                    //    .fill(Color(red:0.9, green: 0.9, blue: 0.9, opacity: 0.9))
                    //    .frame(minWidth: 180, maxWidth: 280, minHeight: 12, maxHeight: 12)
                    //    .cornerRadius(2)
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
            }//: VSTACK
            .padding(.horizontal, 25)
            .padding(.vertical, 10)
            .background(LinearGradient(gradient: Gradient(colors:backgroundGradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(12)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(title: "American Express", icon: "creditcard")
            .previewLayout(.sizeThatFits)
            .padding()
        
        ListItemView(title: "google.com", icon: "globe")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
