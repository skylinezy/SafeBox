//
//  ListEditView.swift
//  SafeBox
//
//  Created by Ryan Zi on 3/31/21.
//

import SwiftUI

struct ListEditView: View {
    @Binding var items : [String]
    var navBarTitle: String = "Default"
    
    var body: some View {
            List() {
                ForEach(items, id: \.self) { item in
                    HStack() {
                        Button(action: {
                            // Enable editing of that item
                        }) {
                            Text(item)
                                .foregroundColor(.white)
                                .lineLimit(2)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 5)
                                .background(Color("PrimaryBlue"))
                                .mask(
                                    RoundedRectangle(cornerRadius: 8.0, style: .circular)
                                )
                            
                        }//: BUTTON
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal, 20)
                        
                        Spacer()
                        
                        Button(action: {
                            items.remove(at: items.firstIndex(of: item)!)
                        }) {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(Color("BtnRed"))
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal, 15)
                    }
                    .padding(.vertical, 5)
                }//: LOOP
                .listStyle(DefaultListStyle())
                .modifier(NoListSeparator())
            }//: LIST
    }
}

struct ListEditView_PreviewHelper: View {
    @State var items: [String] = ["Item1", "Item2adfashjbjkhbljhbkjhbkhbkjhbkjhbjhbdfas", "Item3", "Item4"]
    var body: some View {
        NavigationView {
            ListEditView(items: $items)
        }
    }
}

struct ListEditView_Previews: PreviewProvider {
    static var previews: some View {
        ListEditView_PreviewHelper()
            //.previewLayout(.sizeThatFits)
            //.padding()
    }
}
