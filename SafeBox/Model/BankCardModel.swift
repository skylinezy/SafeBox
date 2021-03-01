//
//  BankCardModel.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/12/20.
//

import SwiftUI

class BankCardModel: BaseModel {
    
    var bankname: String
    var cardnumber: String
    var address: String
    var expDate: String
    var cvv: String
    var note: String
    
    let model: BankCard?
    
    init(card: BankCard) {
        
        
        self.bankname = card.bankname ?? "<Bank Name>"
        self.cardnumber = card.cardnumber ?? "<Bank card number>"
        self.address = card.address ?? "<Billing Address>"
        self.expDate = card.expDate ?? "<Exp Date>"
        self.cvv = card.cvv ?? "<CVV>"
        self.note = card.note ?? "<Empty>"
        
        self.model = card
        
        super.init()
        
        self.createdOn = card.createdOn ?? Date()
        self.modifiedOn = card.modifiedOn ?? Date()
        
        self.icon = "creditcard"
        self.gradientColor = SBGradientColors().BankCard
        
    }
    
    // For preview
    override init(){
        self.bankname = "American Express"
        self.cardnumber = "1234 3323 2333 1232"
        self.address = "64 Oak St"
        self.expDate = "01/25"
        self.cvv = "1234"
        self.note = "<Empty>"
        
        self.model = nil
        
        super.init()
        
        self.createdOn = Date()
        self.modifiedOn = Date()
        self.icon = "creditcard"
        self.gradientColor = SBGradientColors().BankCard
    }
}
