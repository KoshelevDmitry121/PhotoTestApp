//
//  PhotosViewController.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 03.09.2023.
//

import UIKit
import Factory
import RealmSwift

final class PhotosViewController: UIViewController {
    
    @Injected(\.storageService) private var storageService
    
    private let model: Photo
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    init(model: Photo) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Photo"
        
        setupFavoritesButton()
        view.backgroundColor = .white
        photoImageView.loadImage(from: model.url)
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupSubviews() {
        view.addSubview(photoImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        photoImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(photoImageView.snp.width)
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc private func toggleFavorite() {
        storageService.updateModel(id: model.id, isFavorite: !model.isFavorite)
        setupFavoritesButton()
    }
    
    private func setupFavoritesButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: model.isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"),
            style: .done,
            target: self,
            action: #selector(toggleFavorite)
        )
    }

}
