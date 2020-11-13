//
//  SafeBoxApp.swift
//  SafeBox
//
//  Created by Ryan Zi on 11/10/20.
//

import SwiftUI

@main
struct SafeBoxApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
