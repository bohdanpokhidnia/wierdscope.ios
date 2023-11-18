//
//  WierdScopeApp.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 09.11.2023.
//

import SwiftUI
import SwiftData

@main
struct WierdScopeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: [User.self])
    }
}
