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
        let systemMessage = GPTMessage(role: "system", content: "I want you to act as a recipe generator. I will provide you with a list of ingredients and you will suggest a unique recipe that can be created with them. You should also provide instructions on how to prepare the recipe, as well as nutritional information on each dish.")
        let userMessage = GPTMessage(role: "user", content: message)
        
        let ingredients = GPTFunctionProperty(type: "string", description: "The available ingredients are \(message)")
        let recipe = GPTFunctionProperty(type: "string", description: "The recommended recipe to make.")
        let instructions = GPTFunctionProperty(type: "string", description: "Here are detialed instructions for this recipe.")
        
        let params: [String: GPTFunctionProperty] = [
            "ingredients": ingredients,
            "instructions": instructions,
            "recipe": recipe
        ]
        
        let functionParam = GPTFunctionParam(type: "object", properties: params, required: ["ingredients", "recipe", "instructions"])
        let function = GPTFunction(name: "get_recipe", description: "Get the recipe with the given ingredients", parameters: functionParam)
        let payload = GPTChatPayload(model: "gpt-3.5-turbo-0613", messages: [systemMessage, userMessage], functions: [function])
        
        let jsonData = try JSONEncoder().encode(payload)
        
        
        urlRequest.httpBody = jsonData
        return urlRequest
    }
    
    func sendPromptToChatGPT(message: String) async throws {
        let urlRequest = try generateAIRequest(httpMethod: .post, message: message)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let gptResponse = try JSONDecoder().decode(GPTResponse.self, from: data)
        let args = gptResponse.choices[0].message.functionCall.arguments
        guard let argData = args.data(using: .utf8) else {
            throw URLError(.badURL)
        }
        let recipe = try JSONDecoder().decode(RecipeResponse.self, from: argData)
        print(recipe)
        //print(gptResponse)
        //print(gptResponse.choices[0].message.functionCall)
        //print(String(data: data, encoding: .utf8)!)
        
    }
}


//ep1
/*
 struct model:Codable {
  let id
 let choices:
 
 */
struct GPTChatPayload: Encodable {
    let model: String
    let messages: [GPTMessage]
    let functions: [GPTFunction]
}
struct GPTMessage: Encodable {
    let role: String
    let content: String
}

struct GPTFunction: Encodable {
    let name: String
    let description: String
    let parameters: GPTFunctionParam
}

struct GPTFunctionParam: Encodable {
    let type: String
    let properties: [String: GPTFunctionProperty]?
    let required: [String]?
}

struct GPTFunctionProperty: Encodable {
    let type: String
    let description: String
}
//ep2
struct GPTResponse: Decodable {
    let choices: [GPTCompletion]
}

struct GPTCompletion: Decodable {
    let message: GPTResponseMessage
}

struct GPTResponseMessage: Decodable {
    let functionCall: GPTFunctionCall
    
    enum CodingKeys: String, CodingKey {
        case functionCall = "function_call"
    }
}

struct GPTFunctionCall: Decodable {
    let name: String
    let arguments: String
}

struct RecipeResponse: Decodable {
    let ingredients: String
    let recipe: String
    let instructions: String
}
