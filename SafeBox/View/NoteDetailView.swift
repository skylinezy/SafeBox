//
//  NoteDetailView.swift
//  SafeBox
//
//  Created by Ryan Zi on 3/18/21.
//

import SwiftUI

struct NoteDetailView: View {
    //MARK: - Properties
    @State var model: Record?
    
    @Environment(\.managedObjectContext) private var managedContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var isEditable: Bool = false
    @State var enableDeletion: Bool = false
    
    @State var noteTitle: String = "Note Title"
    @State var note: String = "<Empty>"
    
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
            
            DetailHeaderView(icon: "note.text", title: $noteTitle, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.top, 15)
                .padding(.bottom, 20)
            
            DetailItemView(icon: "note.text", title: "Note", content: $note, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            Spacer()
            
            HStack(){
                EditButton(isEditable: $isEditable, lockAction: {
                    // Update core data model with values on UI
                    let newData: [String: String] = ["noteTitle": noteTitle, "note": note]
                    
                    if (self.model == nil) {
                        let newModel = Record(context: self.managedContext, type: .Note)
                        newModel.setData(data: newData)
                        self.model = newModel
                    } else {
                        self.model!.setData(data: newData)
                        self.model!.modifiedOn = Date()
                    }
                    
                    do {
                        try self.managedContext.save()
                    }catch {
                        // TODO: Soft-error, notify user try again
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
                        // TODO: Soft-error, notify user try again
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
            
            if self.model != nil {
                let data = self.model!.toDictionary()
                self.noteTitle = data["noteTitle"] as! String
                self.note = data["note"] as! String
            }
        })
    }
}

struct NoteDetailView_PreviewHelper: View {
    
    var body: some View {
        NoteDetailView(model: nil)
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailView_PreviewHelper()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
