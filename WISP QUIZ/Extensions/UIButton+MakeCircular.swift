//
//  UIButton+Customization.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 04/11/23.
//

import UIKit

extension UIButton {
    func makeCircular() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
