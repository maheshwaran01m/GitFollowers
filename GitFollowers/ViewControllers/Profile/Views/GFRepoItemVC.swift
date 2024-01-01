//
//  GFRepoItemVC.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 31/12/23.
//

import UIKit

class GFRepoItemVC: GFProfileInfoVC {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    itemInfoViewOne.configure(.repos, with: user.repo)
    itemInfoViewTwo.configure(.gists, with: user.gists)
    
    actionButton.set("GitHub Profile", backgroundColor: .systemPurple)
  }
  
  override func didTapButtonAction() {
    delegate?.didTapGitHubProfile(for: user)
  }
}
