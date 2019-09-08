//
//  UITableView+Extension.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import UIKit

extension UITableView {
	
	public func register(cellType: UITableViewCell.Type, bundle: Bundle? = nil) {
		let className = cellType.className
		let nib = UINib(nibName: className, bundle: bundle)
		register(nib, forCellReuseIdentifier: className)
	}
	
	public func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
		return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
	}
	
	public func dequeueReusableCell<T: UITableViewCell>(with type: T.Type) -> T {
		return self.dequeueReusableCell(withIdentifier: type.className) as! T
	}
	
	public func setRefreshControl(message: String? = nil) {
		self.refreshControl = UIRefreshControl()
		if let message = message {
			self.refreshControl?.attributedTitle = NSAttributedString(string: message)
		}
	}
	
	public func reloadData(completion: @escaping () -> Void) {
		UIView.animate(withDuration: 0, animations: { [weak self] in
			guard let self = self else { return }
			self.reloadData()
			self.layoutIfNeeded()
		}, completion: { _ in
			completion()
		})
	}
	
}
