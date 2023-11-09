//
//  QuizCollectionViewCell.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 06/11/23.
//

import UIKit
import Combine

class QuizCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet weak private var option01: UILabel!
    @IBOutlet weak private var option02: UILabel!
    @IBOutlet weak private var option03: UILabel!
    @IBOutlet weak private var option04: UILabel!

    @IBOutlet weak var option01View: UIView!
    @IBOutlet weak var option02View: UIView!
    @IBOutlet weak var option03View: UIView!
    @IBOutlet weak var option04View: UIView!
    
    var selectedIndex: Int?
    let action = PassthroughSubject<StoreResult, Never>()
    
    var setValues: GenerateListResponse?{
        didSet{
            
            if let qs = setValues?.question{
                
                questionLbl.text = qs
                questionLbl.isAccessibilityElement = true
                questionLbl.accessibilityLabel = "Question \(qs)"
                questionLbl.accessibilityHint = "Question \(qs)"
                
            }
            
            
            if let ans = setValues?.allAnswers {
                
                setupUI(questionType: setValues?.type)
                
                updateValue(label: option01, view: option01View, option: "A", value: ans[0])
                updateValue(label: option02, view: option02View, option: "B", value: ans[1])
                
                if setValues?.type == .multiple{
                    
                    updateValue(label: option03, view: option03View, option: "C", value: ans[2])
                    
                    updateValue(label: option04, view: option04View, option: "D", value: ans[3])
                    
                }
            }
        }
    }
    
    func updateValue(label: UILabel, view: UIView, option: String, value: String){
        
        label.text = "\(option). \(value)"
        view.isAccessibilityElement = true
        view.accessibilityLabel = "\(option). \(value)"
        view.accessibilityHint = "\(option). \(value)"
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        option01View.addTapGesture{
            self.handleUserClick(view: self.option01View)
        }
        
        option02View.addTapGesture{
            self.handleUserClick(view: self.option02View)
        }
        
        option03View.addTapGesture{
            self.handleUserClick(view: self.option03View)
        }
        
        option04View.addTapGesture{
            self.handleUserClick(view: self.option04View)
        }
        
    }
    
    func handleUserClick(view : UIView){
        
        if selectedIndex == view.tag{
            return
        }
        
        if let selectedIndex {
            
            self.selectedIndex = nil
            
            switch selectedIndex{
                case 1:
                    updateAnswerCell(option01View)
                case 2:
                    updateAnswerCell(option02View)
                case 3:
                    updateAnswerCell(option03View)
                case 4:
                    updateAnswerCell(option04View)
                default: break
            }
            
        }
        
        if let ans = setValues{
            
            let seleted = ans.allAnswers[view.tag - 1]
            
            action.send(StoreResult(value: seleted, isCorrect: seleted == ans.correct_answer, loaction: view.tag))
        }
        
        selectedIndex = view.tag
        updateAnswerCell(view)
        
    }
    
    private func setupUI(questionType: GenerateListResponse.`Type`?){
        
        updateAnswerCell(option01View)
        updateAnswerCell(option02View)
        updateAnswerCell(option03View,type: (questionType == .multiple))
        updateAnswerCell(option04View,type: (questionType == .multiple))
        
        
    }
    
    func updateAnswerCell(_ sender: UIView,type isActive: Bool = true){
        
        if isActive{
            UIView.animate(withDuration: 0.3) {
                sender.isHidden = false
                sender.layer.cornerRadius = 5
                sender.layer.borderWidth = 2
                sender.layer.borderColor = UIColor.accent.cgColor
                sender.backgroundColor = (self.selectedIndex == sender.tag) ? UIColor.accent : UIColor.systemBackground
            }
        } else{
            sender.isHidden = true
        }
    }
    
}
