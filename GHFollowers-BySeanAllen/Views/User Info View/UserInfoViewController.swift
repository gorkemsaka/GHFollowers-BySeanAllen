//
//  UserInfoViewController.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 16.02.2024.
//

import UIKit

class UserInfoViewController: UIViewController {

    //MARK: - UI Elements
    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    
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
        configureConstraints()
        getData()
    }
}

//MARK: - Network Call
extension UserInfoViewController {
    private func getData(){
        NetworkManager.shared.fetchUser(username: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user) :
                DispatchQueue.main.async {
                    self.addVCToContainer(childVC: GFUserInfoHeaderViewController(user: user), containerView: self.headerView)
                    self.addVCToContainer(childVC: GFRepoItemVC(user: user), containerView: self.itemView1)
                    self.addVCToContainer(childVC: GFFollowerItemVC(user: user), containerView: self.itemView2)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", bodyTitle: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

//MARK: - Configure VC Containers
extension UserInfoViewController {
    private func configureConstraints(){
        view.addSubview(headerView)
        view.addSubview(itemView1)
        view.addSubview(itemView2)
        
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemView1.translatesAutoresizingMaskIntoConstraints = false
        itemView2.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemView1.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: padding),
            itemView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemView2.heightAnchor.constraint(equalToConstant: itemHeight),
        ])
    }
    
    private func addVCToContainer(childVC: UIViewController, containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
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
