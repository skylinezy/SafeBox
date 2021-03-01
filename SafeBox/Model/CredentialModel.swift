//
//  CredentialModel.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/12/20.
//

import SwiftUI

class CredentialModel: BaseModel {

    var website: String
    var username: String
    var password: String
    var email: String
    var note: String
    
    let model: Credential?
    
    init(credential: Credential) {
        self.website = credential.website ?? "<Title of record>"
        self.username = credential.username ?? "<Login username>"
        self.password = credential.password ?? "<Login password>"
        self.email = credential.email ?? "<Login Email>"
        self.note = credential.note ?? "<Empty>"
        
        self.model = credential
        
        super.init()
        
        self.createdOn = credential.createdOn ?? Date()
        self.modifiedOn = credential.modifiedOn ?? Date()
        self.icon = "globe"
        self.gradientColor = SBGradientColors().Credential
    }
    
    // For preview
    override init(){
        self.website = "google.com"+String(Int.random(in: 1...100))
        self.username = "skylinezy"
        self.password = "1234SDEER"
        self.email = "skylinezy0111@gmail.com"
        self.note = "<Empty>"
        
        self.model = nil
        
        super.init()
        
        self.createdOn = Date()
        self.modifiedOn = Date()
        self.icon = "globe"
        self.gradientColor = SBGradientColors().Credential
    }
}
