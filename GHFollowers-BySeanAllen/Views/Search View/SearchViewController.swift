//
//  SearchViewController.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 30.01.2024.
//

import UIKit

class SearchViewController: UIViewController {
    //MARK: - UI Elements
    let logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "gh-logo")
        return image
    }()
    let userNameTextField = GFTextField()
    let actionButton = GFButton(backgroundColor: .systemGreen, title: Theme.AppTitle.getFollowersButton.rawValue)
    
    //MARK: - Properties
    // text validation for using userName
    var isUsernameEntered: Bool { return !userNameTextField.text!.isEmpty}
    
    //MARK: - Life Cycyle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    // Everytime the view appear, this func will work
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - Functions
    private func configure(){
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureUserNameTextfield()
        configureGetFollowersButton()
        createDismissKeyboardTapGesture()
    }
    
    private func createDismissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: view.self, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}

//MARK: - PushView Action
extension SearchViewController {
    @objc func pushFollowersListVC(){
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: Theme.GFError.alertTitle.rawValue, bodyTitle: Theme.GFError.alertBodyTitle.rawValue, buttonTitle: Theme.AppTitle.alertButtonTitle.rawValue)
            return
        }
        let followersListVC = FollowersListViewController()
        followersListVC.username = userNameTextField.text
        followersListVC.title = followersListVC.username
        navigationController?.pushViewController(followersListVC, animated: true)
    }
}
 
//MARK: - Textfield Delegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
}


//MARK: - Configure UI Elements
extension SearchViewController {
    private func configureLogoImageView(){
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    private func configureUserNameTextfield(){
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func configureGetFollowersButton(){
        view.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

