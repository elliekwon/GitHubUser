//
//  RepositoryTableViewCell.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
	
	@IBOutlet weak var repositoryNameLabel: UILabel!
	@IBOutlet weak var programmingLanguageLabel: UILabel!
	@IBOutlet weak var starCountLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		self.initialize()
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		self.initialize()
	}
	
	private func initialize() {
		self.repositoryNameLabel.text = nil
		self.programmingLanguageLabel.text = nil
		self.starCountLabel.text = nil
		self.descriptionLabel.text = nil
	}

	func setContents(_ repoVO: RepositoryVO) {
		self.repositoryNameLabel.text = repoVO.name
		self.programmingLanguageLabel.text = repoVO.language
		self.starCountLabel.text = (repoVO.stargazersCount ?? 0 as Int).string(withComma: true)
		self.descriptionLabel.text = repoVO.description
	}
	
}
