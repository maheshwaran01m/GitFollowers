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
      imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
      imageView.widthAnchor.constraint(equalToConstant: 90),
      imageView.heightAnchor.constraint(equalToConstant: 90),
      
      userNameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
      userNameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: textImagePadding),
      userNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
      userNameLabel.heightAnchor.constraint(equalToConstant: 38),
      
      nameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 8),
      nameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: textImagePadding),
      nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
      nameLabel.heightAnchor.constraint(equalToConstant: padding),
      
      locationImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
      locationImageView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: textImagePadding),
      locationImageView.widthAnchor.constraint(equalToConstant: padding),
      locationImageView.heightAnchor.constraint(equalToConstant: padding),
      
      locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
      locationLabel.leftAnchor.constraint(equalTo: locationImageView.rightAnchor, constant: 5),
      locationLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
      locationLabel.heightAnchor.constraint(equalToConstant: padding),
      
      bioLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: textImagePadding),
      bioLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor),
      bioLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
      bioLabel.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
}
