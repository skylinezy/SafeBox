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
                .frame(width: 54, height: 54)
            
            Image(systemName: icon)
                .font(Font.system(size: 28, weight: .regular))
                .foregroundColor(Color.white)
                .frame(width: 35, height: 35)
                .modifier(TextDropShadow())
        }
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
    }
}

struct FloatButtonView_Previews: PreviewProvider {
    static let bgcolors1 = [Color("BtnBlueLight"), Color("BtnBlue")]
    static let bgcolors2 = [Color("BtnGreenLight"), Color("BtnGreen")]
    static let bgcolors3 = [Color("BtnRedLight"), Color("BtnRed")]
    
    static var previews: some View {
        FloatButtonView(backgroundColors: SBColors().BlueButton, icon: "plus")
            .preferredColorScheme(.light)
            .previewLayout(.fixed(width: 80, height: 80))
        
        FloatButtonView(backgroundColors: SBColors().BlueButton, icon: "pencil")
            .preferredColorScheme(.light)
            .previewLayout(.fixed(width: 80, height: 80))
        
        FloatButtonView(backgroundColors: SBColors().BlueButton, icon: "list.bullet")
            .preferredColorScheme(.light)
            .previewLayout(.fixed(width: 80, height: 80))
        
        FloatButtonView(backgroundColors: SBColors().GreenButton, icon: "trash")
            .preferredColorScheme(.light)
            .previewLayout(.fixed(width: 80, height: 80))
        
        FloatButtonView(backgroundColors: SBColors().RedButton, icon: "xmark")
            .preferredColorScheme(.light)
            .previewLayout(.fixed(width: 80, height: 80))
        
        FloatButtonView(backgroundColors: SBColors().GreenButton, icon: "checkmark")
            .preferredColorScheme(.light)
            .previewLayout(.fixed(width: 80, height: 80))
    }
}
