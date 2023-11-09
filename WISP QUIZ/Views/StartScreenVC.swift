//
//  StartScreenVC.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 04/11/23.
//

import UIKit
import Combine

final class StartScreenVC: BaseVC {
    
    @IBOutlet weak private var playQuizBtn: UIButton!{
        didSet{
            playQuizBtn.makeCircular()
        }
    }
    
    private let viewmodel = StartScreenViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinders()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupBinders(){
        
        viewmodel.$observer.receive(on: DispatchQueue.main)
            .sink { [weak self] observer in
                AppHelper.shared.hideProgressIndicator(view: self?.view)
                if let error = observer?.error {
                    AppHelper.shared.showAlert(title: "Quiz", message: error, vc: self)
                } else if let data = observer?.data, !data.isEmpty{
                    self?.openVC(QuizPlaygroundVC.self, data: data)
                }
            }
            .store(in: &cancellables)
        
    }
    
    @IBAction private func actionPerform(_ sender: UIButton) {
        
        AppHelper.shared.showProgressIndicator(view: self.view)
        //viewmodel.startQuiz() //get random Quiz
        viewmodel.startQuiz(amount: 10, category: 18, difficulty: "easy", type: "multiple")
        
    }
    
}
