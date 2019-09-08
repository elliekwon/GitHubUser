//
//  UsersPresenter.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import Alamofire

protocol UsersView: class {
	func displayUserList()
}

class UsersPresenter {
	
	typealias View = UsersView & UsersViewController
	
	private weak var view: View?
	
	init(view: View) {
		self.view = view
	}
	
	var users: [UserVO] = [] {
		didSet {
			self.view?.displayUserList()
		}
	}
	
	/// ユーザーコンテント情報を取得する
	func contents(index: Int) -> UserVO? {
		return self.users[safe: index]
	}
	
	/// GitHubのユーザーのリスト情報を取得
	func getUsers(isClear: Bool = false, isNext: Bool = false) {
		
		Alamofire.request(GitHubApi.getUsers).responseObject { [weak self] (response: DataResponse<[UserVO]>) in
			guard let self = self else { return }
			
			switch response.result {
				
			case .success(let result):
				self.users = result as [UserVO]
				
			case .failure(let error):
				print(error)
				self.users = []
			}
		}
	}
}
