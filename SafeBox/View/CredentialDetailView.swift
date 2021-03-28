//
//  CredentialDetailView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/12/20.
//

import SwiftUI

struct CredentialDetailView: View {
    //MARK: - Properties
    @State var model: Record?
    
    @Environment(\.managedObjectContext) private var managedContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var isEditable: Bool = false
    @State var enableDeletion: Bool = false
    
    @State var website: String = "google.com"
    @State var username: String = "Default Name"
    @State var password: String = "Default Password"
    @State var email: String = "Default Email"
    @State var note: String = "<Empty>"
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 8){
            
            if (self.model == nil) {
                Rectangle()
                    .frame(width: 120, height: 6)
                    .foregroundColor(.white)
                    .cornerRadius(3)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                    .padding(.vertical, 20)
            }
                
            DetailHeaderView(icon: "globe", title: $website, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.top, 15)
                .padding(.bottom, 20)
            
            DetailItemView(icon: "person", title: "Login Username", content: $username, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            DetailItemView(icon: "key", title: "Login Password", content: $password, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            DetailItemView(icon: "envelope", title: "Email", content: $email, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            DetailItemView(icon: "note.text", title: "Note", content: $note, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            Spacer()
            
            //DetailToolbarView(isEditable: $isEditable, isDeleting: $isDeleting)
            //    .padding(20)
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
                        self.model = newModel
                    } else {
                        self.model!.setData(data: newData)
                        self.model!.modifiedOn = Date()
                    }
                    
                    do {
                        try self.managedContext.save()
                    }catch {
                        print(error)
                    }
                    
                    if (self.enableDeletion == false) {
                        self.enableDeletion.toggle()
                    }
                })
                
                Spacer()
                
                DeleteButton(enabled: $enableDeletion, action: {
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
            
        }
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
            }
        })
    }
    
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
