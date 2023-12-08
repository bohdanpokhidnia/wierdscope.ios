//
//  User.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 15.11.2023.
//

import SwiftUI
import SwiftData

@Model
class User {
    var name: String
    var sign: Sign
    
    init(name: String, sign: Sign) {
        self.name = name
        self.sign = sign
    }
}
