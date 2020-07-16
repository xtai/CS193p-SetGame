//
//  BottomActionBar.swift
//  SetGame
//
//  Created by Sean Tai on 7/15/20.
//

import SwiftUI

struct BottomActionBar: View {
    @ObservedObject var game: SetGameViewModel
    var geometry: GeometryProxy
    
    @ViewBuilder
    private func getHintText() -> some View {
        if (geometry.size.width >= CGFloat(375.0)) {
            if (game.matchesInView == 0) {
                Text("Hint")
            } else {
                Text("Hint (\(game.matchesInView))")
            }
        } else {
            EmptyView()
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation (.easeInOut) { game.hint() }
                }) {
                    HStack {
                        Image(systemName: "questionmark.diamond.fill")
                        getHintText()
                    }.padding()
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(10.0)
                }.disabled(game.hintDisabled)
                Button(action: {
                    withAnimation (.easeInOut) { game.deal() }
                }) {
                    Label("Deal Cards (\(game.remainingCards))", systemImage: "die.face.3.fill")
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(buttonRadius)
                }.disabled(game.dealDisabled)
            }.padding([.top, .leading, .trailing])
        }
    }
    
    // MARK: - Drawing Constants
    private let buttonRadius: CGFloat = 10.0
}
