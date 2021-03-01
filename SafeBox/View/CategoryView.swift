//
//  CategoryView.swift
//  SafeBox
//
//  Created by Ryan Zi on 12/9/20.
//

import SwiftUI

struct CategoryView: View {
    
    @Environment(\.managedObjectContext) private var managedContext
    
    let categories: [Category] = Bundle.main.decode("category.json")
    
    @State private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
    @Binding var newItemType: Int
    
    var body: some View {
        
        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
            ForEach(categories) { item in
                
                Button(action: {
                    self.newItemType = item.id
                }) {
                    CategoryCard(icon: item.icon, title: item.name, backgroundGradientColors: SBGradientColors().colorWith(name: item.backgroundColorName))
                        .modifier(ViewDropShadow())
                }
            }//: LOOP
        }//: GRID
        .animation(.easeIn)
    }
}

struct CategoryView_PreviewHelper: View {
    @State var newItemType: Int
    
    var body: some View {
        CategoryView(newItemType: $newItemType)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView_PreviewHelper(newItemType: 2)
    }
}
