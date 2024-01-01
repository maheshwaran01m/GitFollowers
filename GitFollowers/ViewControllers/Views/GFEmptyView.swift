//
//  GFEmptyView.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 31/12/23.
//

import UIKit

class GFEmptyView: UIView {
  
  private let messageLabel = GFTitleLabel(.center, fontSize: 28)
  private let imageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  init(_ message: String) {
    messageLabel.text = message
    super.init(frame: .zero)
    setup()
  }
  
  private func setup() {
    addSubview(messageLabel)
    addSubview(imageView)
    
    messageLabel.numberOfLines = 3
    messageLabel.textColor = .secondaryLabel
    imageView.image = .init(named: "empty-state-logo")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
      messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
      messageLabel.heightAnchor.constraint(equalToConstant: 150),
      
      imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
      imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 80),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40),
    ])
  }
}
