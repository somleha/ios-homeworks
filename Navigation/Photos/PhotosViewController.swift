//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Алексей Самойлов on 27.03.2023.
//

import UIKit

class PhotosViewController: UIViewController {
    fileprivate lazy var photosData: [PhotosForApp] = PhotosForApp.make()
//MARK: - Subviews
    private lazy var photoGalleryCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier.base.rawValue)
        return collectionView
    }()
    private enum CellIdentifier: String {
        case base = "PhotosCollectionViewCell"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tuneView()
        addSubviews()
        setupConstraints()
        setupCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = "Photo Gallery"
        navigationController?.navigationBar.tintColor = UIColor(named: "VKColor")
    }
    
//MARK: - Private functions
    private func tuneView() {
        view.backgroundColor = .white
    }
    private func addSubviews() {
        view.addSubview(photoGalleryCollectionView)
    }
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            photoGalleryCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            photoGalleryCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            photoGalleryCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            photoGalleryCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    private func setupCollectionView() {
        photoGalleryCollectionView.delegate = self
        photoGalleryCollectionView.dataSource = self
    }
    
//MARK: - @OBJC
    @objc func infoButtonPressed (_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
}

//MARK: - Extensions
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoGalleryCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.base.rawValue, for: indexPath) as! PhotosCollectionViewCell
        let photos = photosData[indexPath.row]
        cell.setupImages(with: photos)
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = view.frame.width
        let totalOffsets: CGFloat = 8 * 6
        let cellWidth = (screenWidth - totalOffsets)/3
        let size = CGSize(width: cellWidth, height: cellWidth)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
