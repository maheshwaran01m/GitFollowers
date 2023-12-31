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
    setup()
  }
  
  private func setup() {
    layer.cornerRadius = 10
    clipsToBounds = true
    image = placeholderImage
    layer.masksToBounds = true
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  func downloadImage(_ urlString: String?) {
    guard let urlString else { return }
    
    APIManager.shared.downloadImage(urlString) { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let image):
        DispatchQueue.main.async {
          self.image = image
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
