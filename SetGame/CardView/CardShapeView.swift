//
//  CardShapeView.swift
//  SetGame
//
//  Created by Sean Tai on 7/13/20.
//

import SwiftUI

struct CardShapeView: View {
    var shape: SetGameModel.CardFeature
    var shading: SetGameModel.CardFeature
    var stroke: CGFloat

    var body: some View {
        switch shape {
        case .featureA: // .dimond:
            CardShadingView(content: DimondShape(), shading: shading, stroke: stroke)
        case .featureB: // .squiggle:
            CardShadingView(content: SquiggleShape(), shading: shading, stroke: stroke)
        case .featureC: // .capsule:
            CardShadingView(content: Capsule(), shading: shading, stroke: stroke)
        }
    }
}
