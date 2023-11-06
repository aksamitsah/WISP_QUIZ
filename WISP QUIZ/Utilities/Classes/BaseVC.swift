//
//  BaseVC.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 04/11/23.
//

import UIKit

class BaseVC: UIViewController {
    
    var data: Any?
    
    func openVC<T: BaseVC>(_ controllerType: T.Type, data: Any?) {
        if let vc = UIStoryboard(name: "Quiz", bundle: nil).instantiateViewController(withIdentifier: controllerType.storyboardIdentifier) as? T {
            vc.data = data
            present(vc, animated: true)
        }
    }
}
