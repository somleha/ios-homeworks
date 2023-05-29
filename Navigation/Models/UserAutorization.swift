//
//  UserAutorization.swift
//  Navigation
//
//  Created by Алексей Самойлов on 22.05.2023.
//

import Foundation
import UIKit

protocol UserService {
    func getUser(login: String) -> User?
}

final class User {
    let login: String
    let fullName: String
    let status: String
    let profilePhoto: UIImage
    init(login: String, fullName: String, status: String, profilePhoto: UIImage) {
        self.login = login
        self.fullName = fullName
        self.status = status
        self.profilePhoto = profilePhoto
    }
}

public class CurrentUserService: UserService {
    private let user: User
    let savedUser = User(login: "login", fullName: "alex", status: "Active!", profilePhoto: UIImage(named: "cat")!)
    func getUser(login: String) -> User? {
        if login == savedUser.login {
            return savedUser
        } else {
            return nil
        }
    }
    init(user: User) {
        self.user = user
    }
}

public class TestUserService: UserService {
    private let user: User
    let savedUser = User(login: "test", fullName: "test", status: "test!!!", profilePhoto: UIImage(named: "team13")!)
    func getUser(login: String) -> User? {
        if login == savedUser.login {
            return savedUser
        } else {
            return nil
        }
    }
    init(user: User) {
        self.user = user
    }
}
