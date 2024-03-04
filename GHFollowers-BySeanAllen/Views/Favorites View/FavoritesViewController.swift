//
//  FavoritesViewController.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 30.01.2024.
//

import UIKit

class FavoritesViewController: UIViewController {
    //MARK: - UI Elements
    let tableView = UITableView()
    
    //MARK: - Properties
    var favorites: [Followers] = []
    
    //MARK: - Life Cycyle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // viewDidLoad is running once, but favorites can change meanwhile app working. Everytime that vc shows up, viewWillAppear will run. Thats why getFavorites in there
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    //MARK: - Functions
    private func configure(){
        configureViewController()
        configureTableView()
    }
}

//MARK: - Configure View Controller Setup
extension FavoritesViewController {
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: - Get Favorites data from PersistenceManager
extension FavoritesViewController {
    private func getFavorites(){
        view.backgroundColor = .systemBackground
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                
                if favorites.isEmpty {
                    showEmptyStateView(message: "No Favorites?\nAdd one on the follower screen", view: self.view)
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", bodyTitle: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

//MARK: - Configure TableView
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    private func configureTableView(){
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: Theme.Identifier.favoritesCellID.rawValue)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Theme.Identifier.favoritesCellID.rawValue) as! FavoritesTableViewCell
        let favorite = favorites[indexPath.row]
        cell.getData(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowersListViewController(username: favorite.login)
        destVC.username = favorite.login
        destVC.title = favorite.login
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    // for delete action
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
       
        PersistenceManager.updateFavorites(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentGFAlertOnMainThread(title: "Unable to remove", bodyTitle: error.rawValue, buttonTitle: "Ok")
        }
    }
}


