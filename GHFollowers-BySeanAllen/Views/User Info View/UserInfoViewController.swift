//
//  UserInfoViewController.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 16.02.2024.
//

import UIKit

class UserInfoViewController: UIViewController {

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
        configureBarbuttonItem()
    }
}

//MARK: - Configure Navigation Bar and Dismiss UserInfo
extension UserInfoViewController {
    private func configureBarbuttonItem(){
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}
