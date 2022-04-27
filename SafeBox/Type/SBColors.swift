//
//  GradientColors.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/13/20.
//

import SwiftUI

internal struct SBColors {
    let BankCard: [Color]    = [Color("PrimaryGreen"), Color("BtnBlueLight")]
    let Credential: [Color]  = [Color("PrimaryRed"), Color("BtnBlueLight")]
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
    
    func gradientColorWith(name: String) -> LinearGradient {
        switch name {
        case "BankCard":
            return LinearGradient(gradient: Gradient(colors:self.BankCard), startPoint: .topLeading, endPoint: .bottomTrailing)
        case "Credential":
            return LinearGradient(gradient: Gradient(colors:self.Credential), startPoint: .topLeading, endPoint: .bottomTrailing)
        case "Note":
            return LinearGradient(gradient: Gradient(colors:self.Note), startPoint: .topLeading, endPoint: .bottomTrailing)
        case "License":
            return LinearGradient(gradient: Gradient(colors:self.License), startPoint: .topLeading, endPoint: .bottomTrailing)
        default:
            return LinearGradient(gradient: Gradient(colors:self.BankCard), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
    
    func gradientColorWith(type: RecordTypes) -> LinearGradient {
        switch type {
        case .BankCard:
            return LinearGradient(gradient: Gradient(colors:self.BankCard), startPoint: .topLeading, endPoint: .bottomTrailing)
        case .Credential:
            return LinearGradient(gradient: Gradient(colors:self.Credential), startPoint: .topLeading, endPoint: .bottomTrailing)
        case .Note:
            return LinearGradient(gradient: Gradient(colors:self.Note), startPoint: .topLeading, endPoint: .bottomTrailing)
        case .License:
            return LinearGradient(gradient: Gradient(colors:self.License), startPoint: .topLeading, endPoint: .bottomTrailing)
        default:
            return LinearGradient(gradient: Gradient(colors:self.BankCard), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}
