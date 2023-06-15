//
//  FeedModel.swift
//  Navigation
//
//  Created by Алексей Самойлов on 13.06.2023.
//

import Foundation
import UIKit

final class FeedModel {
    private var secretWord = "Password"
    static let checkResultNotification = Notification.Name("checkResultNotification")
    
    func check(word: String) {
        let isCorrect = word == secretWord
        let userInfo = ["isCorrect": isCorrect]
        NotificationCenter.default.post(name: FeedModel.checkResultNotification, object: nil, userInfo: userInfo)
    }
}
