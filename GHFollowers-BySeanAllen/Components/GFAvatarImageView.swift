//
//  GFAvatarImageView.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 5.02.2024.
//

import UIKit

class GFAvatarImageView: UIImageView {
    //MARK: - Properties
    private let placeholderImage = UIImage(named: "avatar-placeholder")!
    
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
}

//MARK: - Fetch Image Data
extension GFAvatarImageView {
    func downloadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
