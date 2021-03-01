//
//  Category.swift
//  SafeBox
//
//  Created by Ryan Zi on 12/9/20.
//

import SwiftUI

struct Category: Codable, Identifiable {
    let id: Int
    let name: String
    let icon: String
    let backgroundColorName: String
}
