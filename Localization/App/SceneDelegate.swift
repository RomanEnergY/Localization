//
//  SceneDelegate.swift
//  Localization
//
//  Created by ZverikRS on 03.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = .init(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: MainScreenBuilder().build())
        window?.makeKeyAndVisible()
    }
}
