//
//  ContentView.swift
//  Bagel5
//
//  Created by Fahad Munawar on 1/18/24.
//


import SwiftUI

//struct MacroView: View {
//
struct ContentView: View {
    @State var carbs = 162
    @State var fats = 37
    @State var proteins = 122
    
    @State var lowCarb = "Breakfast: Overnight Oats Time: 5 minutes, Carbs: 30g, Protein: 7g, Fat: 15g Ingredients: 1 cup of oats, almond milk, berries, chia seeds, maple syrup Instructions: 1. In a mason jar or airtight container, combine rolled oats, almond milk, mixed berries, chia seeds, and maple syrup. 2. Stir well, cover, and refrigerate overnight. 3. In the morning, stir and enjoy."
    
    @State var pickybalancedMeal = ""
    @State var veganhighProteins = "Time: 5 minutes Carbs: 30g, Protein: 7g, Fat: 15g."
    
    var body: some View {
        NavigationStack{
            //        ScrollView (.vertical, showsIndicators: false) {
            
            ZStack {
                //            Color.cream
                //                .ignoresSafeArea(.all)
                VStack (alignment: .leading) {
                    Text("Pantry")
                      
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    
                    VStack {
                      
                        Text("")
                            .font(.title)
                            
                        //
                        //
                        
                        
                            .font(.subheadline)
                            .frame(width: 70)
                    }
                    .padding(140)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue.opacity(0.3))
                    )
                    
                    Text("Recipes")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    VStack (alignment: .leading){
                        ScrollView (.horizontal, showsIndicators: false) {
                            //
                            ForEach(0..<1) { _ in
                                RecipesItemView(lowCarb: Binding.constant("  Time: 5 minutes, carbs: 30g, Protein: 7g,Fat: 15g"), balancedMeal: Binding.constant("Grilled Chicken and Cheese Sandwich Time: 20 minutes, Carbs: 30g, Protein: 25g, Fat: 18g"), highProtein: Binding.constant("Baked Salmon with Mashed Potatoes and Steamed Broccoli, Time: 20 minutes, Carbs: 25g, Protein: 30g, Fat: 15g"))
                            }
                            //
                            
                        }
                        //                        VStack {
                        //
                        //                            Text("")
                        //                                .font(.title)
                        //    //
                        //    //
                        //
                        //
                        //                                .font(.subheadline)
                        //                                .frame(width: 70)
                        //                        }
                        //                        .padding(130)
                        //                        .background(
                        //                            RoundedRectangle(cornerRadius: 10)
                        //                                .fill(.blue.opacity(0.3))
                        //                        )
                        
                        //                            Text("Today's Macros")
                        //                                .font(.title)
                        //                                .padding()
                        //
                        //                            MacroItemView(carbs: $carbs, fats: $fats, proteins: $proteins)
                        //
                        //                            Text("Previous")
                        //                                .font(.title)
                        //                                .padding()
                        
                        //                            VStack (alignment: .leading){
                        //                                ScrollView (.vertical, showsIndicators: false) {
                        //                                    //
                        //                                    ForEach(0..<10) { _ in MacroItemView(carbs: .constant(Int.random(in: 10..<200)),  fats: .constant(Int.random(in: 10..<200)),proteins: .constant(Int.random(in: 10..<200)))
                        //                                        //
                        //
                        //                                    }
                        
                        //                Text("Pantry")
                        //                    .font(.title2)
                        //                    .frame(maxWidth: .infinity, alignment: .topLeading)
                        //                    .padding()
                        //                    .padding()
                        //
                        //            Text("Recipes")
                        //                        .font(.title2)
                        //                        .padding()
                        //                        .padding()
                        
                    }
                }
            }
        }
    }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
}
//            .scrollIndicators(.hidden)
//            .toolbar {
//                ToolbarItem {
//                    Button {
//                        print("Add")
//                    } label: {
//                        Image(systemName: "pencil")
//                            .font(.title2)
//                    }
//                }
//            }
    
#Preview {
        ContentView()
    }

