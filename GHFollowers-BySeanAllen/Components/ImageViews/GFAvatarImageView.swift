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
}

//MARK: - Fetch Image Data
extension GFAvatarImageView {
    func downloadImage(urlString: String) {
        let cacheKey = NSString(string: urlString)
        // if the image was cached, don't keep going for download just return.
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            // after download image, add image to cache
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
