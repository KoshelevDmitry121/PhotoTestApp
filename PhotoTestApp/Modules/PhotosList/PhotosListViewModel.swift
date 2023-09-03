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
    
    var sections: [PortfolioSectionData] = []
    
    func loadList() {
        Task {
            let photosList = await model.getPhotosList()
            sections = [
                PortfolioSectionData(
                    section: PhotosListSection.photos,
                    rows: photosList.map {
                        PhotosListRow.photo($0)
                    }
                )
            ]
            await viewController?.loadTableView()
        }
    }
    
}
