//
//  ShadowModifiers.swift
//  SafeBox
//
//  Created by Ryan Zi on 12/12/20.
//

import SwiftUI

struct TextDropShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
    }
}

struct ViewDropShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.20), radius: 8, x: 2, y: 2)
    }
}
