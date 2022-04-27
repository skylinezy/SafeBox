//
//  BankCardDetailView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/12/20.
//

import SwiftUI

enum BankCardIssuer : Int8 {
    case Unknown = 0
    case Visa = 1
    case MasterCard = 2
    case Discover = 3
    case AmericanExpress = 4
}

class BankCard: ObservableObject {
    @Published var icon : Image = Image(systemName:"creditcard")
    @Published var issuer : BankCardIssuer = .Unknown{
        didSet {
            switch issuer {
            case .Unknown:
                icon = Image(systemName:"creditcard")
            case .Visa:
                icon = Image("VisaIcon")
            case .MasterCard:
                icon = Image("MastercardIcon")
            case .Discover:
                icon = Image("DiscoverIcon")
            case .AmericanExpress:
                icon = Image("AEIcon")
            }
        }
    }
}

struct BankCardDetailView: View {
    //MARK: - Properties
    @State var model: Record?
    
    @Environment(\.managedObjectContext) private var managedContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var isEditable: Bool = false
    @State var enableDeletion: Bool = false
    @State private var showingInfo: Bool = false
    
    @State var bankname: String = "Default Bank"
    @State var cardnumber: String = "1234 5678 8888 8888"
    @State var expDate: String = "10/23"
    @State var cvv: String = "123"
    @State var billingAddress: String = UserDefaults.standard.object(forKey: "KDEFAULT_ADDRESS") as? String ?? "Default Address"
    @State var note: String = "<Empty>"
    
    @StateObject var cardInfo : BankCard = BankCard()
    
    @State private var currLen: Int = 0
    @State private var breakerPos = [4, 9, 14]
    
    //MARK: - Body
    var body: some View {
        ScrollView() {
            VStack(spacing: 18){
                
                DetailHeaderView(icon: cardInfo.icon, title: $bankname, isEditable: $isEditable)
                    .padding(.horizontal, 10)
                    .padding(.top, 25)
                    .padding(.bottom, 20)
                
                DetailItemView(icon: "number", title: "Card Number", content: $cardnumber, isEditable: $isEditable, accessoryView: nil, onChange: { newNumber in
                        if newNumber.starts(with: "37") || newNumber.starts(with: "34") {
                            breakerPos = [4, 11]
                            cardInfo.issuer = .AmericanExpress
                        } else {
                            breakerPos = [4, 9, 14]
                            switch newNumber.first {
                            case "4":
                                cardInfo.issuer = .Visa
                            case "5":
                                cardInfo.issuer = .MasterCard
                            case "6":
                                cardInfo.issuer = .Discover
                            default:
                                cardInfo.issuer = .Unknown
                            }
                        }
                        
                        if newNumber.count > currLen {
                            if breakerPos.contains(newNumber.count)
                            {
                                cardnumber.append(" ")
                            }
                        }
                        currLen = newNumber.count
                    
                    })
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
                        let newData: [String: Any] = [
                            "bankname": bankname,
                            "cardnumber": cardnumber,
                            "issuer": cardInfo.issuer.rawValue,
                            "expDate": expDate,
                            "cvv": cvv,
                            "address": billingAddress,
                            "note": note
                        ]
                        
                        if (self.model == nil) {
                            let newModel = Record(context: self.managedContext, type: .BankCard)
                            newModel.setData(data: newData)
                            newModel.title = bankname
                            self.model = newModel
                        } else {
                            self.model!.title = bankname
                            self.model!.setData(data: newData)
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
                    
                    DeleteButton(enabled: $enableDeletion,
                                 confirmTitle: "Confirm Delete",
                                 confirmText: "Really delete this card?",
                                 action:{
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
            }// :VSTACK
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .onAppear(perform: {
                if (self.model != nil) {
                    let data = self.model!.toDictionary()
                    self.bankname = data["bankname"] as! String
                    self.cardnumber = data["cardnumber"] as! String
                    if (data["issuer"] != nil) {
                    self.cardInfo.issuer = BankCardIssuer(rawValue:data["issuer"] as! Int8) ?? BankCardIssuer.Unknown
                    }
                    self.expDate = data["expDate"] as! String
                    self.cvv = data["cvv"] as! String
                    self.billingAddress = data["address"] as! String
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
        .navigationBarTitle(self.bankname)
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
