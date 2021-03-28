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
    @Binding var title: String
    
    @Binding var isEditable: Bool
    
    //MARK: - Body
    var body: some View {
        if isEditable {
            HStack(alignment: .center) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.white)
                    .modifier(TextDropShadow())
                    .frame(width: 30, height: 30)
                    .padding(.horizontal, 10)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        TextField("", text: $title)
                            .font(.title2)
                            .frame(minHeight: 35)
                            .foregroundColor(Color.white)
                            .modifier(TextDropShadow())
                            .padding(0)
                        
                        Spacer()
                        
                        Image(systemName:"pencil")
                            .font(Font.body.weight(.light))
                            .foregroundColor(Color.white)
                            .modifier(TextDropShadow())
                    }//: HSTACK
                    .padding(.vertical, 0)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.white)
                        .padding(0)
                }//: VSTACK
            }//: HSTACK
        }else {
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
}

struct DetailHeaderView_PreviewHelper: View {
    @State private var title: String = "Bank Card"
    @State var isEditable: Bool = true
    
    var body: some View {
        DetailHeaderView(icon: "creditcard", title: $title, isEditable: $isEditable)
    }
}

struct DetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeaderView_PreviewHelper(isEditable: true)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
        
        DetailHeaderView_PreviewHelper(isEditable: false)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
