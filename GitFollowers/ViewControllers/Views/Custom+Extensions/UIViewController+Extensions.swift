//
//  UIViewController+Extensions.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

extension UIViewController {
  
  func presentGFAlert(
    _ alertTitle: String? = nil,
    message: String? = nil,
    buttonTitle: String? = nil,
    dismissAction: (() -> Void)?) {
      DispatchQueue.main.async { [weak self] in
        guard let self else { return }
        let vc = GFAlertVC(
          alertTitle,
          message: message,
          buttonTitle: buttonTitle,
          dismissAction: dismissAction)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true)
      }
    }
}
