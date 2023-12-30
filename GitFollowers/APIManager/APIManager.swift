//
//  APIManager.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import Foundation

final class APIManager {
  
  static let shared = APIManager()
  
  private init() {}
  
  private let baseURL = "https://api.github.com"
  
  
  func getFollowers(_ userName: String, page: Int, maxLimit: Int = 100,
                    completion: @escaping (Result<[Follower], Error>) -> Void) {
    
    guard let url = URL(string: baseURL + "/users/\(userName)/followers?per_page=\(maxLimit)&page=\(page)") else {
      completion(.failure(URLError(.badURL)))
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard error == nil else {
        completion(.failure(URLError(.badServerResponse)))
        return
      }
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completion(.failure(URLError(.secureConnectionFailed)))
        return
      }
      
      guard let data else {
        completion(.failure(URLError(.dataNotAllowed)))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let followers = try decoder.decode([Follower].self, from: data)
        completion(.success(followers))
        
      } catch {
        completion(.failure(URLError(.cannotParseResponse)))
      }
    }.resume()
  }
}
