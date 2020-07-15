//
//  CardView.swift
//  SetGame
//
//  Created by Sean Tai on 7/11/20.
//

import SwiftUI

struct CardView: View {
    private var card: SetGameModel.Card
    
    init(_ card: SetGameModel.Card) {
        self.card = card
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: geo.size.height * 0.05)
                    .foregroundColor(.white)
                    .opacity(0.2)
                if card.isChosen {
                    RoundedRectangle(cornerRadius: geo.size.height * 0.05)
                        .stroke(lineWidth: geo.size.height * 0.02)
                        .padding(geo.size.height * 0.01)
                        .foregroundColor(.accentColor)
                } else if card.isHinted {
                    RoundedRectangle(cornerRadius: geo.size.height * 0.05)
                        .stroke(lineWidth: geo.size.height * 0.02)
                        .padding(geo.size.height * 0.01)
                        .foregroundColor(.red)
                } else if card.isMatched {
                    RoundedRectangle(cornerRadius: geo.size.height * 0.05)
                        .stroke(lineWidth: geo.size.height * 0.02)
                        .padding(geo.size.height * 0.01)
                        .foregroundColor(.green)
                } else {
                    RoundedRectangle(cornerRadius: geo.size.height * 0.05)
                        .stroke(lineWidth: geo.size.height * 0.01)
                        .padding(geo.size.height * 0.005)
                        .opacity(0.8)
                        .foregroundColor(.gray)
                }
                CardContent(of: card, cardHeight: geo.size.height).padding(geo.size.height * 0.025)
                VStack {
                    Text("\(geo.frame(in: CoordinateSpace.global).origin.x)")
                    Text("\(geo.frame(in: CoordinateSpace.global).origin.y)")
                }
            }.transition(.scale)
            //            .transition(.offset(x: -geo.frame(in: CoordinateSpace.global).origin.x, y: -geo.frame(in: CoordinateSpace.global).origin.y))
        }
    }
}

struct SetGameCardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(SetGameModel.Card(number: .featureC, color: .featureA, shape: .featureA, fill: .featureA)).previewLayout(.fixed(width: 300, height: 200))
        CardView(SetGameModel.Card(number: .featureC, color: .featureB, shape: .featureB, fill: .featureA)).previewLayout(.fixed(width: 300, height: 200))
        CardView(SetGameModel.Card(number: .featureC, color: .featureC, shape: .featureC, fill: .featureA)).previewLayout(.fixed(width: 300, height: 200))
        CardView(SetGameModel.Card(number: .featureA, color: .featureA, shape: .featureA, fill: .featureB)).previewLayout(.fixed(width: 300, height: 200))
        CardView(SetGameModel.Card(number: .featureB, color: .featureB, shape: .featureB, fill: .featureB)).previewLayout(.fixed(width: 300, height: 200))
        CardView(SetGameModel.Card(number: .featureC, color: .featureC, shape: .featureC, fill: .featureB)).previewLayout(.fixed(width: 300, height: 200))
    }
}
