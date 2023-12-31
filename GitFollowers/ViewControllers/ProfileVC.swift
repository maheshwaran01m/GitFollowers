//
//  ProfileVC.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 31/12/23.
//

import UIKit

class ProfileVC: UIViewController {
  
  private let user: Follower
  
  init(using user: Follower) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    user = .init(id: "", url: "")
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    view.backgroundColor = .systemBackground
    navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
  }
  
  @objc private func dismissVC() {
    dismiss(animated: true)
  }
}
