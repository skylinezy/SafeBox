//
//  DetailItemView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/11/20.
//

import SwiftUI

struct DetailItemView: View {
    //MARK: - Properties
    var icon: String = "globe"
    var title : String
    @State var content: String
    
    @Binding var isEditable: Bool
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 4) {
            HStack{
                Image(systemName: icon)
                    .font(Font.footnote.weight(.light))
                    .foregroundColor(Color.white)
                    .modifier(TextDropShadow())
                
                Text(title)
                    .font(.footnote)
                    .foregroundColor(Color.white)
                    .modifier(TextDropShadow())
                Spacer()
            }//: HSTACK
            
            if isEditable {
                VStack(alignment: .leading, spacing: 0) {
                    HStack{
                        TextField("", text: $content)
                            .font(.title2)
                            .frame(minHeight: 35)
                            .foregroundColor(Color.white)
                            .modifier(TextDropShadow())
                            .padding(0)
                        
                        Spacer()
                        
                        Image(systemName:"pencil")
                            .font(Font.footnote.weight(.light))
                            .foregroundColor(Color.white)
                            .modifier(TextDropShadow())
                    }
                    .padding(.vertical, 0)
                    
                    Rectangle()
                        .frame(width: .infinity, height: 1)
                        .foregroundColor(Color.white)
                        .padding(0)
                }//: HSTACK
            } else {
                VStack(alignment: .leading, spacing: 0){
                    HStack{
                        Text(content)
                            .font(.title2)
                            //.fontWeight(.medium)
                            .multilineTextAlignment(.trailing)
                            .frame(minHeight: 35)
                            .foregroundColor(Color.white)
                            .modifier(TextDropShadow())
                            .padding(0)
                        Spacer()
                    }
                    .padding(.vertical, 0)
                    
                    Rectangle()
                        .frame(width: .infinity, height: 1)
                        .foregroundColor(Color.white)
                        .padding(0)
                }//: HSTACK
            }//: IF
        }//: VSTACK
        
    }
}

struct DetailItemView_PreviewHelper: View {
    var icon: String
    var title: String
    var content: String
    @State var editable: Bool
    
    var body: some View {
        DetailItemView(icon: icon, title: title, content: content, isEditable: $editable)
    }
}

struct DetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        DetailItemView_PreviewHelper(icon: "number", title: "Card Number", content: "1234 3423 3434 4534", editable: false)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
        
        DetailItemView_PreviewHelper(icon: "checkmark.shield", title: "CVV", content: "123", editable: true)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 150, height: 60))
            .padding()
    }
}
