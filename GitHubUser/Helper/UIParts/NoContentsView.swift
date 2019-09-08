//
//  NoContentsView.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import UIKit

class NoContentsView: UIView {

	convenience init() {
		self.init(frame: .zero)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.loadNib()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.loadNib()
	}
	
	func loadNib() {
		if let view = Bundle.main.loadNibNamed("NoContentsView", owner: self, options: nil)?.first as? UIView {
			view.frame = self.bounds
			self.addSubview(view)
		}
	}
	
}
