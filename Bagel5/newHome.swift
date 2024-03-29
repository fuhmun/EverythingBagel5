//
//  SwiftUIView.swift
//  SwiftPantry Proto
//
//  Created by Cannon Goldsby on 2/7/24.
//
import Foundation
import SwiftUI
import SwiftData

enum bigIcons: String, Codable {
    case cake
    case carrot
    case utensil
    case cup
    case wine
}

func randomBigIcon()->bigIcons {
    let x = Int.random(in: 1...5)
    switch x {
    case 1:
        return .cake
    case 2:
        return .carrot
    case 3:
        return .wine
    case 4:
        return .cup
    default:
        return .utensil
    }
}

func pickBigIcon(_ icon: bigIcons) -> String {
    
    switch icon {
    case .cake:
        return "bigCakeBG"
    case .carrot:
        return "bigCarrotBG"
    case .utensil:
        return "bigUtensilBG"
    case .cup:
        return "bigCupBG"
    case .wine:
        return "bigWineBG"
    }
    
}

struct newHome: View {
    
    @State private var search: String = ""
    @State private var ingredientListed: [String] = []
    
    @State private var generatedRecipe: Recipes = Recipes(name: "", time: "", ingredients: "", instructions: "")
    
    @State private var isRecipeHidden: Bool = true
    
    @Environment(\.modelContext) var modelContext
    @Query var savedIngredients: [Ingredients]
    
    let columns = [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))]
    
    var body: some View {
        NavigationStack{
            GeometryReader { geoProx in
                ZStack{
                    Image(.foodBackground)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    VStack {
                        ZStack {
                            UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 20, bottomTrailing: 20))
                                .fill(Color.newBlue)
                                .frame(width: geoProx.size.width/1, height: geoProx.size.height/1.6)
                                .ignoresSafeArea()
                                .shadow(color: .black.opacity(0.5), radius: 10)
                            VStack{
                                HStack{
                                    Text("SwiftPantry")
                                        .font(.title)
                                        .foregroundStyle(.white)
                                        .fontWeight(.bold)
                                        .padding(.leading, 35)
                                    Spacer()
                                    NavigationLink {
                                        newFavoritesPage()
                                    } label: {
                                        Image(systemName: "heart.circle")
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                            .padding(.trailing, 35)
                                    }
                                }
                                .padding(.top, geoProx.size.height/18)
                                TextField("Type in the ingredients you have here!", text: $search)
                                    .multilineTextAlignment(.center)
                                    .fontWeight(.bold)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(.white).frame(width: 321, height: 50))
                                    .frame(width: 321, height: 50)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                                    .padding(.top, 5)
                                    .onSubmit {
                                        let selectedIngredient = Ingredients(id: UUID(),name: search)
                                        modelContext.insert(selectedIngredient)
                                        search = ""
                                    }
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.white)
                                        .frame(width: 321, height: 204)
                                        .shadow(radius: 5)
                                        .padding(.top, 3)
                                        .padding(.bottom, 15)
                                    LazyVGrid(columns: columns, spacing: 20){
                                        ForEach(savedIngredients, id: \.self) {ingredient in
                                            //                                        let ingred: String = ingredient
                                            HStack{
                                                Text(ingredient.name)
                                                Button {
                                                    let id = ingredient.id
                                                    try? modelContext.delete(model: Ingredients.self, where: #Predicate<Ingredients> { ingredientID in
                                                        ( id == ingredientID.id)
                                                    })
                                                } label: {
                                                    Label("Delete", systemImage: "x.circle")
                                                        .foregroundStyle(.black)
                                                        .labelStyle(.iconOnly)
                                                }
                                            }
                                            .background(.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 3)
                                                    .stroke(CustomColor.newRed, lineWidth: 1)
                                            )
                                        }
                                    }
//                                    TagListView(tags: savedIngredients)
//                                        .frame(width: 316, height: 199)
                                }
                                Button{
                                    var ingredientsArray: [String] = []
                                    for i in savedIngredients {
                                        ingredientsArray.append(i.name)
                                    }
                                    let ingredientString = ingredientsArray.joined(separator: " ")
                                    print(ingredientString)
                                    Task {
                                        do {
                                            let result = try await OpenAIService.shared.sendPromptToChatGPT(message: ingredientString)
                                            print(result)
                                            generatedRecipe = Recipes(name: result.recipe, time: result.timeToCook, ingredients: result.ingredients, instructions: result.instructions)
                                        } catch {
                                            print(error.localizedDescription)
                                            isRecipeHidden = true
                                            generatedRecipe = Recipes(name: "", time: "", ingredients: "", instructions: "")
                                        }
                                    }
                                    isRecipeHidden = false
                                } label: {
                                    Text("Generate")
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .frame(width: 321, height: 46)
                                        .background(.newRed)
                                        .cornerRadius(15)
                                }
                            }
                        }
                        Spacer()
                        if isRecipeHidden {
                            Text("No Recipes Available")
                                .foregroundStyle(.black)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                                    .shadow(color: .black,radius: 7)
                                )
                        } else {
                            NavigationLink{
                                newRecipeView(recipeInfo: generatedRecipe, name2: generatedRecipe.name, time2: generatedRecipe.time, ingredients2: generatedRecipe.ingredients, instructions2: generatedRecipe.instructions)
                            } label: {
                                ZStack{
                                    Image(pickBigIcon(randomBigIcon()))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geoProx.size.width/1.25, height: geoProx.size.height/4.5)
                                        .shadow(color: .black.opacity(0.5), radius: 10)
                                    VStack{
                                        Spacer()
                                        HStack{
                                            Text(generatedRecipe.name)
                                                .font(.title)
                                            Spacer()
                                        }
                                        Spacer()
                                        HStack{
                                            Spacer()
                                            Text(generatedRecipe.time)
                                        }
                                        Spacer()
                                    }
                                }
                                .frame(width: geoProx.size.width/1.25, height: geoProx.size.height/4.5)
                            }
                        }
                        Spacer()
                        Spacer()
                    }
                }
                .ignoresSafeArea()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

#Preview {
    newHome()
}
