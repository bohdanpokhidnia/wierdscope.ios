//
//  FirestoreService.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 09.11.2023.
//

import Firebase

final class FirestoreService {
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    private let decoder: JSONDecoder
}

// MARK: - FirestoreServiceProtocol

extension FirestoreService: FirestoreServiceProtocol {
    func fetchItems<CollectionItem: Decodable>(_ item: CollectionItem.Type, from collection: FirestoreCollection) async throws -> [CollectionItem] {
        let firestore = Firestore.firestore()
        let snapshot = try await firestore.collection(collection.rawValue).getDocuments()
        let documents = snapshot.documents
        var items: [CollectionItem] = []
        
        guard !documents.isEmpty else {
            throw FirestoreError.emptyCollection
        }
        
        let documentData = documents.map { $0.data() }
        
        for data in documentData {
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            let item = try decoder.decode(item.self, from: jsonData)
            items.append(item)
        }
        
        return items
    }
    
    func fetchItems<CollectionItem: Decodable>(
        _ item: CollectionItem.Type,
        from collection: FirestoreCollection,
        completion: @escaping (([CollectionItem]?) -> Void)
    ) {
        let firestore = Firestore.firestore()
        let decoder = self.decoder
        
        firestore.collection(collection.rawValue).getDocuments { (snapshot, error) in
            guard error == nil else {
                print(error!)
                completion(nil)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(nil)
                return
            }
            
            let documentData = documents.map { $0.data() }
            
            do {
                var items: [CollectionItem] = []
                
                for data in documentData {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let item = try decoder.decode(item.self, from: jsonData)
                    items.append(item)
                }
                
                completion(items)
            } catch {
                completion(nil)
                print(error)
            }
        }
    }
}
