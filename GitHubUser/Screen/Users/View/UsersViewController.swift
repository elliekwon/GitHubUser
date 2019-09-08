//
//  UsersViewController.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UsersView {

	@IBOutlet weak var tableView: UITableView!
	
	private lazy var presenter = UsersPresenter(view: self)
	
	private let noContentsView = NoContentsView()
	
	override func viewDidLoad() {
        super.viewDidLoad()

		self.tableView.register(cellType: UsersTableViewCell.self)
		self.tableView.tableFooterView = UIView(frame: CGRect.zero)
		self.tableView.setRefreshControl(message: "再取得")
		self.tableView.refreshControl?.addTarget(self, action: #selector(self.refreshAction), for: .valueChanged)
		
		self.presenter.getUsers()
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let viewController = segue.destination as? UserDetailViewController, let indexPath = sender as? IndexPath {
			if let userVO = self.presenter.contents(index: indexPath.row) {
				viewController.userID = userVO.login
			}
		}
	}
	
	func displayUserList() {
		self.tableView.reloadData() { [weak self] in
			guard let self = self else { return }
			
			if self.tableView.numberOfRows(inSection: 0) <= 0 {
				self.tableView.backgroundView = self.noContentsView
			} else {
				self.tableView.backgroundView = nil
			}
		}
	}
	
	// MARK: - Action
	
	@objc func refreshAction(_ sender: Any) {
		self.tableView.refreshControl?.endRefreshing()
		
		self.presenter.getUsers(isClear: true)
	}
	
}

// MARK: - UITableView

extension UsersViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.presenter.users.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(with: UsersTableViewCell.self, for: indexPath)
		if let userVO = self.presenter.contents(index: indexPath.row) {
			cell.setContents(userVO)
			cell.layoutIfNeeded()
		}
		return cell
	}

}

extension UsersViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		performSegue(withIdentifier: "showUserDetail", sender: indexPath)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if scrollView.contentOffset.y + 1 >= (scrollView.contentSize.height - scrollView.bounds.size.height) {
			//self.presenter.getUsers(isNext: true)
		}
	}
	
}
