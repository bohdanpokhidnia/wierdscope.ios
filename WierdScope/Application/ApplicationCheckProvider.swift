//
//  ApplicationCheckProvider.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 09.11.2023.
//

import Firebase

final class ApplicationCheckProvider: NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        let appAttestProvider = AppAttestProvider(app: app)
        return appAttestProvider
    }
}
