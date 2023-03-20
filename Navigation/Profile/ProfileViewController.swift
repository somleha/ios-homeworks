//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Алексей Самойлов on 09.03.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    private lazy var profileHeaderView = ProfileHeaderView()
    
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
