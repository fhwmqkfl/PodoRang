//
//  SceneDelegate.swift
//  PodoRang
//
//  Created by coco on 2023/05/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setRootViewController(scene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

extension SceneDelegate {
    private func setRootViewController(_ scene: UIScene) {
        if UserDefaults.standard.string(forKey: "userName") != nil, UserDefaults.standard.data(forKey: "userImage") != nil {
            setRootViewController(scene, name: "Main", identifier: "TabBarController")
        } else {
            setRootViewController(scene, name: "Main", identifier: "ProfileViewController")
        }
    }
    
    private func setRootViewController(_ scene: UIScene, name: String, identifier: String) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let storyboard = UIStoryboard(name: name, bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
            window.rootViewController = viewController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
