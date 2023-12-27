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
    var month: String
    var numberOfBirthday: String
    var sign: Sign
    
    init(name: String, month: String, numberOfBirthday: String, sign: Sign) {
        self.name = name
        self.month = month
        self.numberOfBirthday = numberOfBirthday
        self.sign = sign
    }
}
