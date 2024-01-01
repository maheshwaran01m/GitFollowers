//
//  ProfileVC.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 31/12/23.
//

import UIKit

class ProfileVC: UIViewController {
  
  private let headerView = UIView()
  private let itemViewOne = UIView()
  private let itemViewTwo = UIView()
  private let dateLabel = GFBodyLabel(.center)
  
  private var itemViews = [UIView]()
  
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
    navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .done,
                                              target: self, action: #selector(dismissVC))
    getUserDetails()
    setupViews()
  }
  
  private func setupViews() {
    itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
    
    for itemView in itemViews {
      view.addSubview(itemView)
      itemView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    headerView.backgroundColor = .systemBackground
    itemViewOne.backgroundColor = .systemBackground
    itemViewTwo.backgroundColor = .systemBackground
    
    let padding: CGFloat = 20
    let itemHeight: CGFloat = 140
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
      headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 180),
      
      itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
      itemViewOne.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
      itemViewOne.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
      itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
      
      itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
      itemViewTwo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
      itemViewTwo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
      itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
      
      dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
      dateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
      dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
      dateLabel.heightAnchor.constraint(equalToConstant: 18),
    ])
  }
  
  private func add(_ vc: UIViewController, to container: UIView) {
    addChild(vc)
    container.addSubview(vc.view)
    vc.view.frame = container.bounds
    vc.didMove(toParent: self)
  }
  
  @objc private func dismissVC() {
    dismiss(animated: true)
  }
}

extension ProfileVC {
  
  private func getUserDetails() {
    APIManager.shared.getUserDetails(user.id) { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let user):
        DispatchQueue.main.async {
          self.add(GFProfileHeaderVC(user), to: self.headerView)
          self.add(GFRepoItemVC(user), to: self.itemViewOne)
          self.add(GFFollowerItemVC(user), to: self.itemViewTwo)
          self.dateLabel.text = "GitHub since " + user.createdAt.convertToDisplayFormat
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
