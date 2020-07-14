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
        case .featureA: // .dimond:
            ItemShadingView(content: DimondShape(), shading: shading, stroke: stroke)
        case .featureB: // .squiggle:
            ItemShadingView(content: SquiggleShape(), shading: shading, stroke: stroke)
        case .featureC: // .capsule:
            ItemShadingView(content: Capsule(), shading: shading, stroke: stroke)
        }
    }
}
