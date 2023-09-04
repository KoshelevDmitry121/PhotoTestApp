//
//  ListViewController.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 03.09.2023.
//

import UIKit

class ListViewController: UIViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<PhotosListSection, PhotosListRow>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PhotosListSection, PhotosListRow>
    
    lazy var tableView: UITableView = {
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
    
    lazy var tableViewDataSource = DataSource(tableView: tableView) { [weak self] tableView, indexPath, row in
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSubviews()
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

extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = tableViewDataSource.snapshot().itemIdentifiers[indexPath.row]
        switch row {
        case let .photo(model):
            let photosViewController = PhotosViewController(model: model)
            navigationController?.pushViewController(photosViewController, animated: true)
        }
    }

}
