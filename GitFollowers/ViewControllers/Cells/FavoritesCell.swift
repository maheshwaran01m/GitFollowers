//
//  FavoritesCell.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 01/01/24.
//

import UIKit

class FavoritesCell: UITableViewCell {
  
  static let reuseIdentifier = "FavoritesCell"
  
  private var avatarImageView = GFAvatarImageView()
  private let userName = GFTitleLabel(.left, fontSize: 26)
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  func configure(_ follower: Follower) {
    userName.text = follower.id
    avatarImageView.downloadImage(follower.url)
  }
  
  private func setup() {
    addSubview(avatarImageView)
    addSubview(userName)
    setupConstraints()
    
    accessoryType = .disclosureIndicator
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      avatarImageView.heightAnchor.constraint(equalToConstant: 60),
      avatarImageView.widthAnchor.constraint(equalToConstant: 60),
      
      userName.centerYAnchor.constraint(equalTo: centerYAnchor),
      userName.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
      userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
      userName.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
}
