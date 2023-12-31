//
//  FollowerListViewModel.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

protocol FollowerProtocol: AnyObject {
  func updateUI()
}

class FollowerListViewModel {
  
  var userName: String
  var followers: [Follower] = []
  
  private var page = 1
  private var hasMoreFollowers = true
  
  weak var alertDelegate: AlertProtocol?
  weak var delegate: FollowerProtocol?
  
  let manager = APIManager.shared
  
  init(_ userName: String) {
    self.userName = userName
    getFollowers(for: userName, page: page)
  }
  
  func getFollowers(for userName: String, page: Int) {
    manager.getFollowers(userName, page: page) { [weak self] result in
      guard let self else { return }
      
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
      self.delegate?.updateUI()
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

