//
//  FirestoreServiceProtocol.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 10.11.2023.
//

import Foundation

protocol FirestoreServiceProtocol {
    func fetchItems<CollectionItem: FirestoreCollectionItem>(
        _ item: CollectionItem.Type,
        from collection: FirestoreCollection
    ) async throws -> [CollectionItem]
    
    func filter<CollectionItem: FirestoreCollectionItem>(_ items: [CollectionItem], at policy: FirestoreFetchPolicy) -> [CollectionItem]
}
