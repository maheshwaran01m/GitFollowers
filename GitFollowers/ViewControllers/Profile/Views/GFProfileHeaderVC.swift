//
//  GFProfileHeaderVC.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 31/12/23.
//

import UIKit

class GFProfileHeaderVC: UIViewController {
  
  let imageView = GFAvatarImageView()
  let userNameLabel = GFTitleLabel(.left, fontSize: 34)
  let nameLabel = GFSecondaryTitleLabel(18)
  let locationImageView = UIImageView()
  let locationLabel = GFSecondaryTitleLabel(18)
  let bioLabel = GFBodyLabel(.left)
  
  var user: User
  
  init(_ user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    user = .init(id: "", url: "", repo: 0, gists: 0,
                 htmlUrl: "", following: 0, followers: 0, createdAt: "")
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupUserDetails()
  }
  
  private func setupUserDetails() {
    imageView.downloadImage(user.url)
    userNameLabel.text = user.id
    nameLabel.text = user.name ?? ""
    locationLabel.text = user.location ?? "No location"
    bioLabel.text = user.bio ?? "No bio available"
    bioLabel.numberOfLines = 3
    
    locationImageView.image = .init(systemName: Symbols.location)
    locationImageView.tintColor = .secondaryLabel
  }
  
  private func setupViews() {
    view.addSubview(imageView)
    view.addSubview(userNameLabel)
    view.addSubview(nameLabel)
    view.addSubview(locationImageView)
    view.addSubview(locationLabel)
    view.addSubview(bioLabel)
    setupConstraints()
  }
  
  private func setupConstraints() {
    let padding: CGFloat = 20
    let textImagePadding: CGFloat = 12
    
    locationImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      imageView.widthAnchor.constraint(equalToConstant: 90),
      imageView.heightAnchor.constraint(equalToConstant: 90),
      
      userNameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
      userNameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: textImagePadding),
      userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      userNameLabel.heightAnchor.constraint(equalToConstant: 38),
      
      nameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 8),
      nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: textImagePadding),
      nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      nameLabel.heightAnchor.constraint(equalToConstant: padding),
      
      locationImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
      locationImageView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: textImagePadding),
      locationImageView.widthAnchor.constraint(equalToConstant: padding),
      locationImageView.heightAnchor.constraint(equalToConstant: padding),
      
      locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
      locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
      locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      locationLabel.heightAnchor.constraint(equalToConstant: padding),
      
      bioLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: textImagePadding),
      bioLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
      bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      bioLabel.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
}
