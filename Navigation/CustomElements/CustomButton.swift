//
//  CustomButton.swift
//  Navigation
//
//  Created by Алексей Самойлов on 12.06.2023.
//

import UIKit

class CustomButton: UIButton {
    private var callback: (() -> Void)
    
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
    
    @objc private func buttonTapped() {
        callback()
    }
    
    init (title: String, titleColor: UIColor, isEnabled: Bool, callback: @escaping (() -> Void)) {
        self.callback = callback
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.isEnabled = isEnabled
        self.backgroundColor = UIColor(named: "VKColor")
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 4
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
}
