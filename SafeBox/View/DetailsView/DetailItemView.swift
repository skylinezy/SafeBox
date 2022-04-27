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
    @Binding var content: String
    @Binding var isEditable: Bool
    
    var accessoryView: AnyView?
    
    // Callback when content changes
    var onChange: ((String) -> Void)? = nil
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 4) {
            HStack{
                Image(systemName: icon)
                    .font(Font.footnote.weight(.light))
                
                Text(title)
                    .font(.footnote)
                Spacer()
            }//: HSTACK, The header
            
            if isEditable {
                VStack(alignment: .leading, spacing: 0) {
                    HStack{
                        TextField("", text: $content)
                            .font(.title2)
                            .frame(minHeight: 35)
                            .padding(0)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .onChange(of: content) { newText in
                                if onChange != nil {onChange!(newText)}
                            }
                        Spacer()
                        
                        Image(systemName:"pencil")
                            .font(Font.footnote.weight(.light))
                    }
                    .padding(.vertical, 0)
                    
                    Rectangle()
                        .frame(height: 1)
                        .padding(0)
                    
                    if accessoryView != nil {
                        accessoryView
                            .padding(5)
                    }
                }//: HSTACK
            } else {
                VStack(alignment: .leading, spacing: 0){
                    HStack{
                        Text(content)
                            .font(.title2)
                            .multilineTextAlignment(.trailing)
                            .frame(minHeight: 35)
                            .padding(0)
                        Spacer()
                    }
                    .padding(.vertical, 0)
                    
                    Rectangle()
                        .frame(height: 1)
                        .padding(0)
                }//: HSTACK
            }//: IF
        }//: VSTACK
        
    }
}

struct DetailItemView_PreviewHelper: View {
    var icon: String
    var title: String
    @State var content: String
    @State var editable: Bool
    
    var body: some View {
        DetailItemView(icon: icon, title: title, content: $content, isEditable: $editable, accessoryView: AnyView(Text("Helper")))
    }
}

struct DetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        DetailItemView_PreviewHelper(icon: "number", title: "Card Number", content: "1234 3423 3434 4534", editable: false)
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
            .padding()
        
        DetailItemView_PreviewHelper(icon: "checkmark.shield", title: "CVV", content: "123", editable: true)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
