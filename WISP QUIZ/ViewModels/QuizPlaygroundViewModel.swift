//
//  QuizPlaygroundViewModel.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 06/11/23.
//

import Foundation

final class QuizPlaygroundViewModel{
    
    var dataList = [GenerateListResponse]()
    var storeResult = [String : StoreResult]()
    
    func getScoreResult(totalScore: Int, totalQs: Int) -> String{
        
        let scorePercentage: Float = (Float(totalScore) / Float(totalQs) * 100.0).rounded()
        
        switch scorePercentage {
        case 0:
            return "Don't worry; you're just getting started. 0% completion means you have a journey ahead."
        case 1..<20:
            return "Progress is progress! You're at \(scorePercentage)% completion."
        case 20..<40:
            return "You're almost halfway there! You've completed \(scorePercentage)%."
        case 40..<60:
            return "Keep up the good work! You're at \(scorePercentage)% completion."
        case 60..<80:
            return "You're making great progress! You've reached \(scorePercentage)% completion."
        case 80..<100:
            return "You're very close to 100%! You've achieved \(scorePercentage)% completion."
        case 100:
            return "Congratulations! You've achieved 100% completion. Well done!"
        default:
            return "Invalid score percentage"
        }
    }
    
    func calculateScore() -> [String]{
        
        let trueCount = storeResult.values.reduce(0) { (result, storeResult) in
            return storeResult.isCorrect ? result + 1 : result
        }
        
        return [String(trueCount), String(dataList.count), getScoreResult(totalScore: trueCount, totalQs: dataList.count)]
    }
}
