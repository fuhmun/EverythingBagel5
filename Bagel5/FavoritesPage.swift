//
//  FavoritesPage.swift
//  Bagel5
//
//  Created by Fahad Munawar on 1/25/24.
//

import SwiftUI

struct recipe: Identifiable {
    var id = UUID()
    let items: String
    let times: Int
    
    static let sampleData = [
        recipe(items: "Chicken Burrito", times: 10)
    ]
}



struct CustomColor {
    static let background = Color("background")
    static let navyBlue = Color("navyBlue")
    static let lightGreen = Color("lightGreen")
    static let darkGreen = Color("darkGreen")
}

struct FavRecipeView: View {
    
    var body: some View{
        ZStack{
            HStack{
            }
        }
    }
}

struct FavoritesPage: View {
    
    let recipes = recipe.sampleData
    
    var body: some View {
        ZStack{
            Color(CustomColor.background)
                .ignoresSafeArea()
            GeometryReader { geoProx in
                VStack {
                    VStack{
                        Text("Favorites")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, alignment: .bottomLeading)
                            .padding(geoProx.size.width/15)
                    }
                    .frame(width: geoProx.size.width,height: geoProx.size.height/7)
                    .background(CustomColor.lightGreen)
                    VStack{
                        ForEach(recipes) { recipe in
                            Button{
                                
                            } label: {
                                Text(recipe.items)
                                Text("\(recipe.times)")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FavoritesPage()
}
