//
//  BankCardModel.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/12/20.
//

import SwiftUI

struct BankCardModel: Codable {
    let id: UUID
    let bankname: String
    let cardnumber: String
    let address: String
    let expDate: String
    let cvv: String
    let createdOn: Date
    let modifiedOn: Date
    let note: String
    
    init(card: BankCard) {
        self.id = card.id ?? UUID()
        self.bankname = card.bankname ?? "American Express"
        self.cardnumber = card.cardnumber ?? "1234 3323 2333 1232"
        self.address = card.address ?? "64 Oak St"
        self.expDate = card.expDate ?? "01/25"
        self.cvv = card.cvv ?? "1234"
        self.createdOn = card.createdOn ?? Date()
        self.modifiedOn = card.modifiedOn ?? Date()
        self.note = card.note ?? "<Empty>"
    }
    
    // For preview
    init(){
        self.id = UUID()
        self.bankname = "American Express"
        self.cardnumber = "1234 3323 2333 1232"
        self.address = "64 Oak St"
        self.expDate = "01/25"
        self.cvv = "1234"
        self.createdOn = Date()
        self.modifiedOn = Date()
        self.note = "<Empty>"
    }
}
