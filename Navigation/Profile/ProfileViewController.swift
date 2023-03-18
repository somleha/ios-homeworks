//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Алексей Самойлов on 09.03.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    private lazy var profileHeaderView = ProfileHeaderView()
    private lazy var changeTitleButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Like this profile", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Profile"
        view.addSubview(profileHeaderView)
        view.addSubview(changeTitleButton)
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            changeTitleButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            changeTitleButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            changeTitleButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
