//
//  CardContent.swift
//  SetGame
//
//  Created by Sean Tai on 7/13/20.
//

import SwiftUI

struct CardContent: View {
    var card: SetGameModel.Card
    var cardHeight: CGFloat
    
    init(of card: SetGameModel.Card, cardHeight: CGFloat) {
        self.card = card
        self.cardHeight = cardHeight
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<getNumber(card.number), id: \.self) { _ in
                renderShape().aspectRatio(symbolAspectRatio, contentMode: .fit)
            }
            .padding([.leading, .trailing], size(of: paddingH))
            .padding([.top, .bottom], size(of: paddingV))
        }.foregroundColor(getColor(card.color))
    }
    
    private func getColor(_ cardColor: SetGameModel.CardFeature) -> Color {
        switch cardColor {
        case .featureA: return .green
        case .featureB: return .red
        case .featureC: return .purple
        }
    }
    
    private func getNumber(_ cardNumber: SetGameModel.CardFeature) -> Int {
        switch cardNumber {
        case .featureA: return 1
        case .featureB: return 2
        case .featureC: return 3
        }
    }
    
    private func renderShape() -> some View {
        Group {
            switch card.shape {
            case .featureA: renderFilling(){ Dimond() }
            case .featureB: renderFilling(){ Squiggle() }
            case .featureC: renderFilling(){ Capsule() }
            }
        }
    }
    
    private func renderFilling<ContentView: Shape>(@ViewBuilder for content: @escaping () -> ContentView) -> some View {
        ZStack {
            switch card.fill {
            case .featureA: EmptyView() // open
            case .featureB: HStripe(stripeSize: size(of: stripeSize)).clipShape(content()) // striped
            case .featureC: content() // solid
            }
            content().stroke(lineWidth: size(of: outline)) // outline for everyone
        }
    }
    
    // MARK: - Drawing Constants
    private func size(of constant: CGFloat) -> CGFloat {
        return constant * cardHeight
    }
    private let symbolAspectRatio: CGFloat = 0.5
    private let paddingH: CGFloat = 0.056
    private let paddingV: CGFloat = 0.17
    private let stripeSize: CGFloat = 0.01
    private let outline: CGFloat = 0.02
}
