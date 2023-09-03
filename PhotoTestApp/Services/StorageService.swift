//
//  StorageService.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 03.09.2023.
//

import Foundation
import RealmSwift

protocol StorageServiceInterface {
    func write<T: Object>(objects: [T]) async
    func getObjects<T: Object>() async -> Results<T>
    func delete<T: Object>(objects: Results<T>) async
}

@MainActor
final class StorageService: StorageServiceInterface {
    
    private let realm = try! Realm()
    
    func write<T: Object>(objects: [T]) async {
        try? realm.write {
            realm.add(objects)
        }
    }
    
    func getObjects<T: Object>() async -> Results<T> {
        realm.objects(T.self)
    }
    
    func delete<T: Object>(objects: Results<T>) async {
        try? realm.write {
            realm.delete(objects)
        }
    }
    
}
