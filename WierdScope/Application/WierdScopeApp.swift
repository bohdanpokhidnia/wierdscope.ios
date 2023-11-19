//
//  WierdScopeApp.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 09.11.2023.
//

import SwiftUI
import SwiftData
import WidgetKit

@main
struct WierdScopeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: [User.self])
        .onChange(of: scenePhase) { (_, _) in
            WidgetCenter.shared.reloadTimelines(ofKind: "WierdScopeWidget")
        }
    }
}
