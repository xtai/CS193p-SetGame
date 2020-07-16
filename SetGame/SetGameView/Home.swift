//
//  Home.swift
//  SetGame
//
//  Created by Sean Tai on 7/10/20.
//

import SwiftUI

struct Home: View {
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        ZStack {
            Color.accentColor.opacity(backgroundOpacity).edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    TopActionBar(game: game)
                    CardGirdHelper(game.cards, itemsCount: game.playingCardCount, itemRatio: cardRatio) { card in
                        GeometryReader { cardGeometry in
                            Button(action: {
                                withAnimation (.easeInOut) { game.choose(card: card) }
                            }) {
                                CardView(card).transition(.offset(
                                    x: ((geometry.size.width / 2) - (cardGeometry.size.width / 2) - cardGeometry.frame(in: CoordinateSpace.global).origin.x),
                                    y: insertAnimationYOffest - geometry.size.height
                                ))
                            }
                        }.aspectRatio(cardRatio, contentMode: .fit)
                        .transition(AnyTransition.asymmetric(insertion: .offset(x: 0, y: -geometry.size.height), removal: .offset(x: 0, y: geometry.size.height)))
                        .animation(.easeInOut(duration: animationDuration))
                    }.padding([.leading, .trailing])
                    BottomActionBar(game: game, geometry: geometry)
                }
            }
        }
    }
    
    // MARK: - Drawing Constants
    private let backgroundOpacity: Double = 0.05
    private let cardRatio: CGFloat = 1.5
    private let insertAnimationYOffest: CGFloat = -100
    private let animationDuration: Double = 0.5
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home(game: SetGameViewModel()).previewDevice("iPhone 11")
        }
    }
}
