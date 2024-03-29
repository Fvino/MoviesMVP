// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    var navController = UINavigationController()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
//        let listViewController = ListViewController()
        let moviePresenter = MoviePresenter()
        let listVC = MainViewController()
        moviePresenter.presenterSetUp(listView: listVC)
        listVC.presenter = moviePresenter
        navController = UINavigationController(rootViewController: listVC)

        window?.rootViewController = navController
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
