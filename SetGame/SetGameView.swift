//
//  SetGameView.swift
//  SetGame
//
//  Created by Sean Tai on 7/10/20.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        VStack{
            TopActionBar(game: game).padding()
            SetGameCardGrid(game.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation (.linear) {
                        game.choose(card: card)
                    }
                }
            }
            BottomActionBar(game: game).padding()
        }
    }
}

struct BottomActionBar: View {
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Label("\(game.matchesInView)", systemImage: "rectangle.3.offgrid")
                Label("\(game.remainingCards)", systemImage: "square.stack")
                Spacer()
                Button(action: {
                    withAnimation (.easeInOut) {
                        game.deal()
                    }
                }, label: {
                    Label("Deal Cards", systemImage: "die.face.3")
                }).padding(.trailing, 10)
                Button(action: {
                    withAnimation (.easeInOut) {
                        game.hint()
                    }
                }, label: {
                    Label("Hint", systemImage: "questionmark.diamond")
                })
            }
        }
    }
}

struct TopActionBar: View {
    @State private var showingAlert = false
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation (.easeInOut) {
                    game.deal()
                }
            }, label: {
                Image(systemName: "person.2")
            })
            Text("Set Game").font(.title).bold()
            Spacer()
            Button(action: {
                withAnimation (.easeInOut) {
                    showingAlert = true
                }
            }, label: {
                Label("New Game", systemImage: "plus.rectangle.on.rectangle")
            }).alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Start a new game?"),
                    primaryButton: .default(Text("New Game")) {
                        game.new()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SetGameView(game: SetGameViewModel())
                .previewDevice("iPhone 11")
            SetGameView(game: SetGameViewModel())
                .previewDevice("iPhone SE (1st generation)")
            SetGameView(game: SetGameViewModel())
                .previewDevice("iPad Pro (12.9-inch) (4th generation)")
        }
    }
}
