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
    lazy var profilePhoto: UIImageView = {
        let view = UIImageView(image: UIImage(named: "cat"))
        view.layer.cornerRadius = 60
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
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
    private lazy var setStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Set status", for: .normal)
        button.backgroundColor = UIColor(named: "VKColor")
        button.tintColor = .white
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.isEnabled = false
        button.addTarget(self, action: #selector(buttonStatusPressed), for: .touchUpInside)
        return button
    }()
    
//MARK: - Добавим статус профиля
    private lazy var profileStatus: UILabel = {
       let label = UILabel()
        label.text = "Set status"
        label.font = UIFont(name: "Helvetica-regular", size: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

//MARK: - Добавим TextField для изменения статуса
    private lazy var statusChangeTextField: UITextField = {
       let textField = TextFieldWithPadding()
        textField.placeholder = "Set your status"
        textField.layer.cornerRadius = 12
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont(name: "Helvetica-regular", size: 15)
        textField.tintColor = UIColor(named: "VKColor")
        textField.textColor = .black
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
//MARK: - Разместим все на UIView
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupConstraints()
        hideKeyboardWhenTappedAround()
        backgroundColor = .systemGray6
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Методы для элементов и их расположения
    private func addSubViews () {
        addSubview(profilePhoto)
        addSubview(profileName)
        addSubview(setStatusButton)
        addSubview(profileStatus)
        addSubview(statusChangeTextField)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profilePhoto.widthAnchor.constraint(equalToConstant: 120),
            profilePhoto.heightAnchor.constraint(equalToConstant: 120),
            profilePhoto.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profilePhoto.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            
            profileName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            profileName.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 16),
            profileName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            setStatusButton.topAnchor.constraint(equalTo: statusChangeTextField.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            profileStatus.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 52),
            profileStatus.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 16),
            profileStatus.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            statusChangeTextField.topAnchor.constraint(equalTo: profileStatus.bottomAnchor, constant: 2),
            statusChangeTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusChangeTextField.heightAnchor.constraint(equalToConstant: 40),
            statusChangeTextField.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 16)
        ])
    }
    
//MARK: - Методы для обработки действий
    @objc func buttonStatusPressed (_ sender: UIButton) {
        profileStatus.text = statusTextChanged(statusChangeTextField)
        if profileStatus.text != "" {
            setStatusButton.isEnabled = true
        }
        setStatusButton.isEnabled = false
        print(profileStatus.text ?? "Ничего тут нет")
        statusChangeTextField.text = nil
    }
    
    @objc func statusTextChanged (_ sender: UITextField) -> String {
        var statusText: String
        if statusChangeTextField.text == "" {
            statusText = "Set status"
            setStatusButton.isEnabled = false
        } else {
            statusText = statusChangeTextField.text ?? "Nothing there..."
            profileStatus.textColor = .gray
            statusChangeTextField.textColor = .black
            setStatusButton.isEnabled = true
        }
        return statusText
    }
    @objc func dismissKeyboad(){
        endEditing(true)
    }
//MARK: - Подкласс для отсупов в TextField
    class TextFieldWithPadding: UITextField {
        var textPadding = UIEdgeInsets (
            top: 8,
            left: 8,
            bottom: 8,
            right: 8
        )
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.textRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.editingRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileHeaderView.dismissKeyboad))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
}
