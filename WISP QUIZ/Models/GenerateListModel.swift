//
//  GenerateListModel.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 04/11/23.
//

import Foundation

struct GenerateListModel: Decodable{
    let response_code: Int
    let results: [GenerateListResponse]?
}


struct GenerateListResponse: Decodable {

    enum `Type`{
        case boolean
        case multiple
        case none
    }
    
    enum Difficulty {
        case easy
        case medium
        case hard
        case none
    }
    
    var category: String = ""
    var type: `Type` = .none
    var difficulty: Difficulty = .none
    var question: String = ""
    var correct_answer: String = ""
    var incorrect_answers: [String] = []
    
    var allAnswers: [String] = []
    
    enum codingKeys: String,CodingKey{
        case category, type, difficulty, question, correct_answer, incorrect_answers
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: codingKeys.self)
        
        if let ds = try? values.decode(String.self, forKey: .category){
            category = ds
        }
        if let ds = try? values.decode(String.self, forKey: .type){
            type = (ds == "boolean") ? .boolean : .multiple
        }
        if let ds = try? values.decode(String.self, forKey: .difficulty){
            difficulty = (ds == "easy") ? .easy : (ds == "medium") ? .medium : .hard
        }
        if let ds = try? values.decode(String.self, forKey: .question){
            question = ds
                .replacingOccurrences(of: "&quot;", with: "\"")
                .replacingOccurrences(of: "&#039;", with: "'")
        }
        if let ds = try? values.decode(String.self, forKey: .correct_answer){
            correct_answer = ds
                .replacingOccurrences(of: "&quot;", with: "\"")
                .replacingOccurrences(of: "&#039;", with: "'")
        }
        if let ds = try? values.decode([String].self, forKey: .incorrect_answers){
            incorrect_answers = ds.map{
                $0.replacingOccurrences(of: "&quot;", with: "\"")
                    .replacingOccurrences(of: "&#039;", with: "'") 
            }
        }
        
        allAnswers = [correct_answer] + incorrect_answers
        allAnswers.shuffle()
        
    }
}

struct StartScreenViewModelObserver {
    var data: [GenerateListResponse]
    var error: String?
}
