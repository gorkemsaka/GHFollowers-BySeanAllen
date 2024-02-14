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
    var username: String!
    var followersList: [Followers] = []
    var page = 1
    var hasMoreFollowers = true
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
        navigationController?.navigationBar.prefersLargeTitles = true
        configureCollectionView()
        configureDataSource()
        getFollowers(username: username, page: page)
    }
}

//MARK: - Fetch Data
extension FollowersListViewController {
     func getFollowers(username: String, page: Int){
     showLoadingView()
        NetworkManager.shared.fetchFollowers(username: username, page: page) { [weak self] result in
            guard let self = self else { return }
            dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false } // customer has another 100 followers or not
                self.followersList.append(contentsOf: followers)
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
        collectionView.delegate = self
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
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}

//MARK: - CollectionView Scroll Setup
extension FollowersListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y            // vertical scrollview position height
        let contentHeight = scrollView.contentSize.height   // entire content height of scrollView
        let screenHeight = scrollView.frame.size.height     // screen height of scrollViewb
        
        if offsetY > contentHeight - screenHeight {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}
 
