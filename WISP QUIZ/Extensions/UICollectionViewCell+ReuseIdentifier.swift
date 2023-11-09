//
//  UICollectionViewCell+identifier.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 06/11/23.
//

import Foundation


import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
