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
    var backgroundGradientColors: [Color] = [Color("PrimaryGreen"), Color("PrimaryRed")]
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 8){
            
            Rectangle()
                .frame(width: 120, height: 6)
                .foregroundColor(.white)
                .cornerRadius(3)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                
            
            DetailHeaderView(icon: "creditcard", title: data.bankname)
                .padding(.horizontal, 10)
                .padding(.vertical, 15)
            DetailItemView(title: "Card Number", content: data.cardnumber)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            HStack(spacing: 15){
                DetailItemView(title: "Exp Date", content: data.expDate)
                DetailItemView(title: "CVV", content: data.cvv)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            
            DetailItemView(title: "Address", content: data.address)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            DetailItemView(title: "Notes", content: data.note)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            Spacer()
            
        }
        .padding(.vertical, 8)
        .background(LinearGradient(gradient: Gradient(colors:backgroundGradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(20)
        .padding(.horizontal, 8)
    }
}

struct BankCardDetailView_Previews: PreviewProvider {
    static let testcard = BankCardModel();
    
    static var previews: some View {
        BankCardDetailView(data: testcard)
            .preferredColorScheme(.dark)
    }
}
