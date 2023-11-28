//
//  AppDelegate.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 09.11.2023.
//

import Firebase
import GoogleMobileAds

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        configureAds()
        return true
    }
}

// MARK: - Private Methods

private extension AppDelegate {
    func configureAds() {
        let mobileAds = GADMobileAds.sharedInstance()
        
        mobileAds.start()
        mobileAds.requestConfiguration.testDeviceIdentifiers = ["d9bc6a519694f925838658a257fedacb"]
    }
}
