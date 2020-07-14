//
//  CardView.swift
//  SetGame
//
//  Created by Sean Tai on 7/11/20.
//

import SwiftUI

struct CardView: View {
    var card: SetGameModel.Card
    
    func getColor(_ cardColor: SetGameModel.CardFeature) -> Color {
        switch cardColor {
        case .featureA: return .blue
        case .featureB: return .red
        case .featureC: return .green
        }
    }
    
    func getNumber(_ cardNumber: SetGameModel.CardFeature) -> Int {
        switch cardNumber {
        case .featureA: return 1
        case .featureB: return 2
        case .featureC: return 3
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: geo.size.height * 0.05)
                    .foregroundColor(.white)
                    .opacity(0.2)
                if card.isSelected {
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
                HStack(spacing: 0) {
                    Group {
                        ForEach(0..<getNumber(card.number), id: \.self) { _ in
                            CardShapeView(shape: card.shape, shading: card.shading, stroke: geo.size.height * 0.01)
                                .aspectRatio(0.5, contentMode: .fit)
                        }
                        .padding([.leading, .trailing], geo.size.height * 0.056)
                        .padding([.top, .bottom], geo.size.height * 0.17)
                    }
                    .foregroundColor(getColor(card.color))
                }
            }
        }.aspectRatio(1.5, contentMode: .fit)
    }
}

struct SetGameCardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: SetGameModel.Card(number: .featureC, color: .featureA, shape: .featureA, shading: .featureA))
            .previewLayout(.fixed(width: 300, height: 200))
        CardView(card: SetGameModel.Card(number: .featureC, color: .featureB, shape: .featureB, shading: .featureA))
            .previewLayout(.fixed(width: 300, height: 200))
        CardView(card: SetGameModel.Card(number: .featureC, color: .featureC, shape: .featureC, shading: .featureA))
            .previewLayout(.fixed(width: 300, height: 200))
        CardView(card: SetGameModel.Card(number: .featureA, color: .featureA, shape: .featureA, shading: .featureB))
            .previewLayout(.fixed(width: 300, height: 200))
        CardView(card: SetGameModel.Card(number: .featureB, color: .featureB, shape: .featureB, shading: .featureB))
            .previewLayout(.fixed(width: 300, height: 200))
        CardView(card: SetGameModel.Card(number: .featureC, color: .featureC, shape: .featureC, shading: .featureB))
            .previewLayout(.fixed(width: 300, height: 200))
    }
}
