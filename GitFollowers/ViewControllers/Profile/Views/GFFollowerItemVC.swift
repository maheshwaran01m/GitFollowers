//
//  GFFollowerItemVC.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 31/12/23.
//

import UIKit

class GFFollowerItemVC: GFProfileInfoVC {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    itemInfoViewOne.configure(.followers, with: user.followers)
    itemInfoViewTwo.configure(.following, with: user.following)
    
    actionButton.set("Git Followers", backgroundColor: .systemGreen)
  }
}
