//
//  ContentView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/10/20.
//

import SwiftUI
import CoreData

struct ListGroupHeaderView: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.vertical, 20)
            .modifier(TextDropShadow())
    }
}

struct ContentView: View {
    //MARK: - Properties
    
    struct SelectedItem: Identifiable {
        let id = UUID()
        var type: RecordTypes
        var item: AnyObject?
    }
    
    // Tracks the detail view's drag gesture
    @State var dragState = CGSize.zero
    @State var dragStart = false
    
    // We are showing an existing record
    @State private var showDetailView: Bool = false
    
    // We are adding a new record
    @State private var addingNew: Bool = false
    
    // The type of the new record we are adding
    @State private var newItemType: Int = 0
    
    // The last selected record in the list view
    @State private var selected: SelectedItem = SelectedItem(type: RecordTypes.Unknown, item: nil)
    
    // Core Data related
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Credential.createdOn, ascending: true)],
        animation: .default)
    private var credentials: FetchedResults<Credential>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BankCard.createdOn, ascending: true)],
        animation: .default)
    private var bankcards: FetchedResults<BankCard>
    
    //MARK: - Body
    var body: some View {
        
        ZStack {
            if credentials.count == 0 && bankcards.count == 0{
                EmptyListView()
                    .scaleEffect((self.showDetailView || self.addingNew) ? 0.95 : 1)
                    .blur(radius: (self.showDetailView || self.addingNew) ? 15.0 : 0.0)
                    .animation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 1))
                    .edgesIgnoringSafeArea(.all)
                    //.allowsHitTesting((self.showDetailView || self.addingNew) ? false : true)
                    .disabled((self.showDetailView || self.addingNew) ? true : false)
            } else {
                ScrollView{
                    VStack(alignment: .leading){
                        Group{
                            
                            ListGroupHeaderView(title: "Credentials")
                                .padding(.top, 40)
                            // To shift down the top header view so not blocked by the camera area. I need to ignore the safe area for edges to make scaleEffect animation correct. But that moves up the header view too much.
                            
                            VStack(alignment: .leading, spacing: -110){
                                ForEach(credentials) { item in
                                    let model = CredentialModel(credential: item)
                                    ListItemView(title: model.website, icon: model.icon, backgroundGradientColors: model.gradientColor)
                                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 20, x: 0, y: 2)
                                        .onTapGesture(perform: {
                                            //
                                            self.selected = SelectedItem(type: RecordTypes.Credential, item: model)
                                            showDetailView = true
                                        })
                                }//: LOOP
                            }//: VSTACK
                        }//: GROUP
                        
                        
                        //: BankCard group
                        Group{
                            
                            ListGroupHeaderView(title: "Bank Cards")
                            
                            VStack(alignment: .leading, spacing: -110){
                                ForEach(bankcards) { item in
                                    let model = BankCardModel(card: item)
                                    ListItemView(title: model.bankname, icon: model.icon, backgroundGradientColors: model.gradientColor)
                                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 20, x: 0, y: 2)
                                        .onTapGesture(perform: {
                                            //showDetailView = true
                                            self.selected = SelectedItem(type: RecordTypes.BankCard, item: model)
                                            showDetailView = true
                                        })
                                }//: LOOP
                            }//: VSTACK
                        }//: GROUP
                        
                        //: Driver license group
                        //: SSN group
                        //: Note group
                        //:
                    }//: VSTACK
                    .padding(.horizontal, 20)
                }//: SCROLLVIEW
                .scaleEffect((self.showDetailView || self.addingNew) ? 0.95 : 1)
                .blur(radius: (self.showDetailView || self.addingNew) ? 15.0 : 0.0)
                .animation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 1))
                .edgesIgnoringSafeArea(.all)
                //.allowsHitTesting((self.showDetailView || self.addingNew) ? false : true)
                .disabled((self.showDetailView || self.addingNew) ? true : false)
            }// IF
            
            
            DetailView(data: self.selected.item, type: self.selected.type)
                .frame(width: .infinity, height: 600)
                .environment(\.managedObjectContext, self.viewContext)
                .offset(y: self.showDetailView ? self.dragState.height : UIScreen.main.bounds.height)
                .animation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 1))
                .gesture(
                    DragGesture()
                    .onChanged { value in
                        self.dragState = value.translation
                    }
                    .onEnded { value in
                        if (value.translation.height > 200) {
                            // TODO: Prompt if there is edits in the detail view that needs to save
                            self.showDetailView.toggle()
                        }
                        self.dragState = CGSize.zero
                    }
                )
        }//: ZSTACK
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .overlay(
            VStack(alignment: .center){
                Spacer()
                
                ZStack {
                    Rectangle()   // Half-transparent background
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.0), Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0)]), startPoint: .top, endPoint: .bottom))
                    
                    HStack(alignment: .bottom){
                        FloatButtonView(backgroundColors: SBGradientColors().BlueButton, icon: "gearshape")
                            .scaleEffect(0.7)
                            .opacity(self.showDetailView ? 0.0 : 1.0)
                        Spacer()
                        Button(action: {
                            self.addingNew.toggle()
                        }) {
                            FloatButtonView(backgroundColors: SBGradientColors().BlueButton, icon: "plus")
                                .opacity(self.showDetailView ? 0.0 : 1.0)
                        }
                        
                        Spacer()
                        FloatButtonView(backgroundColors: SBGradientColors().BlueButton, icon: "magnifyingglass")
                            .scaleEffect(0.7)
                            .opacity(self.showDetailView ? 0.0 : 1.0)
                    }//: HSTACK
                    .padding(.horizontal, 30)
                    .padding(.bottom, 25) // bottom padding of the floating buttons
                }
                .frame(width: UIScreen.main.bounds.width, height: 100)
            }//: VSTACK
            .edgesIgnoringSafeArea(.all)
            .disabled(self.showDetailView ? true : false)
        )
        .overlay(
            CategoryView(newItemType: $newItemType)
                .opacity(self.addingNew ? 1.0 : 0.0)
                .environment(\.managedObjectContext, self.viewContext)
        )
        
    }

    /*
    private func addItem() {
        withAnimation {
            let newItem = Credential(context: viewContext)
            newItem.createdOn = Date()
            newItem.modifiedOn = Date()
            newItem.username = "skylinezy"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
 */
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
