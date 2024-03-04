//
//  NetworkManager.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 1.02.2024.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    // cache for already downloaded images
    let cache = NSCache<NSString, UIImage>()
    
    private init(){}
    
    func fetchFollowers(username: String, page: Int, completed: @escaping (Result<[Followers], Theme.GFError>) -> Void){
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.urlErrorTitle))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let _ = error {
                completed(.failure(.requestErrorTitle))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.responseErrorTtitle))
                return
            }
            
            guard let data = data else {
                completed(.failure(.dataErrorTitle))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Followers].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.dataErrorTitle))
            }
        }
        task.resume()
    }
    
    
    func fetchUser(username: String, completed: @escaping (Result<User, Theme.GFError>) -> Void){
        let endPoint = baseURL + "\(username)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.urlErrorTitle))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let _ = error {
                completed(.failure(.requestErrorTitle))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.responseErrorTtitle))
                return
            }
            
            guard let data = data else {
                completed(.failure(.dataErrorTitle))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.dataErrorTitle))
            }
        }
        task.resume()
    }
    
    func downloadImage(urlString: String, completed: @escaping (UIImage?) -> Void){
        let cacheKey = NSString(string: urlString)
        // if the image was cached, don't keep going for download just return.
        if let image = cache.object(forKey: cacheKey) {
           completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            // after download image, add image to cache
            self.cache.setObject(image, forKey: cacheKey)
            
           completed(image)
        }
        task.resume()
    }
}
