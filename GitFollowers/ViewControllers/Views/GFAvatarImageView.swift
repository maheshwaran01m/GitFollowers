//
//  GFAvatarImageView.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

class GFAvatarImageView: UIImageView {
  
  let placeholderImage = UIImage(named: "avatar-placeholder")
  
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
  }
  
  private func setup() {
    layer.cornerRadius = 16
    clipsToBounds = true
    image = placeholderImage
    translatesAutoresizingMaskIntoConstraints = false
  }
}
