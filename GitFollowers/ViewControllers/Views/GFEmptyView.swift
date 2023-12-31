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
      messageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
      messageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
      messageLabel.heightAnchor.constraint(equalToConstant: 150),
      
      imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
      imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
      imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 80),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40),
    ])
  }
}
