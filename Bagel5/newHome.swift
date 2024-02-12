//
//  SwiftUIView.swift
//  SwiftPantry Proto
//
//  Created by Cannon Goldsby on 2/7/24.
//
import Foundation
import SwiftUI
import SwiftData

struct newHome: View {
    
    @State private var search: String = ""
    @State private var ingredientListed: [String] = []
    
    @State private var isRecipeHidden: Bool = true
    
    @Environment(\.modelContext) var modelContext
    @Query var savedIngredients: [Ingredients]
    
    let columns = [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))]
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image(.foodBackground)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    ZStack {
                        UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 20, bottomTrailing: 20))
                            .fill(Color.newBlue)
                            .frame(width:395, height: 479)
                            .ignoresSafeArea()
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
                                                //                                                if let index = ingredientListed.firstIndex(of: ingred) {
                                                //                                                    ingredientListed.remove(at: index)
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
                            }
                            Button{
                                var ingredientsArray: [String] = []
                                for i in savedIngredients {
                                    ingredientsArray.append(i.name)
                                }
                                var ingredientString = ingredientsArray.joined(separator: " ")
                                print(ingredientString)
                                Task {
                                    do {
                                        let result = try await OpenAIService.shared.sendPromptToChatGPT(message: ingredientString)
                                        print(result)
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
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
                    //                .frame(width:395, height: 479)
                    
                    Spacer()
                    Text("No Recipes Available")
                        .foregroundStyle(.black)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .shadow(color: .black,radius: 7)
                        )
                    Spacer()
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    newHome()
}
