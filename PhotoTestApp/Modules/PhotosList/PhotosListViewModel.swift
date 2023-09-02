//
//  PhotosListViewModel.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 02.09.2023.
//

import Foundation

final class PhotosListViewModel {
    
    weak var viewController: PhotosListViewController?
    
    private let model = PhotosListModel()
    
    var sections: [PortfolioSectionData] = [
        PortfolioSectionData(
            section: PhotosListSection.photos,
            rows: [
                PhotosListRow.photo(
                    PhotoModel(
                        albumId: 1,
                        id: 1,
                        title: "accusamus beatae ad facilis cum similique qui sunt",
                        url: "https://via.placeholder.com/600/92c952",
                        thumbnailUrl: "https://via.placeholder.com/150/92c952"
                    )
                )
            ]
        )
    ]
    
}
