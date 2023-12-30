//
//  GFButton.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

class GFButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  init(_ title: String, backgroundColor: UIColor) {
    super.init(frame: .zero)
    self.backgroundColor = backgroundColor
    setTitle(title, for: .normal)
    setup()
  }
  
  private func setup() {
    layer.cornerRadius = 10
    setTitleColor(.label, for: .normal)
    titleLabel?.font = .preferredFont(forTextStyle: .headline)
    translatesAutoresizingMaskIntoConstraints = false
  }
}
