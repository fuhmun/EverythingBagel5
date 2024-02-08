import Foundation
import SwiftUI
import SwiftData

//Logic portion of the code

struct PantryView: View {
    @State private var searchFill: String = ""
    //   @State private var fulfill = false
    let ingredients = DataManager.loadIngredients()
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Ingredients.name) var selectedIngredients: [Ingredients]
    
    func filterName() {
        if searchFill.isEmpty {
            filteredIngredients = originalIngredients
        } else {
            filteredIngredients = filteredIngredients.filter { $0.name.lowercased().contains(searchFill.lowercased()) }
        }
    }
    init() {
        filteredIngredients = ingredients
    }
    
    @State var originalIngredients:[Ingredient] = []
    @State var filteredIngredients: [Ingredient] = []
        
    var body: some View {
        
        ZStack{
            CustomColor.background
                .ignoresSafeArea()
            VStack {
                ZStack {
                    CustomColor.lightGreen
                        .ignoresSafeArea()
                    VStack {
                        SearchBar(searchFill: $searchFill)
                            .padding(.horizontal)
                    }
                }
                .frame(height: 125)
                HStack{
                    Text("Ingredients")
                        .fontWeight(.bold)
                        .padding(.leading, 25)
                    Spacer()
                }
                .padding(3)
                .background(CustomColor.background)
                VStack {
                    List(filteredIngredients) { ingredient in
                        HStack {
                            Text(ingredient.name)
                            Spacer()
                            Button {
                                if let index = filteredIngredients.firstIndex(where: {$0.id == ingredient.id}) {
                                    filteredIngredients[index].isSelected.toggle()
                                    originalIngredients[index].isSelected.toggle()
                                    if originalIngredients[index].isSelected {
                                        let selIngredients = Ingredients(name: filteredIngredients[index].name)
                                        modelContext.insert(selIngredients)
                                    } else {
                                        let delIngredients = selectedIngredients[index]
                                        modelContext.delete(delIngredients)
                                    }
                                }
                            } label : {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(ingredient.isSelected ? CustomColor.lightGreen : .clear)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.black, lineWidth: 2)
                                    )
                                    .frame(width: 25, height: 25)
                            }
                            .buttonStyle(PlainButtonStyle())
                            //                            Spacer()
                            //
                            //                            Button {
                            //
                            //                                if let index = filteredIngredients.firstIndex(where: {$0.id == ingredient.id}) {
                            //
                            //
                            //                                    filteredIngredients[index].isSelected.toggle()
                            //
                            //
                            //                                }
                            //                            } label : {
                            //                                RoundedRectangle(cornerRadius: 5)
                            //                                    .fill(ingredient.isSelected ? .green : .black)
                            //                                            .frame(width: 25, height: 25)
                            //
                            //                            }
                            //
                            //                            .buttonStyle(PlainButtonStyle())
                        }
                        .listRowBackground(CustomColor.background)
                    }
                    .scrollContentBackground(.hidden)
                    .background(CustomColor.background.edgesIgnoringSafeArea(.all))
                }
                .background(CustomColor.background)
            }
            .onAppear {
                filteredIngredients = ingredients
                originalIngredients = ingredients
            }
            .onChange(of: searchFill) {
                filterName()
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
