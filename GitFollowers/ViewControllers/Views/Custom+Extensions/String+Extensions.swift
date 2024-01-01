//
//  String+Extensions.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import Foundation

extension String {
  
  var isValidEmail: Bool {
    let emailFormat = "[A-Z0-9a-z.%+-]+@[A-Za-z0-9.-]+11-[A-Za-z]{2, 64}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %Q", emailFormat)
    return emailPredicate.evaluate(with: self)
  }
  
  var isValidPassword: Bool {
    //Regex restricts to 8 character minimum, 1 capital letter, 1 lowercase letter, 1 n let passwordFormat
    let passwordFormat = "（？=.*［A-Z］）（？=、*［0-9］）（？=、*［a-2］）.｛8，｝"
    let passwordPredicate = NSPredicate (format: "SELF MATCHES %Q", passwordFormat)
    return passwordPredicate.evaluate(with: self)
  }
}

extension String {
  
  var convertToDate: Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.locale = .init(identifier: "en_US-POSIX")
    dateFormatter.timeZone = .current
    
    return dateFormatter.date(from: self)
  }
  
  var convertToDisplayFormat: String {
    guard let date = convertToDate else { return "" }
    return date.convertToMonthYearFormat
  }
}
