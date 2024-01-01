//
//  PersistenceManager.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 01/01/24.
//

import Foundation

enum PersistenceManager {
  
  enum Keys {
    static let favorites = "favorites"
  }
  
  enum ActionType {
    case add, remove
  }
  
  static private let manager = UserDefaults.standard
  
  static func getFavorites(_ completion: @escaping (Result<[Follower], Error>) -> Void) {
    guard let data = manager.object(forKey: Keys.favorites) as? Data else {
      completion(.success([]))
      return
    }
    do {
      let favorites = try JSONDecoder().decode([Follower].self, from: data)
      completion(.success(favorites))
      
    } catch {
      completion(.failure(URLError(.cannotParseResponse)))
    }
  }
  
  static func saveFavorites(_ favorites: [Follower]) -> Error? {
    do {
      let favorites = try JSONEncoder().encode(favorites)
      manager.set(favorites, forKey: Keys.favorites)
      
      return nil
    } catch {
      return URLError(.dataLengthExceedsMaximum)
    }
  }
  
  static func updateWith(_ favorite: Follower, actionType: ActionType,
                         completion: @escaping (Error?) -> Void) {
    getFavorites { result in
      switch result {
      case .success(let favorites):
        var favorites = favorites
        
        switch actionType {
        case .add:
          guard !favorites.contains(favorite) else {
            completion(URLError(.cannotWriteToFile))
            return
          }
          favorites.append(favorite)
          
        case .remove:
          favorites.removeAll(where: { $0.id == favorite.id })
        }
        completion(saveFavorites(favorites))
        
      case .failure(let error):
        completion(error)
      }
    }
  }
}
