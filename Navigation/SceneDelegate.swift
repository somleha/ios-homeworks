//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Алексей Самойлов on 09.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: sceneWindow)
        window.makeKeyAndVisible()
        self.window = window
        
        //MARK: - Создадим объекты NavigationController и PostViewController
        #if DEBUG
        let savedUser = User(login: "login", fullName: "alex", status: "Active!", profilePhoto: UIImage(named: "cat")!)
        let service: UserService = TestUserService(user: savedUser)
        #else
        let savedUser = User(login: "test", fullName: "test", status: "test!!!", profilePhoto: UIImage(named: "team13")!)
        let service: UserService = CurrentUserService(user: savedUser)
        #endif
        let profileNavigationController = UINavigationController(rootViewController: LogInViewController(userService: service))
        let feedNavigationController = UINavigationController(rootViewController: FeedViewController())
        
        //MARK: - Cделаем TabBar и настроим цвета
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .systemGray5
        tabBarController.tabBar.unselectedItemTintColor = .systemGray
        tabBarController.tabBar.tintColor = UIColor(named: "VKColor")
        
        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
        feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper.fill"), tag: 0)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        tabBarController.selectedIndex = 0
        window.rootViewController = tabBarController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}

