//
//  AppDelegate.swift
//  SafeBox
//
//  Created by Ryan Zi on 9/2/21.
//

import Foundation
import UIKit
import LocalAuthentication

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let context = LAContext()
        var error: NSError?
        // Need to call canEvaluatePolicy to set the biometryType value of the LAContext so we can show proper prompt for UI
        context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        //TODO: Need to handle error
        return true
    }
}
