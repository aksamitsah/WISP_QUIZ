//
//  UILabel.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 09/11/23.
//

import UIKit


extension UILabel{
    
    func voiceOverSetup(isEnable: Bool = false,accessibilityLabel label: String? = nil, accessibilityHint hint: String? = nil){
         
        isAccessibilityElement = isEnable
        accessibilityLabel = label ?? self.text
        accessibilityHint = hint ?? self.text
        
    }
}
