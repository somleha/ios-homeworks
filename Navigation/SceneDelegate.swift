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
        let profileNavigationController = UINavigationController(rootViewController: ProfileViewController())
        let feedNavigationController = UINavigationController(rootViewController: FeedViewController())
        
        //MARK: - Cделаем TabBar и настроим цвета
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.tabBar.tintColor = .systemBlue
        
        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
        feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper.circle.fill"), tag: 0)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle.fill"), tag: 1)
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

