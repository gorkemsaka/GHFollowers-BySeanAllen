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
    
    //MARK: - Functions
    private func configure(){
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        // new navigationTitle style
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
