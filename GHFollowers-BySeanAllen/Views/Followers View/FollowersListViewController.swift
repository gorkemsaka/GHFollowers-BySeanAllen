//
//  FollowersViewController.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 31.01.2024.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
    func didRequestFollowers(username: String)
}

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
    var filteredFollowers: [Followers] = []
    var page = 1
    var hasMoreFollowers = true
    var dataSource: UICollectionViewDiffableDataSource <Section, Followers>!
    var isSearching = false
    
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
        configureViewController()
        configureCollectionView()
        configureDataSource()
        getFollowers(username: username, page: page)
        configureSearchController()
    }
}

//MARK: - Configure ViewController & Navigaton Bar  
extension FollowersListViewController {
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped(){
        print("add button tapped")
    }
}
//MARK: - Search Controller & CollectionView didSelected
extension FollowersListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false  // when you click search bar, backgorund color won't change
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    // everytime searchbar text got change
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(followersList: self.followersList)
            return
        }
        isSearching = true
        filteredFollowers = followersList.filter { $0.login.lowercased().contains(filter.lowercased()) } // check the login name if it contain whatever filter is, throw that into filteredFollowers
        updateData(followersList: self.filteredFollowers)
    }
    
    // cancel button click
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(followersList: self.followersList)
    }
    
    // CollectionView followers didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeList = isSearching ? filteredFollowers : followersList
        let selectedFollower = activeList[indexPath.item]
        
        // creating NavigationBar for cancel button
        let userInfoVC = UserInfoViewController()
        userInfoVC.username = selectedFollower.login
        userInfoVC.delegate = self
        let navController = UINavigationController(rootViewController: userInfoVC)
        
        present(navController, animated: true)      // presenting modally because i dont want to add to stack thats why didn't use navigationController
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
                
                if self.followersList.isEmpty {
                    let message = "This user doesn't have any followers. Go Follow Them 😄"
                    DispatchQueue.main.async { self.showEmptyStateView(message: message, view: self.view) } // using .view thats should be in main thread
                    return
                }
                
                self.updateData(followersList: self.followersList)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", bodyTitle: error.rawValue, buttonTitle: Theme.AppTitle.alertButtonTitle.rawValue)
                // Go back to searchVC if username doesn't exist
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}

//MARK: - Refresh Screen with new username come from UserInfoVC didTapGetFollowers
extension FollowersListViewController: FollowerListVCDelegate {
    func didRequestFollowers(username: String) {
        self.username = username
        self.title = username
        self.page = 1
        followersList.removeAll()
        filteredFollowers.removeAll()
        // scroll of the top when new user send to FollowersListVC
        // collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
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
    
    func updateData(followersList: [Followers]){
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
 
