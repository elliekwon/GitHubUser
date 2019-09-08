//
//  UserDetailViewController.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, WebViewProtocol {
	
	@IBOutlet weak var tableView: UITableView!
	
	var userID: String?
	
	private let noContentsView = NoContentsView()
	private let userView = UserTableHeaderView()
	
	private lazy var presenter = UserDetailPresenter(view: self)
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.tableView.register(cellType: RepositoryTableViewCell.self)
		self.tableView.tableFooterView = UIView(frame: CGRect.zero)
		self.tableView.register(UINib(nibName: "UserTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "UserTableHeaderView")
		
		self.presenter.getUserInfo(self.userID)
		self.presenter.getUserRepositories(self.userID)
    }

}

// MARK: - UITableView

extension UserDetailViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.presenter.repositories.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(with: RepositoryTableViewCell.self, for: indexPath)
		if let repoVO = self.presenter.repositoryContents(index: indexPath.row) {
			cell.setContents(repoVO)
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UserTableHeaderView") as? UserTableHeaderView
		if let userVO = self.presenter.userVO {
			header?.setContents(userVO)
		}
		return header
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 150
	}
	
}

extension UserDetailViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if let repoVO = self.presenter.repositoryContents(index: indexPath.row), let urlString = repoVO.htmlUrl, let url = URL(string: urlString) {
			self.loadWebView(url)
		}
	}
	
}

extension UserDetailViewController: UserDetailView {
	
	func displayUserDetail() {
		self.tableView.reloadSections([0], with: .automatic)
	}
	
	func displayRepositoryList() {
		self.tableView.reloadData()
	}
	
}
