//
//  FollowersViewController.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 31.01.2024.
//

import UIKit

class FollowersListViewController: UIViewController {
    //MARK: - UI Elements
    var collectionView: UICollectionView!
    
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
        configureCollectionView()
    }
}

//MARK: - Fetch Data
extension FollowersListViewController {
    private func fetchFollowers(){
        NetworkManager.shared.getFollowers(username: username, page: 1) { (result) in
            switch result {
            case .success(let followersList):
                print(followersList)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", bodyTitle: error.rawValue, buttonTitle: Theme.AppTitle.alertButtonTitle.rawValue)
            }
        }
    }
}

//MARK: - Configure Collection View
extension FollowersListViewController {
    private func configureCollectionView(){
        //collectionView expand whole screen(frame: view.bounds)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowersCollectionViewCell.self, forCellWithReuseIdentifier: Theme.Identifier.followerCellID.rawValue)
    }
}
