//
//  FollowerListVC.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

class FollowerListVC: UIViewController {
  
  private var viewModel: FollowerListViewModel
  
  init(_ userName: String) {
    viewModel = .init(userName)
    super.init(nibName: nil, bundle: nil)
    self.title = userName
    viewModel.alertDelegate = self
  }
  
  required init?(coder: NSCoder) {
    viewModel = .init("")
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  private func setup() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
  }
}

extension FollowerListVC: AlertProtocol {
  
  func showAlert(_ alertItem: AlertItem) {
    presentGFAlert(alertItem)
  }
}
