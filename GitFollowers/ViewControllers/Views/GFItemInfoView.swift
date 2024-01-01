//
//  GFItemInfoView.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 31/12/23.
//

import UIKit

class GFItemInfoView: UIView {
  
  private let imageView = UIImageView()
  private let titleLabel = GFTitleLabel(.left, fontSize: 14)
  private let countLabel = GFTitleLabel(.center, fontSize: 14)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  private func setup() {
    addSubview(imageView)
    addSubview(titleLabel)
    addSubview(countLabel)
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.tintColor = .label
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 20),
      imageView.heightAnchor.constraint(equalToConstant: 20),
      
      titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: 18),
      
      countLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
      countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      countLabel.heightAnchor.constraint(equalToConstant: 18)
    ])
  }
  
  func configure(_ type: ItemInfoType, with count: Int) {
    switch type {
    case .repos:
      imageView.image = .init(systemName: Symbols.repos)
      titleLabel.text = "Public Repos"
    case .gists:
      imageView.image = .init(systemName: Symbols.gists)
      titleLabel.text = "Public Gists"
    case .followers:
      imageView.image = .init(systemName: Symbols.followers)
      titleLabel.text = "Followers"
    case .following:
      imageView.image = .init(systemName: Symbols.following)
      titleLabel.text = "Following"
    }
    countLabel.text = count.description
  }
}

enum ItemInfoType {
  case repos, gists, followers, following
}
