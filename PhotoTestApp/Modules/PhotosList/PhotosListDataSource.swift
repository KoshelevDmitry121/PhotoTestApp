//
//  PhotosListDataSource.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 02.09.2023.
//

import Foundation

enum PhotosListSection: Hashable {
    case photos
}

enum PhotosListRow: Hashable {
    case photo(PhotoModel)
}

struct PortfolioSectionData {

    var section: PhotosListSection
    var rows: [PhotosListRow]

}
