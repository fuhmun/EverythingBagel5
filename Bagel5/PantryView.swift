import Foundation
import SwiftUI
import SwiftData

//Logic portion of the code

struct PantryView: View {
    @State private var searchFill: String = ""
    let ingredients = DataManager.loadIngredients()

    var filteredIngredients: [Ingredient] {
        if searchFill.isEmpty {
            return ingredients
        } else {
            return ingredients.filter { $0.name.lowercased().contains(searchFill.lowercased()) }
        }
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                    ZStack {
                        Color.green
                            .ignoresSafeArea()
                        
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                        .foregroundColor(.white)
                        
                        VStack {
                            SearchBar(searchFill: $searchFill)
                            .padding(.horizontal)                        }
                    }
                .frame(height: 150)
                
                Spacer()
                
                HStack {
                    Text("Ingredients")
                        .fontWeight(.bold)
                }
                .padding()
                
                VStack {
                    
                    List(filteredIngredients) { ingredient in
                        Text(ingredient.name)
                    }
                }
            }
        }
    }
}

struct SearchBar: View {
    @Binding var searchFill: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search Ingredients", text: $searchFill)
                .foregroundColor(.primary)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

struct PantryView_Previews: PreviewProvider {
    static var previews: some View {
        PantryView()
    }
}
