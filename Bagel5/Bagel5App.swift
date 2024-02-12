//
//  Bagel5App.swift
//  Bagel5
//
//  Created by Fahad Munawar on 1/18/24.
//

import Foundation
import SwiftUI
import SwiftData

@main
struct Bagel5App: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            RecipeView()
//            newFavoritesPage()
//            newRecipeView()
            newHome()
        }
        .modelContainer(for: [Favorites.self,Ingredients.self])
//        .modelContainer(for: Ingredients.self)
    }
}
