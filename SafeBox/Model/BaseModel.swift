//
//  BaseModel.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/16/20.
//

import SwiftUI

class BaseModel: ObservableObject{
    let id: UUID = UUID()
    
    var icon: String = "globe"
    var gradientColor: [Color] = SBGradientColors().Credential
    
    var createdOn: Date = Date()
    var modifiedOn: Date = Date()
}
