//
//  FollowersCollectionViewCell.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 2.02.2024.
//

import UIKit

class FollowersCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    // adjusting via constraint. Thats why frame is zero
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    //MARK: - Functions
    private func configure(){
        configureAvatarImageView()
        configureUsernameLabel()
    }
}

//MARK: - Get UI Elements Data
extension FollowersCollectionViewCell {
    func getData(model: Followers) {
        usernameLabel.text = model.login
        avatarImageView.downloadImage(urlString: model.avatarUrl)
    }
}

//MARK: - Configure UI Elements
extension FollowersCollectionViewCell {
    private func configureAvatarImageView(){
        addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            //square shape
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
    }
    private func configureUsernameLabel(){
        addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
