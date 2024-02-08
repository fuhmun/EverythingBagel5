//
//  PantrySource.swift
//  Bagel5
//
//  Created by Cannon Goldsby on 1/31/24.
//
import SwiftUI
import Foundation

struct Ingredient: Identifiable {
    var id = UUID()
    var name: String
    var isSelected = false
}

class DataManager {
    static func loadIngredients() -> [Ingredient] {
        if let path = Bundle.main.path(forResource: "ingredients", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let lines = data.components(separatedBy: .newlines)
                let ingredients = lines.map { Ingredient(name: $0) }
                return ingredients
            } catch {
                print("Error reading file: \(error)")
            }
        }
        return []
    }
}
