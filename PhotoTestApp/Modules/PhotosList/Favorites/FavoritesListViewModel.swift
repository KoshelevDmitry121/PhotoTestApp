//
//  FavoritesListViewModel.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 03.09.2023.
//

final class FavoritesListViewModel {
    
    weak var viewController: FavoritesListViewController?
    
    private let model = FavoritesListModel()
    
    private var photosList: [Photo] = []
    var sections: [PortfolioSectionData] = []
    
    func loadList() {
        photosList = model.getPhotosList()
        sections = [
            PortfolioSectionData(
                section: PhotosListSection.photos,
                rows: photosList.map {
                    PhotosListRow.photo($0)
                }
            )
        ]
        viewController?.loadTableView(isFavoritesEmpty: photosList.isEmpty)
    }
    
}
