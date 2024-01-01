//
//  UITableView+Extensions.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 01/01/24.
//

import UIKit

extension UITableView {
  
  func removeFooterView() {
    tableFooterView = UIView()
  }
  
  func reloadUI() {
    DispatchQueue.main.async {
      self.reloadData()
    }
  }
}
