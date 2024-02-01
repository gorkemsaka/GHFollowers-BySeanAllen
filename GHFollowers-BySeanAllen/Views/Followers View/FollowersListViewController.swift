//
//  FollowersViewController.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 31.01.2024.
//

import UIKit

class FollowersListViewController: UIViewController {
    //MARK: - UI Elements
    
    //MARK: - Properties
    var username: String!
    
    //MARK: - Life Cycyle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    //MARK: - Functions
    private func configure(){
        view.backgroundColor = .systemBackground
        // new navigationTitle style
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchFollowers()
    }
}

extension FollowersListViewController {
    private func fetchFollowers(){
        NetworkManager.shared.getFollowers(username: username, page: 1) { followersList, errorMessage in
            guard let followersList = followersList else {
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", bodyTitle: errorMessage!.rawValue, buttonTitle: Theme.AppTitle.alertButtonTitle.rawValue)
                return
            }
            print("Followers.count = \(followersList.count)")
            print(followersList)
        }
    }
}
