//
//  RecordTypes.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/29/20.
//

import SwiftUI

enum RecordTypes: Int16 {
    case Unknown    = 0
    case Credential = 1
    case BankCard   = 2
    case Note       = 3
    case License    = 4
}

func RecordTypeStr(_ type: Int16) -> String {
    switch type {
    case 1:
        return "Credential"
    case 2:
        return "Bank Card"
    case 3:
        return "Note"
    case 4:
        return "License"
    default:
        return "Unknown"
    }
}
