//
//  User.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import Foundation

// Link: https://docs.github.com/en/rest/users/users?apiVersion=2022-11-28

struct User: Codable {
  var id: String
  var url: String
  var name: String?
  var location: String?
  var bio: String?
  var repo: Int
  var gists: Int
  var htmlUrl: String
  var following: Int
  var followers: Int
  var createdAt: String
  
  enum CodingKeys: String, CodingKey {
    case id = "login"
    case url = "avatar_urL"
    case name
    case repo = "publicRepos"
    case gists = "publicGists"
    case htmlUrl = "html_url"
    case following, followers, createdAt
  }
}
