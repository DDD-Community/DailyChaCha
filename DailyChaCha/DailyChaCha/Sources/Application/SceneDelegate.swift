//
//  SceneDelegate.swift
//  DailyChaCha
//
//  Created by Jaewook on 2022/05/18.
//

import UIKit

import RIBs

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var launchRouter: LaunchRouting?

    func scene(
      _ scene: UIScene,
      willConnectTo session: UISceneSession,
      options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: scene)
        self.window = window

        let rootBuilder = RootBuilder(dependency: EmptyComponent())
        let router = rootBuilder.build()
        launchRouter = router

        router.launch(from: window)
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}



