//
//  FavoritesListVC.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

class FavoritesListVC: UIViewController {
  
  private let tableView = UITableView()
  
  private var favorites = [Follower]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getFavorites()
  }
  
  private func setupView() {
    view.backgroundColor = .systemBackground
    title = "Favorites"
    navigationController?.navigationBar.prefersLargeTitles = true
    setupTableView()
  }
}


extension FavoritesListVC {
  
  private func getFavorites() {
    PersistenceManager.getFavorites { [weak self] result in
      switch result {
      case .success(let favorites):
        DispatchQueue.main.async {
          self?.updateFavorites(favorites)
        }
      case .failure(let error):
        self?.presentGFAlert(.init("Something went wrong", message: error.localizedDescription))
      }
    }
  }
  
  private func updateFavorites(_ favorites: [Follower]) {
    if favorites.isEmpty {
      showEmptyView("No Favorites \n Add one on the follower screens")
    } else {
      self.favorites = favorites
    }
    tableView.reloadData()
    view.bringSubviewToFront(tableView)
  }
}
// MARK: - TableView

extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
  
  private func setupTableView() {
    view.addSubview(tableView)
    tableView.frame = view.bounds
    tableView.rowHeight = 80
    tableView.tableFooterView = UIView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseIdentifier)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    favorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: FavoritesCell.reuseIdentifier, for: indexPath) as? FavoritesCell else {
      return .init()
    }
    cell.configure(favorites[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let profileVC = FollowerListVC(favorites[indexPath.row].id)
    navigationController?.pushViewController(profileVC, animated: true)
  }
}
