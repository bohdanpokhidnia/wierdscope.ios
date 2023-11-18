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
    var sign: Sign

    init(sign: Sign) {
        self.sign = sign
    }
}
