//
//  noListSeparator.swift
//  SafeBox
//
//  Created by Ryan Zi on 3/17/21.
//

import SwiftUI

enum ListElementType: Int16 {
    case Cell   = 0
    case Header = 1
}

struct NoListSeparator: ViewModifier {
    // This is a workaround from stackoverflow. Hopefully in the future Apple can provide a built-in modifier to hide the list separators
    var type: ListElementType = .Cell
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .listRowInsets(EdgeInsets(.init(top: -1, leading: self.type == .Cell ? 0 : 15, bottom: -1, trailing: 0)))
    }
}
