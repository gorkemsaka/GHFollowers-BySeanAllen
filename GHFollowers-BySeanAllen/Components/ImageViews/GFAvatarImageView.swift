//
//  GFAvatarImageView.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 5.02.2024.
//

import UIKit

class GFAvatarImageView: UIImageView {
    //MARK: - Properties
    private let placeholderImage = Theme.Images.placeholder
    let cache = NetworkManager.shared.cache
    
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
        layer.cornerRadius = Theme.Size.cornerRadius.rawValue
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(url: String){
        NetworkManager.shared.downloadImage(urlString: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
}

