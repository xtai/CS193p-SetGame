//
//  TopActionBar.swift
//  SetGame
//
//  Created by Sean Tai on 7/15/20.
//

import SwiftUI

struct TopActionBar: View {
    @State private var showingAlert = false
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        HStack {
            Text("Set Game").font(.title2).bold().padding()
            Spacer()
            Button(action: {
                withAnimation (.easeInOut) { showingAlert = true }
            }, label: {
                HStack {
                    Image(systemName: "plus.square.on.square")
                    Text("New Game")
                }.padding()
            }).alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Start a new game?"),
                    primaryButton: .default(Text("New Game")) {
                        withAnimation (.easeInOut) { game.new() }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}
