//
//  UIView+Extensions.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 01/01/24.
//

import UIKit

extension UIView {
  
  func addSubviews(_ views: UIView...) {
    for view in views {
      addSubview(view)
    }
  }
  
  func edges(to superView: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor),
      leadingAnchor.constraint(equalTo: superView.leadingAnchor),
      trailingAnchor.constraint(equalTo: superView.trailingAnchor),
      bottomAnchor.constraint(equalTo: superView.bottomAnchor),
    ])
  }
}
