//
//  StripedFillShape.swift
//  SetGame
//
//  Created by Sean Tai on 7/13/20.
//

import SwiftUI

struct StripedFillShape: Shape {
    var lineHeight: CGFloat = 0.5
    // a striped fill
    func path(in rect: CGRect) -> Path {
        let gap = lineHeight * 5
        let numberOfLines: Int = Int(floor(rect.height / (gap + lineHeight)))
        
        var p = Path()
        for i in (0...numberOfLines) {
            let startY = rect.minY + CGFloat(CGFloat(i) * (gap + lineHeight))
            let endY = lineHeight + startY
            
            p.move(to: CGPoint(x: rect.minX, y: startY))
            p.addLine(to: CGPoint(x: rect.minX, y: endY))
            p.addLine(to: CGPoint(x: rect.maxX, y: endY))
            p.addLine(to: CGPoint(x: rect.maxX, y: startY))
            p.closeSubpath()
        }
        return p
    }
}

struct CardShadingView_Previews: PreviewProvider {
    static var previews: some View {
        StripedFillShape(lineHeight: 3.0).previewLayout(.fixed(width: 360, height: 300))
    }
}
