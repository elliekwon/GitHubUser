//
//  GitHubApi.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import Alamofire

enum GitHubApi: URLRequestConvertible {
	
	/// ユーザーの一覧を取得
	case getUsers
	/// 特定のユーザーの情報を取得
	case getUser(_ userID: String)
	/// 特定のユーザーのレポジトリ一覧を取得
	case getUserRepositories(_ userID: String)
	
	var method: Alamofire.HTTPMethod {
		switch self {
		case .getUsers, .getUser, .getUserRepositories:
			return .get
		}
	}
	
	var path: String {
		switch self {
		case .getUsers:
			return "/users"
		case .getUser(let userID):
			return "/users/\(userID)"
		case .getUserRepositories(let userID):
			return "/users/\(userID)/repos"
		}
	}
	
	func asURLRequest() throws -> URLRequest {
		var urlRequest = URLRequest(url: URL(string: "\(BASE_URL)\(path)")!)
		urlRequest.httpMethod = method.rawValue
		urlRequest.setValue(GITHUB_ACCESS_TOKEN, forHTTPHeaderField: "Authorization")
		return try URLEncoding.default.encode(urlRequest, with: nil)
	}
	
}
