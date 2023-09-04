//
//  PhotoModel.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 02.09.2023.
//

import Foundation
import RealmSwift

struct PhotoModel: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

final class Photo: Object {
    @objc dynamic var albumId: Int = .zero
    @objc dynamic var id: Int = .zero
    @objc dynamic var title: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var thumbnailUrl: String = ""
    @objc dynamic var isFavorite: Bool = false
    
    convenience init(photoModel: PhotoModel) {
        self.init()
        self.albumId = photoModel.albumId
        self.id = photoModel.id
        self.title = photoModel.title
        self.url = photoModel.url
        self.thumbnailUrl = photoModel.thumbnailUrl
        isFavorite = false
    }
}
