//
//  UIImageView+Extension.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import SDWebImage

extension UIImageView {
	
	func setImage(_ urlString: String?, placeholderImage: UIImage? = nil) {
		guard let urlString = urlString, let imageUrl = URL(string: urlString) else { return }
		
		self.sd_setImage(with: imageUrl, placeholderImage: placeholderImage)
	}
	
}
