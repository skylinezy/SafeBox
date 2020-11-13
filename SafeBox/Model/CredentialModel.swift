//
//  CredentialModel.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/12/20.
//

import SwiftUI

struct CredentialModel: Codable {
    let id: UUID
    let website: String
    let username: String
    let password: String
    let email: String
    let createdOn: Date
    let modifiedOn: Date
    let note: String
    
    init(credential: Credential) {
        self.id = credential.id ?? UUID()
        self.website = credential.website ?? "google.com"
        self.username = credential.username ?? "skylinezy"
        self.password = credential.password ?? "1234SDEER"
        self.email = credential.email ?? "skylinezy0111@gmail.com"
        self.createdOn = credential.createdOn ?? Date()
        self.modifiedOn = credential.modifiedOn ?? Date()
        self.note = credential.note ?? "<Empty>"
    }
    
    // For preview
    init(){
        self.id = UUID()
        self.website = "google.com"
        self.username = "skylinezy"
        self.password = "1234SDEER"
        self.email = "skylinezy0111@gmail.com"
        self.createdOn = Date()
        self.modifiedOn = Date()
        self.note = "<Empty>"
    }
}
