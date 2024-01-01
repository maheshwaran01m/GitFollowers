//
//  FollowerListViewModel.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

protocol FollowerProtocol: AnyObject {
  func showLoaderView(_ show: Bool)
  func updateUI(_ showPlaceholder: Bool,  followers: [Follower])
}

class FollowerListViewModel {
  
  var userName: String
  var followers: [Follower] = []
  
  var filteredFollowers: [Follower] = []
  
  private var page = 1
  private var hasMoreFollowers = true
  private var isSearching = false
  
  weak var alertDelegate: AlertProtocol?
  weak var delegate: FollowerProtocol?
  
  let manager = APIManager.shared
  
  init(_ userName: String) {
    self.userName = userName
    getFollowers(for: userName, page: page)
  }
  
  func getFollowers(for userName: String, page: Int) {
    delegate?.showLoaderView(true)
    manager.getFollowers(userName, page: page) { [weak self] result in
      guard let self else { return }
      delegate?.showLoaderView(false)
      switch result {
      case .success(let followers):
        self.add(followers)
        
      case .failure(let error):
        self.alertDelegate?.showAlert(.init("Bad Error", message: error.localizedDescription))
        print(error.localizedDescription)
      }
    }
  }
  
  private func add(_ followers: [Follower]) {
    DispatchQueue.main.async { [weak self] in
      guard let self else { return }
      
      self.hasMoreFollowers = !(followers.count < 100)
      self.followers.append(contentsOf: followers)
      self.delegate?.updateUI(followers.isEmpty, followers: followers)
    }
  }
  
  func updateFollowers(_ scrollView: UIScrollView) {
    guard hasMoreFollowers else { return }
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.size.height
    
    guard offsetY > contentHeight - height else { return }
    page += 1
    getFollowers(for: userName, page: page)
  }
}

extension FollowerListViewModel {
  
  func updateSearchResult(_ searchText: String? = nil) {
    guard let searchText, !searchText.isEmpty else {
      delegate?.updateUI(false, followers: followers)
      isSearching = false
      return
    }
    filteredFollowers = followers.filter {
      $0.id.lowercased().contains(searchText.lowercased())
    }
    isSearching = true
    delegate?.updateUI(false, followers: filteredFollowers)
  }
}

extension FollowerListViewModel {
  
  func getFollower(_ row: Int) -> Follower {
    isSearching ? filteredFollowers[row] : followers[row]
  }
}

extension FollowerListViewModel {
  
  func resetFollowers(_ username: String) {
    userName = username
    followers = []
    filteredFollowers = []
    page = 1
    getFollowers(for: username, page: page)
  }
}

extension FollowerListViewModel {
  
  func addToFavorites(_ completion: @escaping (AlertItem?) -> Void) {
    
    APIManager.shared.getUserDetails(userName) { [weak self] result in
      guard let self else { return }
      delegate?.showLoaderView(false)
      
      switch result {
      case .success(let user):
        let favorite = Follower(id: user.id, url: user.url)
        PersistenceManager.updateWith(favorite, actionType: .add) { error in
          
          if let error {
            completion(.init("Something went wrong",
                             message: error.localizedDescription))
          } else {
            completion(.init("Success", message: "you have successfully add to favorites"))
          }
        }
      case .failure(let error):
        completion(.init("Something went wrong",
                         message: error.localizedDescription))
      }
    }
  }
}
