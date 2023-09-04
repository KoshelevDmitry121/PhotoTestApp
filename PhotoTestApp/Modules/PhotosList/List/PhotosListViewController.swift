//
//  PhotosListViewController.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 02.09.2023.
//

import UIKit
import SnapKit

final class PhotosListViewController: ListViewController {
    
    private let viewModel: PhotosListViewModel
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController()
        controller.searchResultsUpdater = self
        controller.extendedLayoutIncludesOpaqueBars = true
        return controller
    }()
    
    init(viewModel: PhotosListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "List"
        navigationItem.searchController = searchController
    }
    
    func loadTableView() {
        var snapshot = Snapshot()
        for item in viewModel.sections {
            snapshot.appendSections([item.section])
            snapshot.appendItems(item.rows, toSection: item.section)
        }
        tableViewDataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

// MARK: - UISearchResultsUpdating

extension PhotosListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        viewModel.loadList(filteredText: text)
    }
    
}
