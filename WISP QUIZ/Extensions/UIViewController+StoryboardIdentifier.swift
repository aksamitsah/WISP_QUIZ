//
//  UITableViewCell+ReuseIdentifier.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 04/11/23.
//

import UIKit

extension UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
}
