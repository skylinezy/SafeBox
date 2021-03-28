//
//  CategoryFilterView.swift
//  SafeBox
//
//  Created by Ryan Zi on 3/24/21.
//

import SwiftUI

struct CategoryFilterView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                Button(action: {
                    
                }) {
                    Text("Credentials")
                        .font(.body)
                        .foregroundColor(.white)
                        .frame(width: 100)
                        .padding(8)
                        .background(SBColors().gradientColorWith(type: .Credential))
                        .cornerRadius(8)
                    
                }
                
                Button(action: {
                    
                }) {
                    Text("Bank Cards")
                        .font(.body)
                        .foregroundColor(.white)
                        .frame(width: 100)
                        .padding(8)
                        .background(SBColors().gradientColorWith(type: .BankCard))
                        .cornerRadius(8)
                }
                
                Button(action: {
                    
                }) {
                    Text("Notes")
                        .font(.body)
                        .foregroundColor(.white)
                        .frame(width: 100)
                        .padding(8)
                        .background(SBColors().gradientColorWith(type: .Note))
                        .cornerRadius(8)
                }
                
                Button(action: {
                    
                }) {
                    Text("Licenses")
                        .font(.body)
                        .foregroundColor(.white)
                        .frame(width: 100)
                        .padding(8)
                        .background(SBColors().gradientColorWith(type: .License))
                        .cornerRadius(8)
                }
            }//: HSTACK
            .frame(maxWidth: .infinity)
        }//: SCROLLVIEW
        .padding(.horizontal, 3)
        .padding(.vertical, 12)
        
    }
}

struct CategoryFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryFilterView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
