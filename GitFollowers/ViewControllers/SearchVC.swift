//
//  SearchVC.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

class SearchVC: UIViewController {
  
  private lazy var imageView: UIImageView = {
    let image = UIImageView()
    image.image = .init(named: "gh-logo")
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  private let userNameTextField = GFTextField()
  private let getFollowersButton = GFButton("Get Followers", backgroundColor: .systemGreen)

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  private func setupView() {
    view.backgroundColor = .systemBackground
    view.addSubview(imageView)
    view.addSubview(userNameTextField)
    view.addSubview(getFollowersButton)
    userNameTextField.delegate = self
    setupConstraint()
    setupButtonAction()
    dismissKeyboard()
  }
  
  private func setupConstraint() {
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView.heightAnchor.constraint(equalToConstant: 350),
      imageView.widthAnchor.constraint(equalToConstant: 350),
      
      userNameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
      userNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
      userNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
      userNameTextField.heightAnchor.constraint(equalToConstant: 50),
      
      //getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
      getFollowersButton.topAnchor.constraint(greaterThanOrEqualTo: userNameTextField.bottomAnchor, constant: 50),
      getFollowersButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
      getFollowersButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
      getFollowersButton.heightAnchor.constraint(equalToConstant: 50),
    ])
  }
  
  private func setupButtonAction() {
    getFollowersButton.addTarget(self, action: #selector(showFollowerListVC), for: .touchUpInside)
  }
  
  private func dismissKeyboard() {
    let gesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
    view.addGestureRecognizer(gesture)
  }
}

// MARK: - UITextFieldDelegate

extension SearchVC: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    showFollowerListVC()
    return true
  }
}

// MARK: - FollwerListVC

extension SearchVC {
  
  @objc private func showFollowerListVC() {
    guard let text = userNameTextField.text, !text.isEmpty else {
      presentGFAlert(.init("Empty User name", message: "Please Enter the user name"))
      return
    }
    userNameTextField.text = ""
    let vc = FollowerListVC(text)
    navigationController?.pushViewController(vc, animated: true)
  }
}
