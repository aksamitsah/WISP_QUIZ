//
//  APIManagaer.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 04/11/23.
//

import Foundation
import Combine

enum APIError: Error {
    
        case invalidResponse
        case invalidURL
        case invalidDecoding
        case custom(_ error: String)
        case message(_ error: Error?)
        
        var localizedDescription: String {
            switch self {
            case .invalidResponse:
                return "Invalid Response Code"
            case .invalidURL:
                return "Failed to create URL"
            case .invalidDecoding:
                return "Failed to Decode Data"
            case .custom(let error):
                return error
            case .message(let error):
                return error?.localizedDescription ?? ""
            }
    }
}

typealias Handler<T> = (Result<T,APIError>) -> Void

final class APIManager {
    
    private class func buildURL(endpoint: API) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        return components
    }
    
    class func request<T: Decodable>(endpoint: API, completion: @escaping Handler<T>) {
        
        let components = buildURL(endpoint: endpoint)
        
        guard let url = components.url else {
            Log.error("URL creation error")
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            guard let data, error == nil else {
                completion(.failure(.message(error)))
                Log.error(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                Log.error("Failed Response Code")
                return
            }
            
            do{
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
                Log.info("Sucessful featched")
            }catch{
                completion(.failure(.message(error)))
                Log.error(error)
            }
        }
        
        dataTask.resume()
    }
}

