//
//  UserDetailPresenter.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import Alamofire

protocol UserDetailView: class {
	
	func displayUserDetail()
	
	func displayRepositoryList()
}

final class UserDetailPresenter {
	
	typealias View = UserDetailView & UserDetailViewController
	
	private weak var view: View?
	
	init(view: View) {
		self.view = view
	}
	
	var userVO: UserVO? {
		didSet {
			self.view?.displayUserDetail()
		}
	}
	
	var repositories: [RepositoryVO] = [] {
		didSet {
			self.view?.displayRepositoryList()
		}
	}
	
	/// レポジトリコンテント情報を取得する
	func repositoryContents(index: Int) -> RepositoryVO? {
		return self.repositories[safe: index]
	}
	
	/// ユーザーの情報取得
	///
	/// - Parameters:
	///   - userID: ユーザーID
	func getUserInfo(_ userID: String?) {
		guard let userID = userID else { return }
		
		Alamofire.request(GitHubApi.getUser(userID)).responseObject { [weak self] (response: DataResponse<UserVO>) in
			guard let self = self else { return }
			
			switch response.result {
				
			case .success(let result):
				self.userVO = result
				
			case .failure(let error):
				print(error)
				self.userVO = nil
			}
		}
	}
	
	/// ユーザーのレポジトリのリストを取得
	///
	/// - Parameters:
	///   - userID: レポジトリのユーザーID
	func getUserRepositories(_ userID: String?) {
		guard let userID = userID else { return }
		
		Alamofire.request(GitHubApi.getUserRepositories(userID)).responseObject { [weak self] (response: DataResponse<[RepositoryVO]>) in
			guard let self = self else { return }
			
			switch response.result {
				
			case .success(let result):
				self.repositories = result as [RepositoryVO]
				
			case .failure(let error):
				print(error)
				self.repositories = []
			}
		}
	}
}
