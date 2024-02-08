//
//  RecipeView.swift
//  Bagel5
//
//  Created by Fahad Munawar on 1/25/24.
//

import Foundation
import SwiftUI
import SwiftData
import CoreData

var arrayOfRecipes2: [RecipeResponse] = []

struct RecipeView: View {
    
    @State private var bookmarkTog = false
    
    @State private var ingredients: String = ""
    @State private var recipe: String = ""
    @State private var instructions: String = ""
    @State private var timeToCook: String = ""
    @State private var description: String = ""
    
    @Environment(\.modelContext) var modelContext
    @Query var savedRecipes: [Favorites]
    
    
    var body: some View {
//        NavigationStack {
            ZStack{
                Color(CustomColor.background)
                    .ignoresSafeArea()
                GeometryReader { geoProx in
                    ScrollView(.vertical) {
                        VStack (alignment: .leading) {
                            VStack (alignment: .leading){
                                Button(action: {
                                        bookmarkTog.toggle()
                                        if bookmarkTog{
                                            let favRecipes = Favorites(name: recipe, time: timeToCook, information: description , ingredients: ingredients, instructions: instructions)
                                            modelContext.insert(favRecipes)
                                        } else {
//                                            let delRecipes = Favorites(name: recipe, time: timeToCook, information: description , ingredients: ingredients, instructions: instructions)
//                                            modelContext.delete(delRecipes)
                                        }
                                }, label: {
                                    Image(systemName: bookmarkTog ?  "bookmark.fill" : "bookmark")
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
                            .frame(width: geoProx.size.width,height: geoProx.size.height/5)
                            .background(CustomColor.lightGreen)
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
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(CustomColor.darkGreen, lineWidth: 2)
                                            )
                                    }
                                    .background(.white)
                                    .cornerRadius(10)
                                }
                                Spacer()
                                Divider()
                                Text("Instructions")
                                    .font(.title2)
                                Text(instructions)
                            }
                            .padding([.leading,.trailing])
                        }
                    }
                    .ignoresSafeArea()
                }
        }
        
        .task {
            do {
                //                let (instructions, ingredients, recipe, timeToCook, description) = try await OpenAIService.shared.sendPromptToChatGPT(message: mess)
                for index in 0...2 {
                    let result = try await OpenAIService.shared.sendPromptToChatGPT(message: mess)
                    arrayOfRecipes2.append(result)
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
    
    func addRecipes() {
        let recipe = Favorites()
        modelContext.insert(recipe)
    }
    
    func deleteRecipes(_ indexSet: IndexSet) {
        for index in indexSet {
            let recipe = savedRecipes[index]
            modelContext.delete(recipe)
        }
    }
    
}

#Preview {
    RecipeView()
}
