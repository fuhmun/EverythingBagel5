//
//  RecipeView.swift
//  Bagel5
//
//  Created by Fahad Munawar on 1/25/24.
//

import Foundation
import SwiftUI

struct RecipeView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack (alignment: .leading) {
                    Text("Recipe")
                        .font(.largeTitle)
                        .padding()
                    
                    
                }
            }
        }
        .task {
            do {
                try await OpenAIService.shared.sendPromptToChatGPT(message: "chicken tortilla eggs and cheese")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
