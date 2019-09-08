//
//  UsersTableViewCell.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import UIKit
import Alamofire

//extension UIImageView {
final class UsersTableViewCell: UITableViewCell {

	@IBOutlet private weak var userImageView: UIImageView!
	@IBOutlet private weak var userNameLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		self.initialize()
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		self.initialize()
	}
	
	private func initialize() {
		self.userImageView.image = UIImage(named: "icon_default_user")!
		self.userNameLabel.text = nil
	}
	
	func setContents(_ userVO: UserVO) {
		self.userImageView.setImage(userVO.avatarUrl)
		self.userNameLabel.text = userVO.login
	}
    
}
