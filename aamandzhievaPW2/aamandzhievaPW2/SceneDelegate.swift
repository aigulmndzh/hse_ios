//
//  SceneDelegate.swift
//  aamandzhievaPW2
//
//  Created by Айгуль Манджиева on 07.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationCotroller =
            UINavigationController(rootViewController: WelcomeViewController())
        window.rootViewController = navigationCotroller
        self.window = window
        window.makeKeyAndVisible()
    }
    
    
}

