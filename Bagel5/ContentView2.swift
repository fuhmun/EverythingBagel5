//
//  ContentView.swift
//  Bagel5
//
//  Created by Fahad Munawar on 1/18/24.
//


import SwiftUI

//struct MacroView: View {
//
struct ContentView2: View {
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color(CustomColor.lightGreen)
                        .ignoresSafeArea(.all)
                    VStack {
                        HStack {
                            Text("Pantry")
                                .font(.custom("SF-Pro", size: 40))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            NavigationLink(
                                destination: FavoritesPage(),
                                label: {
                                    Label("", systemImage: "bookmark.circle")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            )
                        }
                        .padding(30)
                        VStack {
                            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                .foregroundColor(CustomColor.background)
                                .padding(30)
                        }
                        
                    }
                }
                ZStack {
                    Color(CustomColor.background)
                        .ignoresSafeArea(.all)
                }
            }
            
            
        }
    }
}

        

#Preview {
    ContentView2()
}
