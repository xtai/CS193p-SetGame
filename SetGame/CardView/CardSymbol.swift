//
//  CardSymbol.swift
//  SetGame
//
//  Created by Sean Tai on 7/13/20.
//

import SwiftUI

struct CardSymbol: View {
    var shape: SetGameModel.CardFeature
    var shading: SetGameModel.CardFeature
    var stroke: CGFloat
    
    var body: some View {
        switch shape {
        case .featureA: // dimond
            shading(for: Dimond())
        case .featureB: // squiggle
            shading(for: Squiggle())
        case .featureC: // capsule
            shading(for: Capsule())
        }
    }
    
    // get shading
    private func shading<ContentView: Shape>(for content: ContentView) -> some View {
        ZStack {
            switch shading {
            case .featureA: // open
                EmptyView()
            case .featureB: // striped
                StripedFillShape(lineHeight: stroke / 2).clipShape(content)
            case .featureC: // solid
                content
            }
            content.stroke(lineWidth: stroke)
        }
    }
}
