//
//  NetworkManager.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 1.02.2024.
//

import UIKit

class NetworkManager {
    //MARK: - Properties
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    // cache for already downloaded images
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()

    private init(){
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
//    Old way with closures
//    func fetchFollowers(username: String, page: Int, completed: @escaping (Result<[Followers], Theme.GFError>) -> Void){
//        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
//
//        guard let url = URL(string: endPoint) else {
//            completed(.failure(.urlErrorTitle))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url){ data, response, error in
//            if let _ = error {
//                completed(.failure(.requestErrorTitle))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.responseErrorTtitle))
//                return
//            }
//
//            guard let data = data else {
//                completed(.failure(.dataErrorTitle))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let followers = try decoder.decode([Followers].self, from: data)
//                completed(.success(followers))
//            } catch {
//                completed(.failure(.dataErrorTitle))
//            }
//        }
//        task.resume()
//    }
    
    func fetchFollowers(username: String, page: Int) async throws -> [Followers] {
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            throw Theme.GFError.urlErrorTitle
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw Theme.GFError.responseErrorTtitle
        }
        do {
            let followers = try decoder.decode([Followers].self, from: data)
            return followers
        } catch {
            throw Theme.GFError.dataErrorTitle
        }
    }
    
    
    func fetchUser(username: String) async throws -> User {
        let endPoint = baseURL + "\(username)"
        
        guard let url = URL(string: endPoint) else {
            throw Theme.GFError.urlErrorTitle
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw Theme.GFError.responseErrorTtitle
        }
        do {
            let user = try decoder.decode(User.self, from: data)
            return user
        } catch {
            throw Theme.GFError.dataErrorTitle
        }
    }
    
    func downloadImage(urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        // if the image was cached, don't keep going for download just return.
        if let image = cache.object(forKey: cacheKey) { return image }
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let image = UIImage(data: data) else { return nil }
            self.cache.setObject(image, forKey: cacheKey)
            return image
            
        } catch  {
            return nil
        }
    }
}

