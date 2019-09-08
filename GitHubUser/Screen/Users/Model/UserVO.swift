//
//  UserVO.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

class UserVO: Codable {
	var login: String?
	var name: String?
	var avatarUrl: String?
	var htmlUrl: String?
	var followers: Int?
	var following: Int?
}
