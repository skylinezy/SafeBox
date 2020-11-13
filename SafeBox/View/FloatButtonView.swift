//
//  FloatButtongView.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/12/20.
//

import SwiftUI

struct FloatButtonView: View {
    //MARK: - Properties
    var backgroundColors: [Color]
    var icon: String
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 60, height: 60)
            
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors:backgroundColors), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 56, height: 56)
            
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.white)
                .frame(width: 35, height: 35)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 2, y: 2)
        }
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
    }
}

struct FloatButtonView_Previews: PreviewProvider {
    static let bgcolors1 = [Color("BtnBlueLight"), Color("BtnBlue")]
    static let bgcolors2 = [Color("BtnGreenLight"), Color("BtnGreen")]
    static let bgcolors3 = [Color("BtnRedLight"), Color("BtnRed")]
    
    static var previews: some View {
        FloatButtonView(backgroundColors: bgcolors1, icon: "plus")
            .preferredColorScheme(.light)
            .previewLayout(.fixed(width: 80, height: 80))
        
        FloatButtonView(backgroundColors: bgcolors2, icon: "lock.open")
            .preferredColorScheme(.light)
            .previewLayout(.fixed(width: 80, height: 80))
        
        FloatButtonView(backgroundColors: bgcolors3, icon: "trash")
            .preferredColorScheme(.light)
            .previewLayout(.fixed(width: 80, height: 80))
    }
}
