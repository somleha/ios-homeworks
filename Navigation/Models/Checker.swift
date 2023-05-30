//
//  Checker.swift
//  Navigation
//
//  Created by Алексей Самойлов on 29.05.2023.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func check(login: String, password: String) -> Bool
}

final class Checker {
    static let shared = Checker()
    private init() {}
    private var login: String = "login"
    private var password: String = "pass"
    
    func check(login: String, password: String) -> Bool {
        print("Что-то")
        if login == self.login && password == self.password {
            return true
        } else {
            return false
        }
    }
}

final class LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        print("Что-то")
        return Checker.shared.check(login: login, password: password)
    }
}
