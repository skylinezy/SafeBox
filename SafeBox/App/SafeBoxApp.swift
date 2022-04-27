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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @Environment(\.scenePhase) var scenePhase
    
    @AppStorage("needsAuth") var needsAuth : Bool = true
    @AppStorage("isOnBoarding") var isOnBoarding: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isOnBoarding {
                OnBoardPasswordSetupView()
            } else {
                MasterHostingView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .fullScreenCover(isPresented: $needsAuth, content: {
                        LoginView()
                            .edgesIgnoringSafeArea(.all)
                    })
                    .onChange(of: scenePhase) { newPhase in
                        if newPhase == .background {
                            if UserDefaults.standard.object(forKey: "KAUTO_LOCK") as? Bool ?? true {
                                self.needsAuth = true
                            }
                        }
                    }
            }
        }
    }
}
