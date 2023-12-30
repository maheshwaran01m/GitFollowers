//
//  Follower.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import Foundation

struct Follower: Codable {
  var id: String
  var url: String
  
  enum CodingKeys: String, CodingKey {
    case id = "login"
    case url = "avatar_url"
  }
}
