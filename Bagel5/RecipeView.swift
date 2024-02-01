//
//  RecipeView.swift
//  Bagel5
//
//  Created by Fahad Munawar on 1/25/24.
//

import Foundation
import SwiftUI

let mess = "chicken eggs cheese"

var arrayOfRecipes: [RecipeResponse] = []

struct RecipeView: View {
    
    @State private var ingredients: String = ""
    @State private var recipe: String = ""
    @State private var instructions: String = ""
    @State private var timeToCook: String = ""
    @State private var description: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color(CustomColor.background)
                    .ignoresSafeArea()
                ScrollView(.vertical) {
                    VStack (alignment: .leading) {
                        VStack (alignment: .leading){
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Image(systemName: "bookmark")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                                    .padding()
                                    .foregroundColor(.white)
                            })
                            Text(recipe)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("Time\n\(timeToCook)")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            
                        }
                        .padding()
                        .background {
                            Color(CustomColor.lightGreen)
                                .ignoresSafeArea()
                        }
                        
                        VStack (alignment: .leading){
                            Spacer()
                            Divider()
                            Text("Description")
                                .font(.title2)
                            Text(description)
                            
                            Spacer()
                            Divider()
                            
                            Text("Ingredients")
                                .font(.title2)
                            let components = mess.components(separatedBy: " ")
                            HStack {
                                ForEach(components, id: \.self) { ingre in
                                    Text(ingre)
                                        .multilineTextAlignment(.leading)
                                        .padding()
                                        .background {
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(.white)
                                        }
                                }
                            }
                            
                            Spacer()
                            Divider()
                            Text("Instructions")
                                .font(.title2)
                            Text(instructions)
                            
                            
                        }
                    }
                    .padding()
                }
            }
        }
        .task {
            do {
//                let (instructions, ingredients, recipe, timeToCook, description) = try await OpenAIService.shared.sendPromptToChatGPT(message: mess)
                for index in 0...2 {
                    let result = try await OpenAIService.shared.sendPromptToChatGPT(message: mess)
                    arrayOfRecipes.append(result)
                    print(arrayOfRecipes[index])
                }
                
                
//                self.recipe = recipe
//                self.timeToCook = timeToCook
//                self.ingredients = ingredients
//                self.instructions = instructions
//                self.description = description                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    RecipeView()
}
