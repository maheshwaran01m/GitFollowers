//
//  UIViewController+Extensions.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

extension UIViewController {
  
  func presentGFAlert(
    _ alertItem: AlertItem?) {
      DispatchQueue.main.async { [weak self] in
        guard let self else { return }
        let vc = GFAlertVC(alertItem)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true)
      }
    }
}
