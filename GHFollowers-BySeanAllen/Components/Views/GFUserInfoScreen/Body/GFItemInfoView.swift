//
//  GFItemInfoView.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 19.02.2024.
//

import UIKit


enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {
    //MARK: - UI Elements
    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    
    //MARK: - LifeCycyle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func configure(){
        configureElements()
    }
}

//MARK: - Set UIElements by type
extension GFItemInfoView {
    func setElements(itemInfoType: ItemInfoType, count: Int){
        switch itemInfoType {
        case .repos:
            symbolImageView.image = Theme.SFSymbols.repos
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = Theme.SFSymbols.gist
            titleLabel.text = "Public Gist"
        case .followers:
            symbolImageView.image = Theme.SFSymbols.followers
            titleLabel.text = "Public Followers"
        case .following:
            symbolImageView.image = Theme.SFSymbols.following
            titleLabel.text = "Public Following"
        }
        countLabel.text = String(count)
    }
}

//MARK: - Configure UI Elements
extension GFItemInfoView {
    private func configureElements(){
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}
