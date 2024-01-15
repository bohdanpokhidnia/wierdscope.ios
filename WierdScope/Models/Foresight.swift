//
//  Foresight.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 09.11.2023.
//

import Foundation

struct Foresight: FirestoreCollectionItem, Encodable {
    let id: String
    let foresight: [String]
    let sign: Sign
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case foresight = "Foresight"
        case sign = "Sign"
        case date = "Date"
    }
}
