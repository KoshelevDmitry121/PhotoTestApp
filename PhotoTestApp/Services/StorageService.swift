//
//  StorageService.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 03.09.2023.
//

import Foundation
import RealmSwift

protocol PhotoStorageServiceInterface {
    func getObjects<T: Object>() -> Results<T>
    func write<T: Object>(objects: [T])
    func updateModel(id: Int, isFavorite: Bool)
}

final class PhotoStorageService: PhotoStorageServiceInterface {
    
    private let realm = try! Realm()
    
    func getObjects<T: Object>() -> Results<T> {
        realm.objects(T.self)
    }
    
    func write<T: Object>(objects: [T]) {
        try! realm.write {
            realm.add(objects)
        }
    }
    
    func updateModel(id: Int, isFavorite: Bool) {
        let photo = realm.objects(Photo.self).first(where: { $0.id == id })
        try! realm.write {
            photo?.isFavorite = isFavorite
        }
    }
    
}
