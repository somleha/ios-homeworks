//
//  InfoViewController.swift
//  Navigation
//
//  Created by Алексей Самойлов on 10.03.2023.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var alertButton: UIButton = {
        let alertButton = UIButton()
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        alertButton.setTitle("Some alert", for: .normal)
        alertButton.setTitleColor(.black, for: .normal)
        alertButton.addTarget(self, action: #selector(alertButtonPressed(_:)), for: .touchUpInside)
        return alertButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        view.addSubview(alertButton)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            alertButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            alertButton.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
    
    @objc func alertButtonPressed (_ sender: UIButton) {
        let alert = UIAlertController(title: "Тут что-то", message: "Нажми на кнопку - получишь пирожок", preferredStyle: .alert)
        let pieButton = UIAlertAction(title: "Получить пирожок", style: .default, handler: givePie(_:))
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(pieButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
    @objc func givePie (_ sender: UIAlertAction) {
        print("Получил и распишись")
    }
}
