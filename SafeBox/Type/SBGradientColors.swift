//
//  GradientColors.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/13/20.
//

import SwiftUI

internal struct SBGradientColors {
    let BankCard: [Color]    = [Color("PrimaryGreen"), Color("BtnBlueLight")]
    let Credential: [Color]  = [Color("PrimaryPurple"), Color("BtnBlueLight")]
    let Note: [Color]        = [Color("PrimaryBlue"), Color("BtnBlueLight")]
    let License: [Color]     = [Color("PrimaryPink"), Color("BtnBlueLight")]
    
    let BlueButton: [Color]  = [Color("BtnBlueLight"), Color("BtnBlue")]
    let RedButton: [Color]   = [Color("BtnRedLight"), Color("BtnRed")]
    let GreenButton: [Color] = [Color("BtnGreenLight"), Color("BtnGreen")]
    
    func colorWith(name: String) -> [Color] {
        switch name {
        case "BankCard":
            return self.BankCard
        case "Credential":
            return self.Credential
        case "Note":
            return self.Note
        case "License":
            return self.License
        case "BlueButton":
            return self.BlueButton
        case "RedButton":
            return self.RedButton
        case "GreenButton":
            return self.GreenButton
        default:
            return [Color("PrimaryGreen"), Color("PrimaryRed")]
        }
    }
}
