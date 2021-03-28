//
//  DeleteButton.swift
//  SafeBox
//
//  Created by Ryan Zi on 3/12/21.
//

import SwiftUI

struct DeleteButton: View {
    @Binding var enabled: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: "trash")
                .font(Font.system(size: 28, weight: .regular))
                .foregroundColor(Color("BtnRed"))
                .frame(width: 35, height: 35)
                .modifier(TextDropShadow())
        }
        .disabled(!self.enabled)
        .opacity(self.enabled ? 1.0 : 0.5)
    }
}

struct DeleteButton_PreviewHelper: View {
    @State var enabled: Bool = false
    
    var body: some View {
        DeleteButton(enabled: $enabled, action: {})
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton_PreviewHelper(enabled: true)
            .previewLayout(.sizeThatFits)
            .padding()
        DeleteButton_PreviewHelper(enabled: false)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
