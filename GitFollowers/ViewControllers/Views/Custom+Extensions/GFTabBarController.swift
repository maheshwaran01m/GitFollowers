//
//  GFTabBarController.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 01/01/24.
//

import UIKit

class GFTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    viewControllers = [searchVC, favoritesVC]
    configureTintColor()
  }
  
  private var searchVC: UINavigationController {
    let searchVC = SearchVC()
    searchVC.title = "Search"
    searchVC.tabBarItem = .init(tabBarSystemItem: .search, tag: 0)
    
    return .init(rootViewController: searchVC)
  }
  
  private var favoritesVC: UINavigationController {
    let favorites = FavoritesListVC()
    favorites.title = "Favorites"
    favorites.tabBarItem = .init(tabBarSystemItem: .favorites, tag: 1)
    
    return .init(rootViewController: favorites)
  }
  
  private func configureTintColor() {
    UITabBar.appearance().tintColor = .systemGreen
    UINavigationBar.appearance().tintColor = .systemGreen
  }
}
