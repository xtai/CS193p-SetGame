//
//  SetGameCardView.swift
//  SetGame
//
//  Created by Sean Tai on 7/11/20.
//

import SwiftUI

struct SetGameCardView: View {
    var card: SetGameModel.Card
    
    func getColor(_ cardColor: SetGameModel.CardFeature) -> Color {
        switch cardColor {
        case .featureA: return .red
        case .featureB: return .blue
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
                VStack(spacing: 0) {
                    Group {
                        ForEach(0..<getNumber(card.number), id: \.self) { _ in
                            CardShapeView(shape: card.shape, shading: card.shading, stroke: geo.size.height * 0.01, padding: geo.size.height * 0.02)
                                .aspectRatio(4, contentMode: .fit)
                        }
                        .padding([.leading, .trailing], geo.size.height * 0.1)
                        .padding([.top, .bottom], geo.size.height * 0.02)
                    }
                    .foregroundColor(getColor(card.color))
                }
            }
        }.aspectRatio((5/6), contentMode: .fit)
    }
}

struct CardShapeView: View {
    var shape: SetGameModel.CardFeature
    var shading: SetGameModel.CardFeature
    var stroke: CGFloat
    var padding: CGFloat
    var body: some View {
        switch shape {
        case .featureA: // .dimond:
            CardShading(content: DimondShape(), shading: shading, stroke: stroke, padding: padding)
        case .featureB: // .squiggle:
            CardShading(content: Rectangle(), shading: shading, stroke: stroke, padding: padding)
        case .featureC: // .capsule:
            CardShading(content: Capsule(), shading: shading, stroke: stroke, padding: padding)
        }
    }
}

struct CardShading<ContentView: Shape>: View {
    var content: ContentView
    var shading: SetGameModel.CardFeature
    var stroke: CGFloat
    var padding: CGFloat
    var body: some View {
        Group {
            switch shading {
            case .featureA: // .open:
                content
                    .stroke(lineWidth: stroke)
                    .padding(padding)
            case .featureB: // .striped:
                content
                    .opacity(0.25)
            case .featureC: // .solid:
                content
            }
        }
    }
}

struct DimondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        p.closeSubpath()
        return p
    }
}

struct SetGameCardView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameCardView(card: SetGameModel.Card(number: .featureC, color: .featureA, shape: .featureC, shading: .featureA))
            .previewLayout(.fixed(width: 90, height: 120))
        SetGameCardView(card: SetGameModel.Card(number: .featureC, color: .featureB, shape: .featureA, shading: .featureA))
            .previewLayout(.fixed(width: 150, height: 200))
        SetGameCardView(card: SetGameModel.Card(number: .featureC, color: .featureC, shape: .featureC, shading: .featureA))
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
