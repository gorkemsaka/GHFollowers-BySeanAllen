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
        NetworkManager.shared.fetchUser(username: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user) :
                print(user)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", bodyTitle: error.rawValue, buttonTitle: "Ok")
            }
            
        }
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
