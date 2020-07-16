//
//  CardView.swift
//  SetGame
//
//  Created by Sean Tai on 7/11/20.
//

import SwiftUI

struct CardView: View {
    private var card: SetGameModel.Card
    
    // MARK: - Drawing Constants
    private let cardCornerRadius: CGFloat = 0.05
    private let cardStrokeSizeDefault: CGFloat = 0.01
    private let cardStrokeSizeChosen: CGFloat = 0.02
    private let cardPadding: CGFloat = 0.005
    private let cardContentPadding: CGFloat = 0.025
    private let cardOpacity: Double = 0.05
    
    init(_ card: SetGameModel.Card) {
        self.card = card
    }
    
    // converting constant to CGFloat with relative card height
    private func size(of item: CGFloat, geo: GeometryProxy) -> CGFloat {
        return geo.size.height * item
    }
    
    var body: some View {
        Group {
            if (card.state == .playing) {
                GeometryReader { geo in
                    ZStack {
                        // default card background
                        RoundedRectangle(cornerRadius: size(of: cardCornerRadius, geo: geo))
                            .foregroundColor(Color(UIColor.tertiarySystemBackground))
                        RoundedRectangle(cornerRadius: size(of: cardCornerRadius, geo: geo))
                            .stroke(lineWidth: size(of: cardStrokeSizeDefault, geo: geo))
                            .padding(size(of: (cardStrokeSizeDefault / 2), geo: geo))
                            .foregroundColor(Color(UIColor.separator))
                        
                        // hinted card border
                        if card.isHinted {
                            RoundedRectangle(cornerRadius: size(of: cardCornerRadius, geo: geo))
                                .stroke(lineWidth: size(of: cardStrokeSizeChosen, geo: geo))
                                .padding(size(of: (cardStrokeSizeChosen / 2), geo: geo))
                                .foregroundColor(.blue)
                        }

                        // chosen card border
                        if card.isChosen {
                            RoundedRectangle(cornerRadius: size(of: cardCornerRadius, geo: geo))
                                .stroke(lineWidth: size(of: cardStrokeSizeChosen, geo: geo))
                                .padding(size(of: (cardStrokeSizeChosen / 2), geo: geo))
                                .foregroundColor(.orange)
                        }
                        
                        // chosen a wrong set border and a background
                        if card.isWrongSet {
                            Group {
                                RoundedRectangle(cornerRadius: size(of: cardCornerRadius, geo: geo))
                                    .opacity(cardOpacity)
                                RoundedRectangle(cornerRadius: size(of: cardCornerRadius, geo: geo))
                                    .stroke(lineWidth: size(of: cardStrokeSizeChosen, geo: geo))
                                    .padding(size(of: (cardStrokeSizeChosen / 2), geo: geo))
                            }.foregroundColor(.red)
                        }
                        
                        // card content
                        CardContent(of: card, cardHeight: geo.size.height)
                            .padding(size(of: cardContentPadding, geo: geo))
                    }
                }
            }
        }
    }
}

struct SetGameCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(SetGameModel.Card(number: .featureC, color: .featureA, shape: .featureA, fill: .featureA)).preferredColorScheme(.dark).previewLayout(.fixed(width: 300, height: 200))
            CardView(SetGameModel.Card(number: .featureC, color: .featureB, shape: .featureB, fill: .featureA)).preferredColorScheme(.dark).previewLayout(.fixed(width: 300, height: 200))
            CardView(SetGameModel.Card(number: .featureC, color: .featureC, shape: .featureC, fill: .featureA)).previewLayout(.fixed(width: 300, height: 200))
            CardView(SetGameModel.Card(number: .featureA, color: .featureA, shape: .featureA, fill: .featureB)).previewLayout(.fixed(width: 300, height: 200))
            CardView(SetGameModel.Card(number: .featureB, color: .featureB, shape: .featureB, fill: .featureB)).previewLayout(.fixed(width: 300, height: 200))
            CardView(SetGameModel.Card(number: .featureC, color: .featureC, shape: .featureC, fill: .featureB)).previewLayout(.fixed(width: 300, height: 200))
        }
    }
}
