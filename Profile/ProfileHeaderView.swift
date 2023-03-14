//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Алексей Самойлов on 14.03.2023.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView {
//MARK: - Создадим фото профиля
    private lazy var profilePhoto: UIImageView = {
        let view = UIImageView(image: UIImage(named: "cat"))
        view.layer.cornerRadius = 60
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//MARK: - Добавим имя профиля
    private lazy var profileName: UILabel = {
       let label = UILabel()
        label.text = "Hipster Cat"
        label.font = UIFont(name: "Helvetica-bold", size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//MARK: - Добавим кнопку
    private lazy var showStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show status", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        
//MARK: - Добавим действие по кнопке
        button.addTarget(self, action: #selector(buttonStatusPressed), for: .touchUpInside)
        return button
    }()
    
//MARK: - Добавим статус профиля
    private lazy var profileStatus: UILabel = {
       let label = UILabel()
        label.text = "Waiting for something..."
        label.font = UIFont(name: "Helvetica-regular", size: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//MARK: - Разместим все на UIView
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(profilePhoto)
        addSubview(profileName)
        addSubview(showStatusButton)
        addSubview(profileStatus)
        setupConstraints()
    }
    
//MARK: - Разместим в нужном месте все
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profilePhoto.widthAnchor.constraint(equalToConstant: 120),
            profilePhoto.heightAnchor.constraint(equalToConstant: 120),
            profilePhoto.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profilePhoto.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            
            profileName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            profileName.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 16),
            profileName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            showStatusButton.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 16),
            showStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            showStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            profileStatus.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -34),
            profileStatus.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 16),
            profileStatus.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    @objc func buttonStatusPressed (_ sender: UIButton) {
        print(profileStatus.text ?? "Ничего тут нет")
    }
}
