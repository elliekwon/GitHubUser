//
//  WebViewProtocol.swift
//  GitHubUser
//
//  Created by kwon bokyung on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import UIKit

protocol WebViewProtocol {}

extension WebViewProtocol where Self: UIViewController {
	
	func loadWebView(_ url: URL) {
		let viewController = WebViewController.instantiate(name: "Web")
		viewController.url = url
		let navigationController = UINavigationController(rootViewController: viewController)
		self.navigationController?.present(navigationController, animated: true, completion: nil)
	}
	
}
