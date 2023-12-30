//
//  FollowerCell.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

class FollowerCell: UICollectionViewCell {
  
  static let reuseIdentifier = "FollowerCell"
  
  private var imageView = GFAvatarImageView()
  
  private let userName = GFTitleLabel(.center, fontSize: 16)
}
