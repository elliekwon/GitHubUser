//
//  RepositoryVO.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

class RepositoryVO: Codable {
	var name: String?
	var language: String?
	var stargazersCount: Int?
	var description: String?
	var htmlUrl: String?
}
