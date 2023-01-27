//
//  SceneDelegate.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        var startViewController: UIViewController!
        
        if let launchedBefore = UserDefaults.standard.object(forKey: "launchedBefore") as? Bool, launchedBefore {
            startViewController = MainViewController()
        } else {
            startViewController = MainViewController()
        }
        
        let navigationController = UINavigationController(rootViewController: startViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
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
