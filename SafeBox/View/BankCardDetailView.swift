//
//  BankCardDetailView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/12/20.
//

import SwiftUI

struct BankCardDetailView: View {
    //MARK: - Properties
    @State var model: Record?
    
    @Environment(\.managedObjectContext) private var managedContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var isEditable: Bool = false
    @State var enableDeletion: Bool = false
    
    @State var bankname: String = "Default Bank"
    @State var cardnumber: String = "1234 5678 8888 8888"
    @State var expDate: String = "10/23"
    @State var cvv: String = "123"
    @State var billingAddress: String = "Default Address"
    @State var note: String = "<Empty>"
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 18){
            if (self.model == nil) {
                Rectangle()
                    .frame(width: 120, height: 6)
                    .foregroundColor(.white)
                    .cornerRadius(3)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
            }
                
            DetailHeaderView(icon: "creditcard", title: $bankname, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.top, 15)
                .padding(.bottom, 20)
            
            DetailItemView(icon: "number", title: "Card Number", content: $cardnumber, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            HStack(spacing: 15){
                DetailItemView(icon: "calendar", title: "Exp Date", content: $expDate, isEditable: $isEditable)
                DetailItemView(icon: "checkmark.shield", title: "CVV", content: $cvv, isEditable: $isEditable)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            
            DetailItemView(icon: "mappin.and.ellipse", title: "Card Address", content: $billingAddress, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            DetailItemView(icon: "note.text", title: "Notes", content: $note, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)

            Spacer()
            
            HStack(){
                EditButton(isEditable: $isEditable, lockAction: {
                    // Update core data model with values on UI
                    let newData: [String: String] = [
                        "bankname": bankname,
                        "cardnumber": cardnumber,
                        "expDate": expDate,
                        "cvv": cvv,
                        "address": billingAddress,
                        "note": note
                    ]
                    
                    if (self.model == nil) {
                        let newModel = Record(context: self.managedContext, type: .BankCard)
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
            if (self.model != nil) {
                let data = self.model!.toDictionary()
                self.bankname = data["bankname"] as! String
                self.cardnumber = data["cardnumber"] as! String
                self.expDate = data["expDate"] as! String
                self.cvv = data["cvv"] as! String
                self.billingAddress = data["address"] as! String
                self.note = data["note"] as! String
            }
        })
    }
}

struct BankCardDetailView_PreviewHelper: View {
    
    var body: some View {
        BankCardDetailView(model: nil)
    }
}

struct BankCardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BankCardDetailView_PreviewHelper()
            .preferredColorScheme(.dark)
    }
}
