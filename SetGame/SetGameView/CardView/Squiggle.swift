//
//  Squiggle.swift
//  SetGame
//
//  Created by Sean Tai on 7/13/20.
//
//  Squiggle Shape

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: getCGPoint(x: 0.70, y: 0.00, rect: rect))
        p.addCurve(to: getCGPoint(x: 0.05, y: 0.25, rect: rect), control1: getCGPoint(x: 0.50, y: 0.00, rect: rect), control2: getCGPoint(x: 0.05, y: 0.05, rect: rect))
        p.addCurve(to: getCGPoint(x: 0.25, y: 0.65, rect: rect), control1: getCGPoint(x: 0.05, y: 0.45, rect: rect), control2: getCGPoint(x: 0.25, y: 0.50, rect: rect))
        p.addCurve(to: getCGPoint(x: 0.00, y: 0.90, rect: rect), control1: getCGPoint(x: 0.25, y: 0.80, rect: rect), control2: getCGPoint(x: 0.00, y: 0.80, rect: rect))
        p.addCurve(to: getCGPoint(x: 0.30, y: 1.00, rect: rect), control1: getCGPoint(x: 0.00, y: 0.95, rect: rect), control2: getCGPoint(x: 0.10, y: 1.00, rect: rect))
        p.addCurve(to: getCGPoint(x: 0.95, y: 0.75, rect: rect), control1: getCGPoint(x: 0.50, y: 1.00, rect: rect), control2: getCGPoint(x: 0.95, y: 0.95, rect: rect))
        p.addCurve(to: getCGPoint(x: 0.75, y: 0.35, rect: rect), control1: getCGPoint(x: 0.95, y: 0.55, rect: rect), control2: getCGPoint(x: 0.75, y: 0.50, rect: rect))
        p.addCurve(to: getCGPoint(x: 1.00, y: 0.10, rect: rect), control1: getCGPoint(x: 0.75, y: 0.20, rect: rect), control2: getCGPoint(x: 1.00, y: 0.20, rect: rect))
        p.addCurve(to: getCGPoint(x: 0.70, y: 0.00, rect: rect), control1: getCGPoint(x: 1.00, y: 0.05, rect: rect), control2: getCGPoint(x: 0.90, y: 0.00, rect: rect))
        p.closeSubpath()
        return p
    }

    private func getCGPoint(x: Double, y: Double, rect: CGRect) -> CGPoint {
        return CGPoint(x: rect.origin.x + (CGFloat(x) * rect.size.width), y: rect.origin.y + (CGFloat(y) * rect.size.height))
    }
}

struct SquiggleShapeView_Previews: PreviewProvider {
    static var previews: some View {
        Squiggle().previewLayout(.fixed(width: 100, height: 200))
    }
}
