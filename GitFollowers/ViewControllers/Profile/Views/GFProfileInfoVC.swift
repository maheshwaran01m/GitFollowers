//
//  GFProfileInfoVC.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 31/12/23.
//

import UIKit

class GFProfileInfoVC: UIViewController {
  
  private let stackView = UIStackView()
  let itemInfoViewOne = GFItemInfoView()
  let itemInfoViewTwo = GFItemInfoView()
  let actionButton = GFButton()
  
  var user: User
  
  weak var delegate: ProfileDelegate?
  
  init(_ user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    user = .init(id: "", url: "", repo: 0, gists: 0,
                 htmlUrl: "", following: 0, followers: 0, createdAt: "")
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    view.layer.cornerRadius = 18
    view.backgroundColor = .secondarySystemBackground
    
    view.addSubview(stackView)
    view.addSubview(actionButton)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    let padding: CGFloat = 20
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      stackView.heightAnchor.constraint(equalToConstant: 50),
      
      actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
      actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      actionButton.heightAnchor.constraint(equalToConstant: 44)
    ])
    
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.addArrangedSubview(itemInfoViewOne)
    stackView.addArrangedSubview(itemInfoViewTwo)
    
    setupButtonAction()
  }
  
  private func setupButtonAction() {
    actionButton.addTarget(self, action: #selector(didTapButtonAction), for: .touchUpInside)
  }
  
  @objc func didTapButtonAction() {}
}
