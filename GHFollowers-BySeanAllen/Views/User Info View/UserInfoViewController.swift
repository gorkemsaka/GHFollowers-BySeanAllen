//
//  UserInfoViewController.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 16.02.2024.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGithubProfile(user: User)
    func didTapGetFollowers(user: User)
}
class UserInfoViewController: UIViewController {
    //MARK: - UI Elements
    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    //MARK: - Properties
    var username: String!
    weak var delegate: FollowerListVCDelegate!
    
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


//MARK: - Network Call
extension UserInfoViewController {
    private func getData(){
        NetworkManager.shared.fetchUser(username: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user) :
                DispatchQueue.main.async { self.configureUIElements(user: user) }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", bodyTitle: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureUIElements(user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.addVCToContainer(childVC: GFUserInfoHeaderViewController(user: user), containerView: self.headerView)
        self.addVCToContainer(childVC: repoItemVC, containerView: self.itemView1)
        self.addVCToContainer(childVC: followerItemVC, containerView: self.itemView2)
        self.dateLabel.text = "Github user since \(user.createdAt.convertToDisplayFormat())"
    }
}

//MARK: - Button Tapping
extension UserInfoViewController: UserInfoVCDelegate {
    func didTapGithubProfile(user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", bodyTitle: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(url: url)
    }
    
    func didTapGetFollowers(user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", bodyTitle: "This user has no followers", buttonTitle: "So Sad")
            return
        }
        delegate.didRequestFollowers(username: user.login)
        dismissVC()
    }
}

//MARK: - Configure VC Containers
extension UserInfoViewController {
    private func configureConstraints(){
        view.addSubview(headerView)
        view.addSubview(itemView1)
        view.addSubview(itemView2)
        view.addSubview(dateLabel)
        
        
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
            
            dateLabel.topAnchor.constraint(equalTo: itemView2.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func addVCToContainer(childVC: UIViewController, containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

