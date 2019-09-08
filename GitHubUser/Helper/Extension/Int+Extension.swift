//
//  Int+Extension.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import Foundation

extension Int {
	
	func string(withComma: Bool = false) -> String {
		if withComma {
			let formatter = NumberFormatter()
			formatter.numberStyle = NumberFormatter.Style.decimal
			formatter.groupingSeparator = ","
			formatter.groupingSize = 3
			formatter.minimumFractionDigits = 0
			formatter.maximumFractionDigits = 0
			
			return formatter.string(from: self as NSNumber)!
		} else {
			return String(self)
		}
	}
	
}
