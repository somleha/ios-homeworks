//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Алексей Самойлов on 09.03.2023.
//

import UIKit

class ProfileViewController: UIViewController {
//MARK: - Data
    fileprivate let data = PostForApp.make()
    
//MARK: - Создадим таблицу
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private enum CellReuseID: String {
        case base = "PostTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstraints()
        tuneTableView()
    }
    
//MARK: - Методы
    private func setupView() {
        view.backgroundColor = .systemGray6
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
        profileTableView.tableFooterView = UIView()
        
        profileTableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.base.rawValue
        )
        profileTableView.dataSource = self
        profileTableView.delegate = self
    }
}

extension ProfileViewController: UITableViewDelegate {}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = profileTableView.dequeueReusableCell(
            withIdentifier: CellReuseID.base.rawValue,
            for: indexPath) as? PostTableViewCell
        else {
            fatalError("couldn't dequeReusableCell")
        }
        cell.update(data[indexPath.row])
        return cell
    }
}
