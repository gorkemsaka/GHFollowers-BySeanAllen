//
//  GFTabBarController.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 28.02.2024.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavoritesNC()]
    }
}

//MARK: - Creating Navigation Controllers
extension GFTabBarController {
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.title = Theme.AppTitle.searchBarTitle.rawValue
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesVC = FavoritesViewController()
        favoritesVC.title = Theme.AppTitle.searchBarTitle.rawValue
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesVC)
    }
}
