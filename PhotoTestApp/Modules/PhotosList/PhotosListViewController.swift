//
//  PhotosListViewController.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 02.09.2023.
//

import UIKit
import SnapKit

final class PhotosListViewController: UIViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<PhotosListSection, PhotosListRow>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PhotosListSection, PhotosListRow>
    
    private let viewModel: PhotosListViewModel
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController()
        controller.searchResultsUpdater = self
        controller.extendedLayoutIncludesOpaqueBars = true
        return controller
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.separatorStyle = .none
        view.backgroundColor = .white
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.rowHeight = UITableView.automaticDimension
        view.register(PhotoCell.self, forCellReuseIdentifier: String(describing: PhotoCell.self))
        view.delegate = self
        return view
    }()
    
    private lazy var tableViewDataSource = DataSource(tableView: tableView) { [weak self] tableView, indexPath, row in
        switch row {
        case let .photo(photo):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: PhotoCell.self),
                for: indexPath
            ) as? PhotoCell else { return UITableViewCell() }
            cell.configure(model: photo)
            return cell
        }
     }
    
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
        view.backgroundColor = .white
        setupSubviews()
    }
    
    @MainActor
    func loadTableView() {
        var snapshot = Snapshot()
        for item in viewModel.sections {
            snapshot.appendSections([item.section])
            snapshot.appendItems(item.rows, toSection: item.section)
        }
        tableViewDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
        setupConstraints()
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

// MARK: - UITableViewDelegate

extension PhotosListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = tableViewDataSource.snapshot().itemIdentifiers[indexPath.row]
        switch row {
        case let .photo(model):
            let photosViewController = PhotosViewController(imageUrl: model.url)
            navigationController?.pushViewController(photosViewController, animated: true)
        }
    }

}

// MARK: - UISearchResultsUpdating

extension PhotosListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        viewModel.loadList(filteredText: text)
    }
    
}
