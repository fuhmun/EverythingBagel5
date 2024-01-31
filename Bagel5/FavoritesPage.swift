//
//  FavoritesPage.swift
//  Bagel5
//
//  Created by Fahad Munawar on 1/25/24.
//

import SwiftUI
import SwiftData

@Model
class Recipes {
    var name: String
    var time: String
    //    var information: String
    var ingredients: String
    var instructions: String
    
    init(name: String = "", time: String = "", ingredients: String = "", instructions: String = "") {
        self.name = name
        self.time = time
        //        self.information = information
        self.ingredients = ingredients
        self.instructions = instructions
    }
}

struct CustomColor {
    static let background = Color("background")
    static let navyBlue = Color("navyBlue")
    static let lightGreen = Color("lightGreen")
    static let darkGreen = Color("darkGreen")
}

//struct savedRecipe: Identifiable {
//    var id = UUID()
//    let items: String
//    let times: Int
//    
//    static let sampleData = [
//        savedRecipe(items: "Chicken Burrito", times: 15),
//        savedRecipe(items: "Chicken and Rice", times: 20),
//        savedRecipe(items: "Chicken Soup", times: 10)
//    ]
//}

struct FavoritesPage: View {
    
//    let recipes = savedRecipe.sampleData
    
    @Environment(\.modelContext) var modelContext
    @Query var savedRecipes: [Recipes]
    
    var body: some View {
        ZStack{
            Color(CustomColor.background)
                .ignoresSafeArea()
            GeometryReader { geoProx in
                VStack {
                    VStack{
                        Spacer()
                        Text("Favorites")
                            .foregroundColor(.white)
                            .font(.custom("SF Pro", size: 40))
                            .frame(maxWidth: .infinity,alignment: .bottomLeading)
                            .padding(.leading, geoProx.size.width/12)
                            .padding(.bottom, 10)
                    }
                    .frame(width: geoProx.size.width,height: geoProx.size.height/7)
                    .background(CustomColor.lightGreen)
                    VStack{
                        NavigationStack {
                            List {
                                ForEach(savedRecipes) { recipe in
                                    HStack{
                                        Text(recipe.name)
                                            .font(.custom("SF Pro", size: 25))
                                        Spacer()
                                        VStack{
                                            Text(recipe.time)
                                            Text("Min.")
                                        }
                                        .font(.custom("SF Pro", size: 15))
                                    }
                                }
                                .onDelete(perform: deleteRecipes)
                                .foregroundColor(.white)
                                .listRowSeparator(.hidden)
                                .listRowBackground(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(CustomColor.lightGreen)
                                        .padding(7)
                                        .shadow(color: .black.opacity(0.6),radius: 3)
                                )
                            }
                            .environment(\.defaultMinListRowHeight, 70)
                            .scrollContentBackground(.hidden)
                            .background(CustomColor.background.edgesIgnoringSafeArea(.all))
                            .toolbar {
                                Button("Add", action: addSamples)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func addSamples(){
        let recipe1 = Recipes(name: "Chicken", time: "15", ingredients: "Blah", instructions: "Blah")
        let recipe2 = Recipes(name: "Steak", time: "20", ingredients: "Blah", instructions: "Blah")
        let recipe3 = Recipes(name: "Sushi", time: "15", ingredients: "Blah", instructions: "Blah")
        
        modelContext.insert(recipe1)
        modelContext.insert(recipe2)
        modelContext.insert(recipe3)
    }
    
    func deleteRecipes(_ indexSet: IndexSet) {
        for index in indexSet {
            let recipe = savedRecipes[index]
            modelContext.delete(recipe)
        }
    }
    
}


#Preview {
    FavoritesPage()
}
