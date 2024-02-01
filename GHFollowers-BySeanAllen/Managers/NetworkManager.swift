//
//  NetworkManager.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 1.02.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    
    private init(){}
    
    func getFollowers(username: String, page: Int, completed: @escaping ([Followers]?, Theme.ErrorMessages?) -> Void){
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(nil, .urlErrorTitle)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let _ = error {
                completed(nil, .requestErrorTitle)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .responseErrorTtitle)
                return
            }
            
            guard let data = data else {
                completed(nil, .dataErrorTitle)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Followers].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, .dataErrorTitle)
            }
        }
        task.resume()
    }
}
