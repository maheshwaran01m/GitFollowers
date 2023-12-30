//
//  FollowerListVC.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

class FollowerListVC: UIViewController {
  
  private let userName: String
  
  init(_ userName: String) {
    self.userName = userName
    super.init(nibName: nil, bundle: nil)
    self.title = userName
  }
  
  required init?(coder: NSCoder) {
    userName = ""
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    view.backgroundColor = .systemBackground
    navigationController?.isNavigationBarHidden = false
    navigationController?.navigationBar.prefersLargeTitles = true
  }
}
