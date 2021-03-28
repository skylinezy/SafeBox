//
//  MasterCategoryView.swift
//  SafeBox
//
//  Created by Ryan Zi on 3/21/21.
//

import SwiftUI

struct CategoryInfo {
    var name: String
    var count: Int
    var color: String
    var icon: String
}

struct MasterCategoryView: View {
    let categories: [Category] = Bundle.main.decode("category.json")
    
    @State private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    // Core Data related
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Record.createdOn, ascending: true)],
        predicate: NSPredicate(format: "%K == %@", argumentArray: ["type", RecordTypes.Credential.rawValue]),
        animation: .default)
    private var credentials: FetchedResults<Record>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Record.createdOn, ascending: true)],
        predicate: NSPredicate(format: "%K == %@", argumentArray: ["type", RecordTypes.BankCard.rawValue]),
        animation: .default)
    private var bankcards: FetchedResults<Record>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Record.createdOn, ascending: true)],
        predicate: NSPredicate(format: "%K == %@", argumentArray: ["type", RecordTypes.Note.rawValue]),
        animation: .default)
    private var notes: FetchedResults<Record>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Record.createdOn, ascending: true)],
        predicate: NSPredicate(format: "%K == %@", argumentArray: ["type", RecordTypes.License.rawValue]),
        animation: .default)
    private var license: FetchedResults<Record>
    
    var body: some View {
        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 15) {
            ForEach(categories) { item in
                
                Button(action: {
                    
                }){
                    VStack(alignment: .center){
                        Text(item.name)
                            .font(.title2)
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                            .padding(.vertical, 15)
                            .modifier(TextDropShadow())
                        
                        Image(systemName: item.icon)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.white)
                            .modifier(TextDropShadow())
                            .frame(width: 64, height: 64)
                        
                        Spacer()
                        
                        
                        if (RecordTypes(rawValue: Int16(item.id)) == RecordTypes.Credential) {
                            Text("\(credentials.count) items")
                                .font(.footnote)
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                                .modifier(TextDropShadow())
                        } else if (RecordTypes(rawValue: Int16(item.id)) == RecordTypes.BankCard) {
                            Text("\(bankcards.count) items")
                                .font(.footnote)
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                                .modifier(TextDropShadow())
                        } else if (RecordTypes(rawValue: Int16(item.id)) == RecordTypes.Note) {
                            Text("\(notes.count) items")
                                .font(.footnote)
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                                .modifier(TextDropShadow())
                        } else if (RecordTypes(rawValue: Int16(item.id)) == RecordTypes.License) {
                            Text("\(license.count) items")
                                .font(.footnote)
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                                .modifier(TextDropShadow())
                        } else {
                            
                        }
                    }
                    .frame(width: 190, height: 190)
                    .background(LinearGradient(gradient: Gradient(colors:SBColors().colorWith(name: item.backgroundColorName)), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(10.0)
                    .modifier(ViewDropShadow())
                }
            }//: LOOP
        }//: GRID
    }
}

struct MasterCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        MasterCategoryView().preferredColorScheme(.light).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
