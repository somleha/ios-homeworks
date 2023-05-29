//
//  LogInViewController.swift
//  Navigation
//
//  Created by Алексей Самойлов on 20.03.2023.
//

import UIKit

class LogInViewController: UIViewController {
    let userService: UserService
    init(userService: UserService) {
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - ScrollView
    private lazy var loginScrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    private lazy var contentView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//MARK: - Реализуем элементы интерфейса
    private lazy var iconImageLoginScreen: UIImageView  = {
       let iconImage = UIImageView()
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.image = UIImage(named: "VKIcon")
        return iconImage
    }()
    private lazy var loginTextField: UITextField = {
       let loginTextField = TextFieldWithPadding()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Email or phone"
        loginTextField.layer.borderColor = UIColor.lightGray.cgColor
        loginTextField.layer.borderWidth = 0.5
        loginTextField.layer.cornerRadius = 10
        loginTextField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        loginTextField.textColor = .black
        loginTextField.font = UIFont(name: "System-font", size: 16)
        loginTextField.autocapitalizationType = .none
        loginTextField.tintColor = UIColor(named: "VKColor")
        loginTextField.backgroundColor = .systemGray6
        loginTextField.addTarget(self, action: #selector(loginFieldsChanged), for: .editingChanged)
        loginTextField.delegate = self
        return loginTextField
    }()
    private lazy var passwordTextField: UITextField = {
       let passwordTextField = TextFieldWithPadding()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont(name: "System-font", size: 16)
        passwordTextField.autocapitalizationType = .none
        passwordTextField.tintColor = UIColor(named: "VKColor")
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.addTarget(self, action: #selector(loginFieldsChanged), for: .editingChanged)
        passwordTextField.delegate = self
        return passwordTextField
    }()
    private lazy var logInButton: UIButton = {
       let logInButton = CustomButton()
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.setTitle("Log In", for: .normal)
        logInButton.backgroundColor = UIColor(named: "VKColor")
        logInButton.alpha = 0.8
        logInButton.tintColor = .white
        logInButton.layer.cornerRadius = 10
        logInButton.isEnabled = false
        logInButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return logInButton
    }()
    
//MARK: - Запуск экрана
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        setupConstraints()
        setupContentView()
        hideKeyboardWhenTappedAround()
    }
    
//MARK: - Отследим открытие клавиатуры
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
//MARK: - Функция для добавления subviews
    private func addSubViews () {
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
    }
    
//MARK: - Функция для установки constraints
    private func setupContentView() {
        contentView.addSubview(iconImageLoginScreen)
        contentView.addSubview(loginTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(logInButton)
        
        NSLayoutConstraint.activate([
            iconImageLoginScreen.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            iconImageLoginScreen.widthAnchor.constraint(equalToConstant: 100),
            iconImageLoginScreen.heightAnchor.constraint(equalToConstant: 100),
            iconImageLoginScreen.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            loginTextField.topAnchor.constraint(equalTo: iconImageLoginScreen.bottomAnchor, constant: 120),
            loginTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func setupConstraints () {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            loginScrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            loginScrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: loginScrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: loginScrollView.heightAnchor)
        ])
    }
    
//MARK: - Классы для кастомизации элементов
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
    class CustomButton: UIButton {
        override var isHighlighted: Bool {
            didSet {
                if (isHighlighted) {
                    alpha = 0.8
                } else {
                    alpha = 1
                }
            }
        }
        override var isSelected: Bool {
            didSet {
                if (isSelected) {
                    alpha = 0.8
                } else {
                    alpha = 1
                }
            }
        }
    }

//MARK: - Actions
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
//MARK: - @objc functions
    @objc func willShowKeyboard(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            loginScrollView.contentInset.bottom = keyboardSize.height + 55 
        }
    }
    @objc func willHideKeyboard(_ notification: NSNotification) {
        loginScrollView.contentInset.bottom = 0.0
    }
    @objc func loginFieldsChanged (_ sender: UITextField) {
        if (loginTextField.text == "") || (passwordTextField.text == "") {
            logInButton.isEnabled = false
            logInButton.alpha = 0.8
        } else {
            logInButton.isEnabled = true
            logInButton.alpha = 1
        }
    }
    @objc func buttonPressed(_ sender: UIButton) {
        guard let login = loginTextField.text else {return}
        if let user = userService.getUser(login: login) {
            let profileVC = ProfileViewController()
            profileVC.currentUser = user
            navigationController?.pushViewController(profileVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Введен неверный логин", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(cancelButton)
            present(alert, animated: true)
        }
    }
    @objc func dismissKeyboad(){
        view.endEditing(true)
    }
}

//MARK: - Делегат
extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.dismissKeyboad))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
