//
//  PhotoModel.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 02.09.2023.
//

import Foundation

struct PhotoModel: Decodable, Hashable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
