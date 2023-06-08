//
//  PhotoFullViewController.swift
//  Navigation
//
//  Created by Алексей Самойлов on 05.04.2023.
//

import UIKit

class PhotoFullViewController: UIViewController {
    private lazy var photoFullView: UIImageView = {
       let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    private lazy var closeButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
//MARK: - Initialization photo
    init(image: UIImage?) {
       super.init(nibName: nil, bundle: nil)
       photoFullView.image = image
    }
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
    }
//MARK: - Private functions
    private func setupSubviews() {
        view.addSubview(photoFullView)
        view.addSubview(closeButton)
    }
    private func setupConstraints(){
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            photoFullView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            photoFullView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            photoFullView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            photoFullView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            photoFullView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            photoFullView.heightAnchor.constraint(equalTo: safeArea.widthAnchor),
            
            closeButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            closeButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
        ])
    }
//MARK: - @objc functions
    @objc func didTapCloseButton() {
        self.dismiss(animated: true)
    }
}
