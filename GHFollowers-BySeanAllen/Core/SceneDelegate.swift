//
//  SceneDelegate.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 30.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
    }
     
    func createNavigationController(vc: UIViewController, title: String, tabBarSystemItem: UITabBarItem.SystemItem, tag: Int) -> UINavigationController{
        vc.title = title
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: tabBarSystemItem, tag: tag)
        return UINavigationController(rootViewController: vc)
    }
    
    func createTabbar() -> UITabBarController{
        let searchVC = SearchViewController()
        let favoriteVC = FavoritesViewController()
        let tabbar = UITabBarController()
        
        let searchNC = createNavigationController(vc: searchVC, title: Theme.AppTitle.searchBarTitle.rawValue, tabBarSystemItem: .search, tag: 0)
        let favoriteNC = createNavigationController(vc: favoriteVC, title: Theme.AppTitle.favoriteBarTitle.rawValue, tabBarSystemItem: .favorites, tag: 1)
        UITabBar.appearance().tintColor = .systemGreen
        tabbar.viewControllers = [searchNC,favoriteNC]
        return tabbar
    }

}

