//
//  OpenAIFile.swift
//  Bagel5
//
//  Created by Fahad Munawar on 1/22/24.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

class OpenAIService {
    static let shared = OpenAIService()
    
    private init() {}
    
    private func generateAIRequest(httpMethod: HTTPMethod, message: String) throws -> URLRequest {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        
        //Method
        urlRequest.httpMethod = httpMethod.rawValue
        
        //Header
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(Secret.key)", forHTTPHeaderField: "Authorization")
        //Body
        let systemMessage = GPTMessages(role: "system", content: "You are a professional chef with many delicious recipes that are easy and quick to cook.")
        
        let userMessage = GPTMessages(role: "user", content: message)
        
        
        
        return URLRequest(url: url)
    }
}

struct GPTMessages: Encodable {
    let role: String
    let content: String
}
