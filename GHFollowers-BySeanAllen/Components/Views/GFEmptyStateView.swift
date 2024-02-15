//
//  GFEmptyStateView.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 15.02.2024.
//

import UIKit

class GFEmptyStateView: UIView {
    //MARK: - UI Elements
    let messageLabel: GFTitleLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let emptyImageView: UIImageView = UIImageView()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    //MARK: - Functions
    private func configure(){
        addSubview(messageLabel)
        addSubview(emptyImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        emptyImageView.image = UIImage(named: "empty-state-logo")
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            // height and width are %30 bigger then the screen width
            emptyImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            // pushing image to the right for good view
            emptyImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200),
            emptyImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 40)
        ])
    }
}
