//
//  RoundedListSection.swift
//  SafeBox
//
//  Created by Ryan Zi on 9/8/21.
//

import SwiftUI

struct RoundedListSection<Content>: View where Content: View {
    var header: String? = nil
    var footer: String? = nil
    var backgroundColor: Color = Color("BtnBlueLight")
    var items: Content
    
    init(header: String, @ViewBuilder content: () -> Content) {
        self.header = header
        self.items = content()
    }
    
    init(footer: String, @ViewBuilder content: () -> Content) {
        self.footer = footer
        self.items = content()
    }
    
    init(header: String, footer: String, @ViewBuilder content: () -> Content) {
        self.header = header
        self.footer = footer
        self.items = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if header != nil {
                Text(header!)
                    .font(.title2)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    
            }
            
            items
            
            if footer != nil {
                Text(footer!)
                    .font(.footnote)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
            }
        }
        .padding(10)
        .background(backgroundColor)
        .cornerRadius(20)
    }
}

struct RoundedListSection_Previews: PreviewProvider {
    static var previews: some View {
        let header = "Test"
        
        RoundedListSection(header: header, footer: "3 items") {
            Text("Item1 sfg sdfg dag seerg aer efg erg")
            Text("Item2")
        }
        
    }
}
