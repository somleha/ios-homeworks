//
//  Extensions.swift
//  Navigation
//
//  Created by Алексей Самойлов on 22.03.2023.
//

import UIKit

extension UITableView {
    func setAndLayout(headerView: UIView) {
        tableHeaderView = headerView
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: widthAnchor),
            ])
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
            headerView.frame.size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
