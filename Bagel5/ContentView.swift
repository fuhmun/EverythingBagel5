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
    
    var body: some View {
        NavigationStack{
            VStack {
                ZStack {
                    Color(CustomColor.lightGreen)
                        .ignoresSafeArea(.all)
                    HStack {
                        Text("Pantry")
                            .font(.title)
                            .multilineTextAlignment(.leading)
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "bookmark.circle")
                                .font(.title)
                                .multilineTextAlignment(.trailing)
                        })
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
    ContentView()
}
