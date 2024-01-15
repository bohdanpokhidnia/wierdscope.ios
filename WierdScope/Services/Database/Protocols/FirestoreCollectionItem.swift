//
//  FirestoreCollectionItem.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 15.01.2024.
//

import Foundation

protocol FirestoreCollectionItem: Decodable {
    var date: String { get }
}
