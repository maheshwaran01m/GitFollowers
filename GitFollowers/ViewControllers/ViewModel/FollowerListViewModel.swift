//
//  FollowerListViewModel.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

class FollowerListViewModel {
  
  var userName: String
  var followers: [Follower] = []
  
  weak var alertDelegate: AlertProtocol?
  
  let manager = APIManager.shared
  
  init(_ userName: String) {
    self.userName = userName
    getFollowers(for: userName)
  }
  
  func getFollowers(for userName: String) {
    manager.getFollowers(userName, page: 1) { [weak self] result in
      guard let self else { return }
      
      switch result {
      case .success(let followers):
        DispatchQueue.main.async {
          self.followers = followers
        }
      case .failure(let error):
        self.alertDelegate?.showAlert(.init("Bad Error", message: error.localizedDescription))
        print(error.localizedDescription)
      }
    }
  }
}
