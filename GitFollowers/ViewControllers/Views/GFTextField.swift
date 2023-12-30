//
//  GFTextField.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

class GFTextField: UITextField {
  
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
    translatesAutoresizingMaskIntoConstraints = false
    layer.cornerRadius = 10
    layer.borderWidth = 2
    layer.borderColor = UIColor.systemGray4.cgColor
    
    textColor = .label
    tintColor = .label
    textAlignment = .center
    font = .preferredFont(forTextStyle: .title2)
    adjustsFontSizeToFitWidth = true
    minimumFontSize = 12
    
    backgroundColor = .tertiarySystemBackground
    autocorrectionType = .no
    
    placeholder = "Enter a username"
    returnKeyType = .go
  }
}
