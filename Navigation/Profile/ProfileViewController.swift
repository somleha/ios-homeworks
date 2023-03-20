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
        button.setTitle("Change title", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Profile"
        view.addSubview(profileHeaderView)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = view.bounds
    }
}
