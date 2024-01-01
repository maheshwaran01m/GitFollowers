//
//  FollowerCell.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

class FollowerCell: UICollectionViewCell {
  
  static let reuseIdentifier = "FollowerCell"
  
  private var containerView = UIView()
  
  private var imageView = GFAvatarImageView()
  
  private let userName = GFTitleLabel(.center, fontSize: 16)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  func configure(_ follower: Follower) {
    userName.text = follower.id
    imageView.downloadImage(follower.url)
  }
  
  private func setup() {
    addSubview(containerView)
    containerView.layer.cornerRadius = 16
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.layer.borderWidth = 1
    containerView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
    containerView.backgroundColor = .systemGroupedBackground
    
    containerView.addSubview(imageView)
    containerView.addSubview(userName)
    setupConstraints()
  }
  
  private func setupConstraints() {
    let padding: CGFloat = 8
    
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: topAnchor),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
      imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
      
      userName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
      userName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      userName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      userName.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
}
