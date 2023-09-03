//
//  PhotosViewController.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 03.09.2023.
//

import UIKit

final class PhotosViewController: UIViewController {
    
    private let imageUrl: String
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Photo"
        view.backgroundColor = .white
        photoImageView.loadImage(from: imageUrl)
        setupSubviews()
    }
    
    func setupSubviews() {
        view.addSubview(photoImageView)
        setupConstraints()
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(photoImageView.snp.width)
            $0.centerY.equalToSuperview()
        }
    }

}
