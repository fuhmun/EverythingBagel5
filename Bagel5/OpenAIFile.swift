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
        let systemMessage = GPTMessage(role: "system", content: "I want you to act as a recipe generator. I will provide you with a list of ingredients and you will suggest a unique recipe that can be created with them. You should then provide a description of the ricipe followed by detailed and descriptive instructions that are numbered on how to prepare the recipe. Keep in mind that I have majority of seasonings and sauces that are within an average household. Number the instructions and be thorough with explaining them.")
        let userMessage = GPTMessage(role: "user", content: message)
        
        let ingredients = GPTFunctionProperty(type: "string", description: "The available ingredients are \(message)")
        let recipe = GPTFunctionProperty(type: "string", description: "The recommended recipe to make.")
        let description = GPTFunctionProperty(type: "string", description: "Here is a detailed description of this recipe.")
        let instructions = GPTFunctionProperty(type: "string", description: "Here are detialed instructions for this recipe.")
        let timeToCook = GPTFunctionProperty(type: "string", description: "Here is how long it takes to cook this recipe in minutes.")

        let params: [String: GPTFunctionProperty] = [
            "ingredients": ingredients,
            "instructions": instructions,
            "recipe": recipe,
            "timeToCook": timeToCook,
            "description": description
        ]
        
        let functionParam = GPTFunctionParam(type: "object", properties: params, required: ["ingredients", "recipe", "instructions", "timeToCook", "description"])
        let function = GPTFunction(name: "get_recipe", description: "Get the recipe with the given ingredients", parameters: functionParam)
        let payload = GPTChatPayload(model: "gpt-3.5-turbo-0613", messages: [systemMessage, userMessage], functions: [function])
        
        let jsonData = try JSONEncoder().encode(payload)
        
        
        urlRequest.httpBody = jsonData
        return urlRequest
    }
    
    func sendPromptToChatGPT(message: String) async throws -> (String,String,String,String,String) {
        let urlRequest = try generateAIRequest(httpMethod: .post, message: message)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let gptResponse = try JSONDecoder().decode(GPTResponse.self, from: data)
        let args = gptResponse.choices[0].message.functionCall.arguments
        guard let argData = args.data(using: .utf8) else {
            throw URLError(.badURL)
        }
        let response = try JSONDecoder().decode(RecipeResponse.self, from: argData)
        
                
        return (response.instructions,response.ingredients,response.recipe, response.timeToCook, response.description)
        
    }
}


//Encoding

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

//Decoding

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
    let timeToCook: String
    let description: String
}
