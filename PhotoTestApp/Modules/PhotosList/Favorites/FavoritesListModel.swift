//
//  FavoritesListModel.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 03.09.2023.
//

import Foundation
import Factory
import RealmSwift

final class FavoritesListModel {
    
    @Injected(\.storageService) private var storageService
    
    func getPhotosList() -> [Photo] {
        let photos: Results<Photo> = storageService.getObjects()
        let filteredPhotos = photos.filter { $0.isFavorite }
        return Array(filteredPhotos)
    }
}
