//
//  MasterListView.swift
//  SafeBox
//
//  Created by Ryan Zi on 3/5/21.
//

import SwiftUI
import CoreData

struct ListGroupHeaderView: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .padding(.vertical, 20)
            .modifier(TextDropShadow())
    }
}

struct MasterListView: View {
    @State var showingAddView: Bool = false
    @State private var newRecordType: RecordTypes = .BankCard
    @State var addingNew: Bool = false
    @State var showingSettingView: Bool = false
    @State private var searchQuery: String = ""
    
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
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                List {
                    // To move the first header below the type filter
                    Rectangle()
                        .frame(height: 50)
                        .foregroundColor(.clear)
                        .modifier(NoListSeparator())
                    
                    if (self.credentials.count != 0) {
                        ListGroupHeaderView(title: "Credentials")
                            .modifier(NoListSeparator(type: .Header))
                        
                        // Must pass in id: in the ForEach
                        ForEach(self.credentials, id: \.self) {item in
                            NavigationLink(
                                destination: CredentialDetailView(model: item, isEditable: false, enableDeletion: true)
                                    .background(SBColors().gradientColorWith(type: item.recordType))
                                    .cornerRadius(20)
                                    .padding(.horizontal, 10)
                            ) {
                                ListItemView(title: "Website", icon: "globe", backgroundGradientColors: SBColors().Credential)
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 2, x: 0, y: 2)
                            }
                        }//: LOOP
                        .modifier(NoListSeparator())
                    }
                    
                    if (self.bankcards.count != 0) {
                        ListGroupHeaderView(title: "Bank Cards")
                            .modifier(NoListSeparator(type: .Header))
                        
                        ForEach(self.bankcards, id: \.self) {item in
                            NavigationLink(
                                destination: BankCardDetailView(model: item, isEditable: false, enableDeletion: true)
                                    .background(SBColors().gradientColorWith(type: item.recordType))
                                    .cornerRadius(20)
                                    .padding(.horizontal, 10)) {
                                ListItemView(title: "Bank", icon: "creditcard", backgroundGradientColors: SBColors().BankCard)
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 2, x: 0, y: 2)
                                    .background(Color(.systemBackground))
                            }
                        }//: LOOP
                        .modifier(NoListSeparator())
                    }
                    
                    if (self.notes.count != 0) {
                        ListGroupHeaderView(title: "Notes")
                            .modifier(NoListSeparator(type: .Header))
                        
                        ForEach(self.notes, id: \.self) {item in
                            NavigationLink(
                                destination: NoteDetailView(model: item, isEditable: false, enableDeletion: true)
                                    .background(SBColors().gradientColorWith(type: item.recordType))
                                    .cornerRadius(20)
                                    .padding(.horizontal, 10)) {
                                ListItemView(title: "Note", icon: "note.text", backgroundGradientColors: SBColors().Note)
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 2, x: 0, y: 2)
                                    .background(Color(.systemBackground))
                            }
                        }//: LOOP
                        .modifier(NoListSeparator())
                    }
                }//: LIST
                //.padding(.top, 50) // TODO: Read the height of the filter view and use here
                .navigationBarTitle("", displayMode: .inline)
                .listStyle(PlainListStyle())
                //.offset(y: 60)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            self.showingSettingView.toggle()
                        }) {
                            Image(systemName: "gearshape")
                                .imageScale(.small)
                        }
                    }
                    
                    ToolbarItem(placement: .navigation) {
                        TextField("Search", text: $searchQuery)
                            .font(.body)
                            .foregroundColor(.accentColor)
                            .frame(width: 230)
                            .padding(0)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(spacing: 16) {
                            Button(action: {
                                
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 16, height: 16, alignment: .center)
                            }
                            
                            Button(action: {
                                self.showingAddView.toggle()
                            }) {
                                Image(systemName: self.showingAddView ? "xmark" : "plus")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 16, height: 16, alignment: .center)
                            }
                            
                        }//: HSTACK
                    }//: BUTTONS
                }//: TOOLBAR
                .sheet(isPresented: $addingNew, onDismiss: {
                    self.newRecordType = .Unknown
                }) {
                    if (self.newRecordType == RecordTypes.Credential) {
                        CredentialDetailView(isEditable: true, enableDeletion: false)
                            .background(SBColors().gradientColorWith(name: "Credential").edgesIgnoringSafeArea(.all))
                    } else if (self.newRecordType == RecordTypes.BankCard) {
                        BankCardDetailView(isEditable: true, enableDeletion: false)
                            .background(SBColors().gradientColorWith(name: "BankCard").edgesIgnoringSafeArea(.all))
                    } else if (self.newRecordType == RecordTypes.Note) {
                        NoteDetailView(isEditable: true, enableDeletion: false)
                            .background(SBColors().gradientColorWith(name: "Note").edgesIgnoringSafeArea(.all))
                    } else {
                        Text("New Record Adding View")
                    }//: IF
                }//: SHEET
                .sheet(isPresented: $showingSettingView) {
                    Text("Setting View")
                }
                CategoryFilterView()
                    .frame(height: 50)
                    .modifier(ViewDropShadow())
            }//: GeometryReader
        }//: NAV VIEW
        .overlay(
            CategoryView(newItemType: $newRecordType, showingAddView: $showingAddView, addingNew: $addingNew)
                .offset(x: 0.0, y: self.showingAddView ? 0.0 : -20.0)
                .animation(Animation.spring(response: 0.2, dampingFraction: 0.3, blendDuration: 0.2))
                .opacity(self.showingAddView ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.15))
        )
        
    }//: VIEW
}

struct MasterListView_Previews: PreviewProvider {
    static var previews: some View {
        MasterListView(showingAddView: false).preferredColorScheme(.light).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
