//
//  CategoryView.swift
//  SafeBox
//
//  Created by Ryan Zi on 12/9/20.
//

import SwiftUI

struct CategoryView: View {
    
    let categories: [Category] = Bundle.main.decode("category.json")
    
    @Binding var newItemType: RecordTypes
    @Binding var showingAddView: Bool
    @Binding var addingNew: Bool
    
    @State private var animation: Double = 5.0
    var body: some View {
        
        VStack() {
            ForEach(categories) { item in
                
                Button(action: {
                    //self.addingNew.toggle()
                    //self.showDetailView = true;
                    self.newItemType = RecordTypes(rawValue: Int16(item.id)) ?? RecordTypes.Unknown
                    self.showingAddView.toggle()
                    self.addingNew.toggle()
                }) {
                    FloatButtonView(backgroundColors: SBColors().colorWith(name: item.backgroundColorName), icon: item.icon)
                }
            }//: LOOP
        }//: GRID
    }
}

struct CategoryView_PreviewHelper: View {
    @State var newItemType: RecordTypes
    @State var showingAddView: Bool = false
    @State var addingNew: Bool = false
    var body: some View {
        CategoryView(newItemType: $newItemType, showingAddView: $showingAddView, addingNew: $addingNew)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView_PreviewHelper(newItemType: RecordTypes.Credential)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
