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
}
