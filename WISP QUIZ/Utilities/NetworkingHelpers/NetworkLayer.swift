//
//  NetworkLayer.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 04/11/23.
//

import Foundation

enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

enum HTTPScheme: String {
    case http
    case https
}


protocol API {
    var scheme: HTTPScheme { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: HTTPMethod { get }
}


enum OpentdbAPI {
    case categoryList
    case categoryCountLookup(category: Int)
    case globalCategoryCountLookup
    case generateQuiz(amount: Int, category: Int?, difficulty: String?, type: String?)
}

extension OpentdbAPI: API{
    
    var scheme: HTTPScheme{
        switch self {
        case .categoryList, .categoryCountLookup, .globalCategoryCountLookup, .generateQuiz:
            return .https
        }
    }
    
    var baseURL: String{
        return "opentdb.com"
    }
    
    var path: String{
        switch self {
        case .categoryList:
            return "/api_category.php"
        case .categoryCountLookup:
            return "/api_count.php"
        case .globalCategoryCountLookup:
            return "/api_count_global.php"
        case .generateQuiz:
            return "/api.php"
        }
    }
    
    var parameters: [URLQueryItem]{
        
        var params: [URLQueryItem] = []
        
        switch self {
            
        case .categoryList: break
        case .categoryCountLookup(let category):
            params.append(URLQueryItem(name: "category", value: "\(category)"))
        case .globalCategoryCountLookup: break
        case .generateQuiz(let amount,let category,let difficulty,let type):
            
            params.append(URLQueryItem(name: "amount", value: "\(amount)"))

            if let category{
                params.append(URLQueryItem(name: "category", value: "\(category)"))
            }
            
            if let difficulty{
                params.append(URLQueryItem(name: "difficulty", value: "\(difficulty)"))
            }
            
            if let type{
                params.append(URLQueryItem(name: "type", value: "\(type)"))
            }
        }
        
        return params
    }
    
    var method: HTTPMethod{
        switch self {
        case .categoryList, .categoryCountLookup, .globalCategoryCountLookup, .generateQuiz:
            return .get
        }
    }
    
}
