//
//  EnviromentValues+Ext.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 20.11.2023.
//

import SwiftUI

extension EnvironmentValues {
    var popGestureID: String? {
        get {
            self[PopNotificationID.self]
        }
        
        set {
            self[PopNotificationID.self] = newValue
        }
    }
}
