//
//  StartScreenViewModel.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 04/11/23.
//


import Combine

final class StartScreenViewModel{
    
    @Published var observer: StartScreenViewModelObserver?
    
    init() {
        observer = StartScreenViewModelObserver(data: [], error: nil)
    }
    
    func startQuiz(amount: Int = 10, category: Int? = nil, difficulty: String? = nil, type: String? = nil){
        
        APIManager.request(endpoint: OpentdbAPI.generateQuiz(amount: amount, category: category, difficulty: difficulty, type: type)) { [weak self]
            (result: Result<GenerateListModel, APIError>) in
            switch result {
            case .success(let response):
                guard response.response_code == 0, let data = response.results else { return }
                
                if data.isEmpty{
                    self?.observer?.error = "Failed to Fetched Quiz List"
                }else{
                    self?.observer?.data = data
                }
                
            case .failure(let failure):
                self?.observer?.error = failure.localizedDescription
            }
        }
    }
    
}
