//
//  RecipesItemView.swift
//  Bagel5
//
//  Created by Lizmary Fernandez on 1/31/24.
//

import Foundation


//  RecipesItemView.swift
//  Macro Tracker
//
//  Created by Lizmary Fernandez on 1/30/24.



//  MacroItemView.swift
//  Macro Tracker
//
//  Created by Lizmary Fernandez on 1/29/24.


import SwiftUI

struct RecipesItemView: View {
    @Binding var lowCarb: String
    @Binding var balancedMeal: String
    @Binding var highProtein: String
    
    var body: some View {
        HStack {
            HStack {
                
                Spacer()
                VStack {
                    Text("Breakfast: Overnight Oats")
                        .font(.title3)
                        .bold()
                        .padding()
                    Text("⏱️ Time: 5 minutes")
                    Text("Carbs: 30g")
                    Text("Protein: 7g")
                    Text("Fat: 15g")
                        .font(.title3)
                    
                    //
                    //
                    
                    //                        Text("\(carbs) g")
                    //                            .font(.subheadline)
                        .frame(width: 200)
                }
                .padding(70)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.blue.opacity(0.3))
                )
                
                Spacer()
                
                VStack {
                    Text("Grilled Chicken and Cheese Sandwich")
                        .font(.title3)
                        .bold()
                        .padding()
                    Text("⏱️ Time: 20 minutes")
                    Text("🥖 Carbs: 30g")
                    Text("🍗 Protein: 25g")
                    Text("🥑 Fat: 18g")
                    //                                .font(.title3)
                    //                            .padding()
                    
                    
                        .frame(width: 200)
                }
                .padding(75)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.blue.opacity(0.3))
                )
                
                Spacer()
                
                //                    VStack {
                //
                ////                            .padding()
                //                        Text("Baked Salmon with Mashed Potatoes and Steamed Broccoli")
                //                                .padding()
                //                            .font(.title3)
                //                            .bold()
                //                            Text ("Time: 20 minutes, Carbs: 25g, Protein: 30g, Fat: 15g")
                //                        Text("⏱️ Time: 20 minutes")
                //                        Text("🥖 Carbs: 25g")
                //                        Text("🍗 Protein: 30g")
                //                        Text("🥑 Fat: 15g")
                //
                //
                //                            .frame(width: 200)
                //                    }
                //                    .padding(70)
                //                    .background(
                //                        RoundedRectangle(cornerRadius: 12)
                //                            .fill(.blue.opacity(0.3))
                //                    )
                //                }
                
                
            }
        }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
    
    #Preview {
        
        RecipesItemView(lowCarb: .constant(""), balancedMeal: .constant(""), highProtein: .constant(""))
    }
