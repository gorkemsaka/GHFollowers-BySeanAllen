//
//  FollowersViewController.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 31.01.2024.
//

import UIKit

class FollowersListViewController: UIViewController {
    //MARK: - Section for snapshot
    enum Section {
        case main
    }
    //MARK: - UI Elements
    var collectionView: UICollectionView!
    
    //MARK: - Properties
    var followersList: [Followers] = []
    var username: String!
    var dataSource: UICollectionViewDiffableDataSource <Section, Followers>!
    
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
        configureDataSource()
    }
}

//MARK: - Fetch Data
extension FollowersListViewController {
    private func fetchFollowers(){
        NetworkManager.shared.getFollowers(username: username, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let followersList):
                self.followersList = followersList
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", bodyTitle: error.rawValue, buttonTitle: Theme.AppTitle.alertButtonTitle.rawValue)
            }
        }
    }
}

//MARK: - Configure Collection View & CollectionView Data Source
extension FollowersListViewController {
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(view: view)) //collectionView expand whole screen(frame: view.bounds)
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowersCollectionViewCell.self, forCellWithReuseIdentifier: Theme.Identifier.followerCellID.rawValue)
    }
     
    // 4:50:20 - UICollectionView - Diffable Data Source by iOS Dev Interview Prep Sean Allen just in case
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Followers>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Theme.Identifier.followerCellID.rawValue, for: indexPath) as! FollowersCollectionViewCell
            cell.getData(model: follower)
            return cell
        })
    }
    
     func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Followers>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followersList)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
 
