//
//  SetGameCardView.swift
//  SetGame
//
//  Created by Sean Tai on 7/11/20.
//

import SwiftUI

struct SetGameCardView: View {
    var card: SetGameModel.Card
    
    func getColor(_ cardColor: SetGameModel.CardColor) -> Color {
        switch cardColor {
        case .red: return .red
        case .blue: return .blue
        case .green: return .green
        }
    }
    
    func getNumber(_ cardNumber: SetGameModel.CardNumber) -> Int {
        switch cardNumber {
        case .one: return 1
        case .two: return 2
        case .three: return 3
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: geo.size.height * 0.05)
                    .foregroundColor(Color("CardBackground"))
                    .clipShape(ContainerRelativeShape())
                RoundedRectangle(cornerRadius: geo.size.height * 0.05)
                    .stroke(lineWidth: geo.size.height * 0.01)
                    .padding(geo.size.height * 0.005)
                    .foregroundColor(.gray)
                    .clipShape(ContainerRelativeShape())
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
    var shape: SetGameModel.CardShape
    var shading: SetGameModel.CardShading
    var stroke: CGFloat
    var padding: CGFloat
    var body: some View {
        switch shape {
        case .dimond:
            CardShading(content: DimondShape(), shading: shading, stroke: stroke, padding: padding)
        case .squiggle:
            CardShading(content: Rectangle(), shading: shading, stroke: stroke, padding: padding)
        case .capsule:
            CardShading(content: Capsule(), shading: shading, stroke: stroke, padding: padding)
        }
    }
}

struct CardShading<ContentView: Shape>: View {
    var content: ContentView
    var shading: SetGameModel.CardShading
    var stroke: CGFloat
    var padding: CGFloat
    var body: some View {
        Group {
            switch shading {
            case .open:
                content
                    .stroke(lineWidth: stroke)
                    .padding(padding)
            case .striped:
                content
                    .opacity(0.5)
            case .solid:
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
        SetGameCardView(card: SetGameModel.Card(number: .three, color: .blue, shape: .dimond, shading: .open))
            .previewLayout(.fixed(width: 90, height: 120))
        SetGameCardView(card: SetGameModel.Card(number: .three, color: .green, shape: .capsule, shading: .open))
            .previewLayout(.fixed(width: 150, height: 200))
        SetGameCardView(card: SetGameModel.Card(number: .three, color: .red, shape: .dimond, shading: .open))
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
