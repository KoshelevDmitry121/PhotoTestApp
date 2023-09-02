//
//  PhotoCell.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 02.09.2023.
//

import UIKit

final class PhotoCell: UITableViewCell {
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.lineBreakMode = .byTruncatingTail
        return view
    }()
    
    private lazy var albumIdLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var idLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        addSubviews(
            photoImageView,
            titleLabel,
            albumIdLabel,
            idLabel
        )
        setupConstraints()
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.size.equalTo(60)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.leading.equalTo(photoImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(-10)
        }
        albumIdLabel.snp.makeConstraints {
            $0.bottom.equalTo(-5)
            $0.leading.equalTo(titleLabel)
        }
        idLabel.snp.makeConstraints {
            $0.bottom.equalTo(albumIdLabel)
            $0.trailing.equalTo(titleLabel)
        }
    }
    
    func configure(model: PhotoModel) {
        photoImageView.loadImage(from: model.thumbnailUrl)
        titleLabel.text = model.title
        albumIdLabel.text = "Album Id: \(model.albumId)"
        idLabel.text = "Id: \(model.id)"
    }
    
}
