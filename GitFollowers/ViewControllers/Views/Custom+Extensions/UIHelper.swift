//
//  UIHelper.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

struct UIHelper {
  
  static func customFlowLayout(_ view: UIView) -> UICollectionViewFlowLayout {
    let width = view.bounds.width
    let padding: CGFloat = 12
    let minimumItemSpacing: CGFloat = 10
    
    let finalWidth = width - (padding * 2) - (minimumItemSpacing * 2)
    
    let itemWidth = finalWidth/3
    
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
    layout.itemSize = .init(width: itemWidth, height: itemWidth + 40)
    
    return layout
  }
}
