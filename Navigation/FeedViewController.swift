//
//  FeedViewController.swift
//  Navigation
//
//  Created by Алексей Самойлов on 09.03.2023.
//

import UIKit

class FeedViewController: UIViewController {
//MARK: - Создадим элементы формы
    var post = Post(title: "Important feed")
    private lazy var checkingWordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Check", titleColor: .white, isEnabled: true) { [unowned self] in
            guard let guess = checkingWordTextField.text, !guess.isEmpty else {return}
            var isCorrect: () = FeedModel().check(word: guess)
        }
        return button
        }()
    private lazy var statusCheckLabel: UILabel = {
       let label = UILabel()
        label.text = " "
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("WARNING FEED!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var actionButtonSecond: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("WARNING FEED!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.addArrangedSubview(self.actionButton)
        stackView.addArrangedSubview(self.actionButtonSecond)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        title = "Feed"
        view.addSubview(checkingWordTextField)
        view.addSubview(checkGuessButton)
        view.addSubview(stackView)
        view.addSubview(statusCheckLabel)
        setupConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchFunc), name: FeedModel.checkResultNotification, object: nil)
        
//MARK: - Методы
    }
    @objc func buttonPressed(_ sender: UIButton) {
        navigationController?.pushViewController(PostViewController(post: post), animated: true)
    }
    @objc func fetchFunc(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any], let isCorrect = userInfo["isCorrect"] as? Bool else {return}
        if isCorrect {
            statusCheckLabel.text = "Верно!"
            statusCheckLabel.textColor = .green
        } else {
            statusCheckLabel.text = "Ошибка!"
            statusCheckLabel.textColor = .red
        }
    }
    
//MARK: - Разметка
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            checkingWordTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            checkingWordTextField.trailingAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: -8),
            checkingWordTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            checkingWordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            checkGuessButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            checkGuessButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            checkGuessButton.leadingAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 8),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 40),
            
            statusCheckLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            statusCheckLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            statusCheckLabel.topAnchor.constraint(equalTo: checkingWordTextField.bottomAnchor, constant: 8),
            statusCheckLabel.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: statusCheckLabel.bottomAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8)
        ])
    }
}

//MARK: - Дополнительные протоколы
protocol PostType {
    var title: String {get set}
}
struct Post: PostType {
    var title: String
}
