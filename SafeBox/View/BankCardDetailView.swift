//
//  BankCardDetailView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/12/20.
//

import SwiftUI

struct BankCardDetailView: View {
    //MARK: - Properties
    var data: BankCardModel
    @Environment(\.managedObjectContext) private var managedContext
    
    @State var isEditable: Bool = true
    @State var isDeleting: Bool = false
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 18){
            
            Rectangle()
                .frame(width: 120, height: 6)
                .foregroundColor(.white)
                .cornerRadius(3)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                
            DetailHeaderView(icon: "creditcard", title: data.bankname)
                .padding(.horizontal, 10)
                .padding(.vertical, 15)
            
            DetailItemView(icon: "number", title: "Card Number", content: data.cardnumber, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            HStack(spacing: 15){
                DetailItemView(icon: "calendar", title: "Exp Date", content: data.expDate, isEditable: $isEditable)
                DetailItemView(icon: "checkmark.shield", title: "CVV", content: data.cvv, isEditable: $isEditable)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            
            DetailItemView(icon: "mappin.and.ellipse", title: "Card Address", content: data.address, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            DetailItemView(icon: "note.text", title: "Notes", content: data.note, isEditable: $isEditable)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)

            Spacer()
            
            DetailToolbarView(isEditable: $isEditable, isDeleting: $isDeleting)
                .padding(20)
        }
        .padding(.vertical, 8)
        .background(LinearGradient(gradient: Gradient(colors:SBGradientColors().BankCard), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(20)
        .padding(.horizontal, 10)
    }
}

struct BankCardDetailView_Previews: PreviewProvider {
    static let testcard = BankCardModel();
    
    static var previews: some View {
        BankCardDetailView(data: testcard)
            .preferredColorScheme(.dark)
    }
}
