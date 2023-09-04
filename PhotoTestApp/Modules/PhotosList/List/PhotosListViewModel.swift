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
    
    private var photosList: [Photo] = []
    var sections: [PortfolioSectionData] = []
    
    init() {
        Task {
            photosList = await model.getPhotosList()
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
    
    func loadList(filteredText: String? = nil) {
        sections = [
            PortfolioSectionData(
                section: PhotosListSection.photos,
                rows: photosList
                    .filter {
                        guard let filteredText else { return true }
                        return $0.title.lowercased().starts(with: filteredText)
                    }
                    .map {
                        PhotosListRow.photo($0)
                    }
            )
        ]
        viewController?.loadTableView()
    }
    
}
