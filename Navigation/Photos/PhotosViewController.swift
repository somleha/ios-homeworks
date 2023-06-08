//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Алексей Самойлов on 27.03.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    private lazy var imagePublisherFacade = ImagePublisherFacade()
    lazy var loadedPhotos: [UIImage] = []
    fileprivate lazy var photosData: [PhotosForApp] = PhotosForApp.make() //старый массив фотографий
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
        imagePublisherFacade.subscribe(self)
        imagePublisherFacade.addImagesWithTimer(time: 1, repeat: 20, userImages: newPhotoCollection)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = "Photo Gallery"
        navigationController?.navigationBar.tintColor = UIColor(named: "VKColor")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imagePublisherFacade.removeSubscription(for: self)
        imagePublisherFacade.rechargeImageLibrary()
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
        loadedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoGalleryCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.base.rawValue, for: indexPath) as! PhotosCollectionViewCell
        let photos = loadedPhotos[indexPath.row]
        cell.setupImages(with: photos)
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = view.frame.width
        let totalOffsets: CGFloat = 8 * 5
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photos = loadedPhotos[indexPath.row]
        let vc = PhotoFullViewController(image: photos)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        loadedPhotos = images
        photoGalleryCollectionView.reloadData()
    }
}
