//
//  CredentialDetailView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/12/20.
//

import SwiftUI

struct RecentItemView: View {
    var items: [String]
    @Binding var selected: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .font(.footnote)
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .background(Color("PrimaryBlue"))
                        .mask(
                            RoundedRectangle(cornerRadius: 8.0, style: .circular)
                        )
                        .onTapGesture {
                            selected = item
                        }
                }//: LOOP
            }
        }
    }
}

struct CredentialDetailView: View {
    //MARK: - Properties
    @State var model: Record?
    
    @Environment(\.managedObjectContext) private var managedContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var isEditable: Bool = false
    @State var enableDeletion: Bool = true
    @State private var showingInfo: Bool = false
    
    @State var website: String = "google.com"
    @State var username: String = UserDefaults.standard.object(forKey: "KDEFAULT_USERNAME") as? String ?? ""
    @ObservedObject var recentUsernames = SettingObject<[String]>(key: "KRECENT_USERNAMES", defaultValue: [])
    @State var password: String = UserDefaults.standard.object(forKey: "KDEFAULT_PASSWORD") as? String ?? ""
    @State var email: String = UserDefaults.standard.object(forKey: "KDEFAULT_EMAIL") as? String ?? ""
    @ObservedObject var recentEmails = SettingObject<[String]>(key: "KRECENT_EMAILS", defaultValue: [])
    @State var note: String = "<Empty>"
    
    @State var passwordLength: Float = 8.0
    @State var passwordHasLowercase: Bool = true
    @State var passwordHasUppercase: Bool = true
    @State var passwordHasSymbols: Bool = true
    @State var passwordHasNumbers: Bool = true
    
    //MARK: - Body
    var body: some View {
        ScrollView() {
            VStack(spacing: 18){
                
                DetailHeaderView(icon: Image(systemName:"globe"), title: $website, isEditable: $isEditable)
                    .padding(.horizontal, 10)
                    .padding(.top, 25)
                    .padding(.bottom, 20)
                
                
                DetailItemView(icon: "person", title: "Login Username", content: $username, isEditable: $isEditable, accessoryView: recentUsernames.value.count == 0 ? nil : AnyView(RecentItemView(items: recentUsernames.value, selected: $username)))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                
                
                DetailItemView(icon: "key", title: "Login Password", content: $password, isEditable: $isEditable, accessoryView: AnyView(PasswordConfigView(length: $passwordLength, hasLowercase: $passwordHasLowercase, hasUppercase: $passwordHasUppercase, hasSymbols: $passwordHasSymbols, hasNumbers: $passwordHasNumbers, onConfigChanged: {
                    password = passwordGenerator(length: Int(passwordLength), hasSymbol: passwordHasSymbols, hasNumber: passwordHasNumbers, hasUppercase: passwordHasUppercase, hasLowercase: passwordHasLowercase)
                })))
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                
                DetailItemView(icon: "envelope", title: "Email", content: $email, isEditable: $isEditable)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                
                DetailItemView(icon: "note.text", title: "Note", content: $note, isEditable: $isEditable)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                
                Spacer()
                
                HStack(){
                    EditButton(isEditable: $isEditable, lockAction: {
                        // Update core data model with values on UI
                        let newData: [String: String] = [
                            "website": website,
                            "username": username,
                            "password": password,
                            "email": email,
                            "note": note
                        ]
                        if (self.model == nil) {
                            let newModel = Record(context: self.managedContext, type: .Credential)
                            newModel.setData(data: newData)
                            newModel.title = website
                            self.model = newModel
                        } else {
                            self.model!.title = website
                            self.model!.setData(data: newData)
                        }
                        
                        do {
                            try self.managedContext.save()
                        }catch {
                            print(error)
                        }
                        
                        if (self.enableDeletion == false) {
                            self.enableDeletion.toggle()
                        }
                        
                        if !recentUsernames.value.contains(username) {
                            recentUsernames.value.append(username)
                        }
                    })
                    
                    Spacer()
                    
                    DeleteButton(enabled: $enableDeletion,
                                 confirmTitle: "Confirm Delete",
                                 confirmText: "Really delete this record?",
                                 action: {
                                    self.managedContext.delete(self.model!)
                                    
                                    do {
                                        try self.managedContext.save()
                                    }catch {
                                        print(error)
                                    }
                                    
                                    self.presentationMode.wrappedValue.dismiss()
                                 })
                }
                .padding(.horizontal, 25)
            }// :VSTACK
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .onAppear(perform: {
                // If the Managed Object is not nil, assign the values to view's State var (username, password etc)
                // If the Managed Object is nil, assign the default values to view's State var
                if (self.model != nil) {
                    let data = self.model!.toDictionary()
                    self.website = data["website"] as! String
                    self.username = data["username"] as! String
                    self.password = data["password"] as! String
                    self.email = data["email"] as! String
                    self.note = data["note"] as! String
                    self.model!.lastAccess = Date()
                }
            })
            .onDisappear(perform: {
                if self.managedContext.hasChanges {
                    do {
                        try self.managedContext.save()
                    }catch {
                        print(error)
                    }
                }
            })
        }// :SCROLLVIEW
        .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
        .navigationBarTitle(self.website)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.showingInfo.toggle()
                }) {
                    Image(systemName: "info.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 16, height: 16, alignment: .center)
                }
            }
        })
        .overlay(
            RecordInfoView(model: self.model)
                .offset(x: 0.0, y: self.showingInfo ? 0.0 : 180.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.525, blendDuration: 0.0))
                .opacity(self.showingInfo ? 1.0 : 0.0)
                .animation(.easeIn(duration: 0.1))
            , alignment: .bottom
        )
    }// :VIEW
}

struct CredentialDetailView_PreviewHelper: View {
    var body: some View {
        CredentialDetailView(model: nil)
    }
}

struct CredentialDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        CredentialDetailView_PreviewHelper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
