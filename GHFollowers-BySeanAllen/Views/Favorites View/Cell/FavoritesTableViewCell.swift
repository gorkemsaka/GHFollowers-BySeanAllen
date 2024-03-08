//
//  FavoritesTableViewCell.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 26.02.2024.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    //MARK: - UI Elements
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Theme.Identifier.favoritesCellID.rawValue)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    private func configure(){
        configureUIElements()
    }
}

//MARK: - Get UI Elements Data
extension FavoritesTableViewCell {
    func getData(favorite: Followers) {
        usernameLabel.text = favorite.login
        avatarImageView.downloadImage(url: favorite.avatarUrl)
    }
}

//MARK: - Configure UI Elements
extension FavoritesTableViewCell {
    private func configureUIElements(){
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
