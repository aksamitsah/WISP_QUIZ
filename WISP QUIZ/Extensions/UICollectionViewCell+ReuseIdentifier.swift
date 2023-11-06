//
//  UICollectionViewCell+identifier.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 06/11/23.
//

import Foundation


import UIKit

extension UICollectionView {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
}
