//
//  User.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import Foundation

// Link: https://docs.github.com/en/rest/users/users?apiVersion=2022-11-28

struct User: Codable {
  let id: String
  let url: String
  var name: String?
  var location: String?
  var bio: String?
  let repo: Int
  let gists: Int
  let htmlUrl: String
  let following: Int
  let followers: Int
  let createdAt: String
  
  enum CodingKeys: String, CodingKey {
    case id = "login"
    case url = "avatar_url"
    case name, location, bio
    case repo = "public_repos"
    case gists = "public_gists"
    case htmlUrl = "html_url"
    case createdAt = "created_at"
    case following, followers
  }
}
