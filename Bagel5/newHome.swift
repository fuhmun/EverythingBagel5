//
//  SwiftUIView.swift
//  SwiftPantry Proto
//
//  Created by Cannon Goldsby on 2/7/24.
//
import Foundation
import SwiftUI

struct HomeView: View {
    
    @State private var search: String = ""
    @State private var ingredientListed: [String] = []
    let columns = [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))]
    
//    let numbers: [Int] = [1, 2, 3]
    var body: some View {
        ZStack{
            Image(.foodBackground)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                ZStack {
                    UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 20, bottomTrailing: 20))                    .fill(Color.newBlue)
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
                            Image(systemName: "heart.circle")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(.trailing, 35)
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
                                ingredientListed.append(search)
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
                                    ForEach(ingredientListed, id: \.self) {ingredient in
                                        
                                        let ingred: String = ingredient
                                        
                                        HStack{
                                            Text(ingredient)
                                                
//                                            Button(action: ingredientListed.remove) {
//                                                Label(systemImage: "x.circle")
//                                            }
                                            Button {
//                                                ingredientListed.remove
                                                if let index = ingredientListed.firstIndex(of: ingred) {
                                                    ingredientListed.remove(at: index)
                                                }
                                            } label: {
                                                Label("Delete", systemImage: "x.circle")
                                                    .labelStyle(.iconOnly)
                                            }
                                            
                                        }
                                                .background(.white)
                                    }
                                }
                            
                                
                                
                                
                            
                                
                                
                                //                                Text("Chicken")
                                //                                    .background(.white)
                                //                                    .cornerRadius(5)
                            }
                        
                        Text("Generate")
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(width: 321, height: 46)
                            .background(.newRed)
                            .cornerRadius(15)
                    }
                    //                        .background(.red)
                }
//                .frame(width:395, height: 479)
//                .background(.green)
                Spacer()
                Text("No Recipes Available")
                    .foregroundStyle(.black)

            }
        }
    }
}

#Preview {
    HomeView()
}
