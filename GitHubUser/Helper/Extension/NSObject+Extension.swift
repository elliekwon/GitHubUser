//
//  NSObject+Extension.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {
	static var className: String { get }
	var className: String { get }
}

public extension ClassNameProtocol {
	static var className: String {
		return String(describing: self)
	}
	
	var className: String {
		return type(of: self).className
	}
}

extension NSObject: ClassNameProtocol {}
