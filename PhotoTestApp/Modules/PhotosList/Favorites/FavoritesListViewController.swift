//
//  FavoritesListViewController.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 03.09.2023.
//

import UIKit

final class FavoritesListViewController: ListViewController {
    
    private let viewModel: FavoritesListViewModel
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = .zero
        view.lineBreakMode = .byTruncatingTail
        view.textColor = .black
        view.textAlignment = .center
        view.text = "There are no favorites yet"
        return view
    }()
    
    init(viewModel: FavoritesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Favorites"
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(120)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.loadList()
    }
    
    func loadTableView(isFavoritesEmpty: Bool) {
        tableView.isHidden = isFavoritesEmpty
        titleLabel.isHidden = !isFavoritesEmpty
        
        if !isFavoritesEmpty {
            var snapshot = Snapshot()
            for item in viewModel.sections {
                snapshot.appendSections([item.section])
                snapshot.appendItems(item.rows, toSection: item.section)
            }
            tableViewDataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
}
