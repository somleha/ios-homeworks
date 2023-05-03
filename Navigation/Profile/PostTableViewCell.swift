//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Алексей Самойлов on 22.03.2023.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
//MARK: - Создадим элементы секции таблицы
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var imageFeed: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var likesLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var viewsLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//MARK: - Отрисовка ячейки
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        tuneView()
        addSubviews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Методы
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageFeed)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
    }
    private func tuneView() {
        contentView.backgroundColor = .white
        accessoryType = .none
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            imageFeed.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            imageFeed.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageFeed.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageFeed.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageFeed.heightAnchor.constraint(equalTo: imageFeed.widthAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: imageFeed.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: likesLabel.topAnchor, constant: -16),
            
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func update(_ model: PostForApp) {
        titleLabel.text = model.author
        imageFeed.image = UIImage(named: model.image)
        descriptionLabel.text = model.description
        likesLabel.text = "Likes:" + " " + String(model.likes)
        viewsLabel.text = "Views:" + " " + String(model.views)
    }
}
