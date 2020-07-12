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
        VStack {
            HStack {
                Text("Set Game").font(.title)
                Spacer()
                Button(action: {withAnimation (.easeInOut) {
                        game.deal()
                    }
                }, label: {
                    Text("Deal 3 Cards")
                })
                Button(action: {withAnimation (.easeInOut) {
                        game.new()
                    }
                }, label: {
                    Text("New Game")
                })
            }.padding()
            SetGameCardGrid(game.cards) { card in
                SetGameCardView(card: card).onTapGesture {
                    withAnimation (.linear) {
                        game.choose(card: card)
                    }
                }
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
