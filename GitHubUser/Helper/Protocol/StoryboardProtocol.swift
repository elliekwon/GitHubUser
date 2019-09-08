//
//  StoryboardProtocol.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable {
	static var storyboardName: String { get }
}

extension StoryboardInstantiable where Self: UIViewController {
	static var storyboardName: String {
		return className
	}
	
	private static var storyboard: UIStoryboard {
		return UIStoryboard(name: storyboardName, bundle: nil)
	}
	
	static func instantiate(name: String) -> Self {
		let storyboard = UIStoryboard(name: name, bundle: nil)
		return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! Self
	}
}

