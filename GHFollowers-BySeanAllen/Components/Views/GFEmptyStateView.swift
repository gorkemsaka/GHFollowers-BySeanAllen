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
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    //MARK: - Functions
    private func configure(){
        addSubview(messageLabel)
        addSubview(emptyImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        emptyImageView.image = Theme.Images.emptyStateLogo
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ?  -80 : -150
        let messageLabelCenterYConstraint = messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant)
        messageLabelCenterYConstraint.isActive = true
        
        let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ?  80 : 40
        let logoImageViewBottomConstraints = emptyImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: logoBottomConstant)
        logoImageViewBottomConstraints.isActive = true
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            // height and width are %30 bigger then the screen width
            emptyImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            // pushing image to the right for good view
            emptyImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200),
        ])
    }
}
