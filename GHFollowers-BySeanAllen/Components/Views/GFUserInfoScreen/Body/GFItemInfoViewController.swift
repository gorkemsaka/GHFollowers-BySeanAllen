//
//  GFItemInfoViewController.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 20.02.2024.
//

import UIKit

protocol ItemInfoVCDelegate: AnyObject {
    func didTapGithubProfile(user: User)
    func didTapGetFollowers(user: User)
}

class GFItemInfoViewController: UIViewController {
    //MARK: - UI Elements
    let stackView = UIStackView()
    let itemInfoView1 = GFItemInfoView()
    let itemInfoView2 = GFItemInfoView()
    let actionButton = GFButton()
    
    //MARK: - Properties
    var user: User!
    weak var delegate: ItemInfoVCDelegate!
    
    //MARK: - Life Cycyle
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Functions
    private func configure(){
        configureBackground()
        configureUIElements()
        configureStackView()
        configureActionButton()
    }
}

//MARK: - Configure Action Button
extension GFItemInfoViewController {
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
   @objc  func actionButtonTapped(){
       // there is no action, because subclasses will override this func and they will customize it
   }
}

//MARK: - Configure Stack View
extension GFItemInfoViewController {
    private func configureStackView(){
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoView1)
        stackView.addArrangedSubview(itemInfoView2)
    }
}

//MARK: - Configure Background of Screen & Constraints
extension GFItemInfoViewController {
    private func configureBackground(){
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureUIElements(){
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
