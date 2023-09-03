//
//  PhotosListModel.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 02.09.2023.
//

import Foundation
import Factory

final class PhotosListModel {
    
    @Injected(\.networkService) private var networkService
    
    func getPhotosList() async -> [PhotoModel] {
        guard let baseURL = URL(string: "https://jsonplaceholder.typicode.com") else { return [] }
        let target = NetworkTarget(baseURL: baseURL, path: "/photos", httpMethod: .get)
        let photosList: [PhotoModel] = await networkService.asyncTask(target: target) ?? []
        return photosList
    }
}
