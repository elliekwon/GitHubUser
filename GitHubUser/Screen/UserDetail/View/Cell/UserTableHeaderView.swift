//
//  UserTableHeaderView.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import UIKit

class UserTableHeaderView: UITableViewHeaderFooterView {
	
	@IBOutlet weak var userImageView: UIImageView!
	@IBOutlet weak var userIdLabel: UILabel!
	@IBOutlet weak var userFullNameLabel: UILabel!
	@IBOutlet weak var userGitUrlLabel: UILabel!
	@IBOutlet weak var followersCountLabel: UILabel!
	@IBOutlet weak var followingCountLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.initialize()
	}
	
	private func initialize() {
		self.userImageView.image = UIImage(named: "icon_default_user")!
		self.userIdLabel.text = nil
		self.userFullNameLabel.text = nil
		self.userGitUrlLabel.text = nil
		self.followersCountLabel.text = nil
		self.followingCountLabel.text = nil
	}
	
	func setContents(_ userVO: UserVO) {
		self.userImageView.setImage(userVO.avatarUrl)
		self.userIdLabel.text = userVO.login
		self.userFullNameLabel.text = userVO.name
		self.userGitUrlLabel.text = userVO.htmlUrl ?? "" as String
		self.followersCountLabel.text = (userVO.followers ?? 0 as Int).string(withComma: true)
		self.followingCountLabel.text = (userVO.following ?? 0 as Int).string(withComma: true)
	}
	
}
