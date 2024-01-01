//
//  UIViewController+Extensions.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit
import SafariServices

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

// MARK: - LoadingView

fileprivate var containerView: UIView?

extension UIViewController {
  
  func showLoaderView() {
    containerView = UIView(frame: view.bounds)
    if let containerView {
      view.addSubview(containerView)
    }
    
    containerView?.backgroundColor = .secondarySystemGroupedBackground
    containerView?.alpha = 0
    
    UIView.animate(withDuration: 0.25) {
      containerView?.alpha = 0.8
    }
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    containerView?.addSubview(activityIndicator)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    ])
    activityIndicator.startAnimating()
  }
  
  func hideLoaderView() {
    DispatchQueue.main.async {
      containerView?.removeFromSuperview()
      containerView = nil
    }
  }
}

// MARK: - Empty View

extension UIViewController {
  
  func showEmptyView(_ message: String) {
    let emptyView = GFEmptyView(message)
    emptyView.frame = view.bounds
    view.addSubview(emptyView)
  }
}

// MARK: - Safari

extension UIViewController {
  
  func presentSafariVC(_ url: URL, tintColor: UIColor = .systemGreen) {
    let safariVC = SFSafariViewController(url: url)
    safariVC.preferredControlTintColor = tintColor
    present(safariVC, animated: true)
  }
}
