//
//  CardContent.swift
//  SetGame
//
//  Created by Sean Tai on 7/13/20.
//

import SwiftUI

struct CardContent: View {
    var card: SetGameModel.Card
    var height: CGFloat
    
    var body: some View {
        HStack(spacing: 0) {
            Group {
                ForEach(0..<getNumber(card.number), id: \.self) { _ in
                    renderShape().aspectRatio(0.5, contentMode: .fit)
                }
                .padding([.leading, .trailing], height * 0.056)
                .padding([.top, .bottom], height * 0.17)
            }
            .foregroundColor(getColor(card.color))
        }
    }
    
    private func getColor(_ cardColor: SetGameModel.CardFeature) -> Color {
        switch cardColor {
        case .featureA: return .blue
        case .featureB: return .red
        case .featureC: return .green
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
            case .featureA: renderShading(for: Dimond())
            case .featureB: renderShading(for: Squiggle())
            case .featureC: renderShading(for: Capsule())
            }
        }
    }
    
    private func renderShading<ContentView: Shape>(for content: ContentView) -> some View {
        ZStack {
            switch card.shading {
            case .featureA: EmptyView() // open
            case .featureB: StripedFillShape(lineHeight: height * 0.005).clipShape(content) // striped
            case .featureC: content // solid
            }
            content.stroke(lineWidth: height * 0.01) // outline for everyone
        }
    }
}
