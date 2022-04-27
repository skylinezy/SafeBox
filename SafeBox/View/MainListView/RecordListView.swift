//
//  RecordListView.swift
//  SafeBox
//
//  Created by Ryan Zi on 9/4/21.
//

import SwiftUI
import CoreData

struct ListGroupHeaderView: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.vertical, 10)
            .padding(.leading, 20)
    }
}

enum ListViewSheetType: Int16 {
    case Unknown        = 0
    case Settings       = 1
    case NewRecord      = 2
}

// Manage the sheet content
class ListViewSheetState: ObservableObject {
    @Published var isShowing: Bool = false
    @Published var type: ListViewSheetType = .Unknown {
        didSet { isShowing = type != .Unknown }
    }
}

struct RecordListView: View {
    
    @State private var selectedItem: UUID? = nil
    @ObservedObject var sheet = ListViewSheetState()
    
    // Core Data related
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Record.createdDate, ascending: true)],
        animation: .easeIn)
    private var records: FetchedResults<Record>
    
    func grouped(_ result : FetchedResults<Record>)-> [[Record]]{
        var credentials : [Record] = []
        var cards : [Record] = []
        var notes : [Record] = []
        var licenses : [Record] = []
        
        for r in result {
            switch r.type {
            case RecordTypes.Credential.rawValue:
                credentials.append(r)
            case RecordTypes.BankCard.rawValue:
                cards.append(r)
            case RecordTypes.Note.rawValue:
                notes.append(r)
            case RecordTypes.License.rawValue:
                licenses.append(r)
            default:
                break
            }
        }
        
        return [credentials, cards, notes, licenses]
        
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Group {
                ForEach(grouped(self.records), id: \.self) { (section : [Record]) in
                    if section.count > 0 {
                        LazyVStack() {
                            
                            ListGroupHeaderView(title: RecordTypeStr(section[0].type))
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            
                            ForEach(section, id: \.self) { item in
                                switch item.type {
                                case RecordTypes.Credential.rawValue:
                                    ZStack() {
                                        NavigationLink(
                                            destination: CredentialDetailView(model: item, isEditable: false, enableDeletion: true)
                                                .cornerRadius(20)
                                                .padding(.horizontal, 10), tag: item.id!, selection: $selectedItem) {
                                                    EmptyView()
                                                }
                                                .opacity(0.0)
                                        
                                        ListItemView(title: item.title ?? "Credential", icon: "globe",  backgroundGradientColors: SBColors().Credential)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 8)
                                            .onTapGesture {
                                                selectedItem = item.id
                                            }
                                    }
                                case RecordTypes.BankCard.rawValue:
                                    ZStack() {
                                        // ZStack to hide the disclosure icon
                                        // https://www.appcoda.com/hide-disclosure-indicator-swiftui-list/
                                        NavigationLink(
                                            destination: BankCardDetailView(model: item, isEditable: false, enableDeletion: true)
                                                .cornerRadius(20)
                                                .padding(.horizontal, 10), tag: item.id!, selection: $selectedItem) {
                                                    EmptyView()
                                                }
                                                .opacity(0.0)
                                        
                                        ListItemView(title: item.title ?? "Bank Card", icon: "creditcard", backgroundGradientColors: SBColors().BankCard)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 8)
                                            .onTapGesture {
                                                selectedItem = item.id
                                            }
                                    }
                                case RecordTypes.Note.rawValue:
                                    ZStack() {
                                        NavigationLink(
                                            destination: NoteDetailView(model: item, isEditable: false, enableDeletion: true)
                                                .cornerRadius(20)
                                                .padding(.horizontal, 10), tag: item.id!, selection: $selectedItem) {
                                                    EmptyView()
                                                }
                                                .opacity(0.0)
                                        
                                        ListItemView(title: item.title ?? "Note", icon: "note.text", backgroundGradientColors: SBColors().Note)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 8)
                                            .onTapGesture {
                                                selectedItem = item.id
                                            }
                                    }
                                default:
                                    Text("Unknown Record")
                                }// :SWITCH
                            }// :FOREACH
                        }// :SECTION
                        .modifier(NoListSeparator())
                    }// :IF
                }// :FOREACH
            }// :GROUP
            
            // Filler rectangle to offset the bottom toolbar
            Rectangle()
                .fill(Color.clear)
                .frame(height: 100)
                
        }//: LIST
        .navigationBarTitle("", displayMode: .large)
        .overlay(
            EmptyListView()
                .opacity(records.count == 0 ? 1.0 : 0.0)
        )
    }
}

struct RecordListView_Previews: PreviewProvider {
    static var previews: some View {
        Group(){
            RecordListView()
                .preferredColorScheme(.light)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            
            RecordListView()
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
