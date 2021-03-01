//
//  DetailView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/23/20.
//

import SwiftUI

struct DetailView: View {
    // The container view to hold different inset view according to the record type and data model
    // MARK: - PROPERTIES
    
    var data: AnyObject?
    var type: RecordTypes = RecordTypes.Unknown
    
    @Environment(\.managedObjectContext) private var managedContext
    
    @State var isEditable: Bool = false
    @State var isDeleting: Bool = false
    
    // MARK: - BODY
    var body: some View {
        switch type {
        case RecordTypes.Credential:
            CredentialDetailView(data: data as! CredentialModel, isEditable: isEditable, isDeleting: isDeleting)
        case RecordTypes.BankCard:
            BankCardDetailView(data: data as! BankCardModel, isEditable: isEditable, isDeleting: isDeleting)
        case RecordTypes.Note:
            Text("Note")
        case RecordTypes.Unknown:
            Text("Placeholder View")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static let testcard = BankCardModel()
    static let type = RecordTypes.Unknown
    
    static var previews: some View {
        DetailView(data: testcard, type: type)
    }
}
