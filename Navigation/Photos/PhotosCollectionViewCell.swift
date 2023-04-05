//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Алексей Самойлов on 27.03.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    lazy var photoImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Private functions
    private func setupSubviews() {
        contentView.addSubview(photoImage)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
//MARK: - Public functions
    func setupImages(with image: PhotosForApp){
        photoImage.image = UIImage(named: image.photoName)
    }
}
