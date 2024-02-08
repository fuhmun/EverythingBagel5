//
//  FavoritesPage.swift
//  Bagel5
//
//  Created by Fahad Munawar on 1/25/24.
//

import Foundation
import SwiftUI
import SwiftData

struct FavoritesPage: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var savedRecipes: [Favorites]
    
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
                                        VStack {
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
//                            .toolbar {
//                                Button("Add", action: addSamples)
//                            }
                        }
                    }
                }
            }
        }
    }
    
//    func addSamples(){
//        let recipe1 = Favorites(name: "Chicken", time: "15", ingredients: "Blah", instructions: "Blah")
//        let recipe2 = Favorites(name: "Steak", time: "20", ingredients: "Blah", instructions: "Blah")
//        let recipe3 = Favorites(name: "Sushi", time: "15", ingredients: "Blah", instructions: "Blah")
//        
//        modelContext.insert(recipe1)
//        modelContext.insert(recipe2)
//        modelContext.insert(recipe3)
//    }
    
//    func addRecipes() {
//        let recipe = Favorites()
//        modelContext.insert(recipe)
//    }
    
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
