//
//  WebViewController.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, StoryboardInstantiable {

	@IBOutlet weak var webView: WKWebView!
	
	var url: URL?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadWebView()
    }
    

	// MARK: - Method
	
	func loadWebView() {
		guard let url = url else { return }
		
		let request = URLRequest(url: url)
		self.webView.load(request)
	}
	
	// MARK: - Action
	
	@IBAction func closeButtonAction(_ sender: Any) {
		self.dismiss(animated: true)
	}
	
}
