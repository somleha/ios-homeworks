//
//  FeedViewController.swift
//  Navigation
//
//  Created by Алексей Самойлов on 09.03.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "Important feed")
    
    //MARK: - Создадим кнопку
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("WARNING FEED!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(actionButton)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
        view.backgroundColor = .systemBlue
        title = "Feed"
        actionButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    @objc func buttonPressed (_ sender: UIButton) {
        navigationController?.pushViewController(PostViewController(post: post), animated: true)
    }
}
protocol PostType {
    var title: String {get set}
}
struct Post: PostType {
    var title: String
}
