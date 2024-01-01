//
//  Date+Extensions.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 31/12/23.
//

import Foundation

extension Date {
  
  var convertToMonthYearFormat: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM yyyy"
    
    return dateFormatter.string(from: self)
  }
}
