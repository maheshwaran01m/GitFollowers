//
//  GFAlertVC.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

class GFAlertVC: UIViewController {
  
  private let containerView = UIView()
  private let titleLabel = GFTitleLabel(.center, fontSize: 20)
  private let messageLabel = GFBodyLabel(.center)
  private let actionButton = GFButton("Ok", backgroundColor: .systemPink)
  
  private var alertItem: AlertItem?
  
  private let padding: CGFloat = 20
  
  init(_ alertItem: AlertItem? = nil) {
    self.alertItem = alertItem
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.75)
    view.addSubview(containerView)
    containerView.layer.cornerRadius = 16
    containerView.layer.borderWidth = 2
    containerView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.backgroundColor = .systemBackground
    
    containerView.addSubview(titleLabel)
    titleLabel.text = alertItem?.title ?? "Something went wrong"
    
    containerView.addSubview(messageLabel)
    messageLabel.text = alertItem?.message ?? "Unable to proceed"
    messageLabel.numberOfLines = 4
    
    containerView.addSubview(actionButton)
    actionButton.setTitle(alertItem?.buttonTitle ?? "Ok", for: .normal)
    actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      containerView.widthAnchor.constraint(equalToConstant: 280),
      containerView.heightAnchor.constraint(equalToConstant: 220),
      
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
      titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding),
      titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -padding),
      titleLabel.heightAnchor.constraint(equalToConstant: 28),
      
      actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
      actionButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding),
      actionButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -padding),
      actionButton.heightAnchor.constraint(equalToConstant: 44),
      
      messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      messageLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding),
      messageLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -padding),
      messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12),
    ])
  }
  
  @objc private func dismissVC() {
    dismiss(animated: true, completion: alertItem?.dismissAction)
  }
}

struct AlertItem {
  var title: String?
  var message: String?
  var buttonTitle: String? = nil
  var dismissAction: (() -> Void)? = nil
  
  init(_ title: String?,
       message: String?,
       buttonTitle: String? = nil,
       dismissAction: (() -> Void)? = nil) {
    self.title = title
    self.message = message
    self.buttonTitle = buttonTitle
    self.dismissAction = dismissAction
  }
}

protocol AlertProtocol: AnyObject {
  
  func showAlert(_ alertItem: AlertItem)
}
