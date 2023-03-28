//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Алексей Самойлов on 27.03.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    fileprivate lazy var photosData: [PhotosForApp] = PhotosForApp.make()
//MARK: - Subviews
    private lazy var photosTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Photos"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    private lazy var photosCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier.base.rawValue)
        return collectionView
    }()
    private lazy var photosControllerButton: UIButton = {
       let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.right", withConfiguration: configuration), for: .normal)
        button.tintColor = .black
        return button
    }()
    private enum CellIdentifier: String {
        case base = "PhotosCollectionViewCell"
    }

//MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupView()
        setupConstraints()
        setupCollectionView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        contentView.backgroundColor = .white
    }
    private func addSubviews() {
        contentView.addSubview(photosTitleLabel)
        contentView.addSubview(photosControllerButton)
        contentView.addSubview(photosCollectionView)
    }
    private func setupCollectionView() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photosTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            photosControllerButton.centerYAnchor.constraint(equalTo: photosTitleLabel.centerYAnchor),
            photosControllerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            photosCollectionView.topAnchor.constraint(equalTo: photosTitleLabel.bottomAnchor, constant: 12),
            photosCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photosCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            photosCollectionView.heightAnchor.constraint(equalToConstant: 100),
            photosCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.base.rawValue, for: indexPath) as! PhotosCollectionViewCell
        let photos = photosData[indexPath.row]
        cell.layer.cornerRadius = 6
        cell.clipsToBounds = true
        cell.setupImages(with: photos)
        return cell
    }
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let totalOffsets: CGFloat = 8 * 3 + 12 * 2
        let cellWidth = (screenWidth - totalOffsets) / 4
        let size = CGSize(width: cellWidth, height: cellWidth)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
