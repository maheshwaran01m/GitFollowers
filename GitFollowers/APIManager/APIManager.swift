//
//  APIManager.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import Foundation
import UIKit

final class APIManager {
  
  static let shared = APIManager()
  
  private init() {}
  
  private let cache = NSCache<NSString, UIImage>()
  
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
  
  func getUserDetails(_ userName: String, completion: @escaping (Result<User, Error>) -> Void) {
    
    guard let url = URL(string: baseURL + "/users/\(userName)") else {
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
        let user = try JSONDecoder().decode(User.self, from: data)
        completion(.success(user))
        
      } catch {
        completion(.failure(URLError(.cannotParseResponse)))
      }
    }.resume()
  }
}

// MARK: - Image Cache

extension APIManager {
  
  func downloadImage(_ urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
    
    let cacheKey = NSString(string: urlString)
    
    if let image = cache.object(forKey: cacheKey) {
      completion(.success(image))
    } else {
      
      guard let url = URL(string: urlString) else { return }
      
      URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
        guard let self, error == nil else {
          completion(.failure(URLError(.badServerResponse)))
          return
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
          completion(.failure(URLError(.badServerResponse)))
          return
        }
        guard let data, let image = UIImage(data: data) else {
          completion(.failure(URLError(.dataNotAllowed)))
          return
        }
        // cache image
        cache.setObject(image, forKey: cacheKey)
        
        completion(.success(image))
      }.resume()
    }
  }
  
  func clearImageCache() {
    cache.removeAllObjects()
  }
  
  func clearImageCache(forKey key: String) {
    let cacheKey = NSString(string: key)
    cache.removeObject(forKey: cacheKey)
  }
}
