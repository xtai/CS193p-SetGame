//
//  CardShadingView.swift
//  SetGame
//
//  Created by Sean Tai on 7/13/20.
//

import SwiftUI


struct CardShadingView<ContentView: Shape>: View {
    var content: ContentView
    var shading: SetGameModel.CardFeature
    var stroke: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                switch shading {
                case .featureA: // open
                    EmptyView()
                case .featureB: // striped
                    StripedFillShape().clipShape(content)
                case .featureC: // solid
                    content
                }
                content.stroke(lineWidth: stroke)
            }
        }
    }
}
