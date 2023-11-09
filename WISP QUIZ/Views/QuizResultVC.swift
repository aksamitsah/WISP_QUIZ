//
//  QuizResultVC.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 05/11/23.
//

import UIKit

class QuizResultVC: BaseVC {

    @IBOutlet weak var scoreBoardLbl: UILabel!
    @IBOutlet weak var recomendedMsgLbl: UILabel!
    @IBOutlet weak var playAgainBtn: UIButton!{
        didSet{
            playAgainBtn.makeCircular()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let ds = data as? [String], ds.count == 3{
            
            let text = "\(ds[0]) / \(ds[1])"
            let attributedString = NSMutableAttributedString(string: text)

            let rangeOfRedText = (text as NSString).range(of: ds[0])
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.accent, range: rangeOfRedText)

            let rangeOfBlackText = (text as NSString).range(of: ds[1])
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.accent, range: rangeOfBlackText)

            scoreBoardLbl.attributedText = attributedString
            
            recomendedMsgLbl.text = "\(ds[2])"
        }
        
        playAgainBtn.addTapGesture {
            self.moveToRootVC()
        }

    }
    
}
