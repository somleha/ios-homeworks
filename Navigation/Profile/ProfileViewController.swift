//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Алексей Самойлов on 09.03.2023.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {
//MARK: - Data
    fileprivate lazy var data = PostForApp.make()
    
//MARK: - Создадим таблицу
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private enum CellReuseID: String {
        case base = "PostTableViewCell"
        case photos = "PhotosTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstraints()
        tuneTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
//MARK: - Методы
    private func setupView() {
        #if DEBUG
        view.backgroundColor = .systemGray6
        #else
        view.backgroundColor = .cyan
        #endif
        view.isUserInteractionEnabled = true
    }
    private func addSubviews() {
        view.addSubview(profileTableView)
    }
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    private func tuneTableView() {
        profileTableView.rowHeight = UITableView.automaticDimension
        profileTableView.estimatedRowHeight = 200
        
        let headerView = ProfileHeaderView()
        profileTableView.setAndLayout(headerView: headerView)
        let profilePhotoTap = UITapGestureRecognizer(target: self, action: #selector(didTappedPhoto))
        headerView.profilePhoto.addGestureRecognizer(profilePhotoTap)
        profileTableView.tableFooterView = UIView()
        
        profileTableView.register(PostTableViewCell.self, forCellReuseIdentifier: CellReuseID.base.rawValue)
        profileTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: CellReuseID.photos.rawValue)
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
    }
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    @objc func didTappedPhoto() {
        let vc = PhotoFullViewController(image: ProfileHeaderView().profilePhoto.image)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
}

//MARK: - Extensions
extension ProfileViewController: UITableViewDelegate {}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return data.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseID.photos.rawValue, for: indexPath) as? PhotosTableViewCell
            else {
                fatalError("couldn't dequeReusableCell")
            }
            cell.onAction = {
                self.navigationController?.pushViewController(PhotosViewController(), animated: true)
            }
            return cell
        }
        guard let cell = profileTableView.dequeueReusableCell(withIdentifier: CellReuseID.base.rawValue,for: indexPath) as? PostTableViewCell
        else {
            fatalError("couldn't dequeReusableCell")
        }
        cell.update(data[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.section
        if selectedRow == 0 {
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        }
    }
}
