//
//  PhotosListModel.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 02.09.2023.
//

import Foundation
import Factory
import RealmSwift

final class PhotosListModel {
    
    @Injected(\.networkService) private var networkService
    @Injected(\.storageService) private var storageService
    
    @MainActor
    func getPhotosList() async -> [Photo] {
        let storagePhotos: Results<Photo> = storageService.getObjects()
        if storagePhotos.isEmpty {
            guard let baseURL = URL(string: "https://jsonplaceholder.typicode.com") else { return [] }
            let target = NetworkTarget(baseURL: baseURL, path: "/photos", httpMethod: .get)
            let photosList: [PhotoModel] = await networkService.asyncTask(target: target) ?? []
            let list = photosList.map { Photo(photoModel: $0) }
            storageService.write(objects: list)
            return list
        } else {
            return Array(storagePhotos)
        }
    }
}
