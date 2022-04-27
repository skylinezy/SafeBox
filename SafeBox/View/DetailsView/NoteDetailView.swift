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
    @State private var showingInfo: Bool = false
    
    @State var noteTitle: String = "Note Title"
    @State var note: String = "<Empty>"
    
    var body: some View {
        ScrollView() {
            VStack(spacing: 18){
                
                DetailHeaderView(icon: Image(systemName:"note.text"), title: $noteTitle, isEditable: $isEditable)
                    .padding(.horizontal, 10)
                    .padding(.top, 25)
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
                            newModel.title = noteTitle
                            self.model = newModel
                        } else {
                            self.model!.title = noteTitle
                            self.model!.setData(data: newData)
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
                    
                    DeleteButton(enabled: $enableDeletion,
                                 confirmTitle: "Confirm Delete",
                                 confirmText: "Really delete this note?",
                                 action: {
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
            }// :VSTACK
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .onAppear(perform: {
                if self.model != nil {
                    let data = self.model!.toDictionary()
                    self.noteTitle = data["noteTitle"] as! String
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
        .navigationBarTitle(self.noteTitle)
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
