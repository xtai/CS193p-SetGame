//
//  HStripe.swift
//  SetGame
//
//  Created by Sean Tai on 7/13/20.
//

import SwiftUI

struct HStripe: Shape {
    var stripeHeight: CGFloat = 0.5
    // a striped fill
    func path(in rect: CGRect) -> Path {
        var realStripeHeight = stripeHeight
        if realStripeHeight < 0.1 {
            realStripeHeight = 0.1
        }
        let interval = realStripeHeight * 5
        let numberOfLines = Int(floor(rect.height / interval))
        
        var p = Path()
        for i in (0...numberOfLines) {
            let startY = rect.minY + CGFloat(CGFloat(i) * interval)
            let endY = realStripeHeight + startY
            
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
        HStripe(stripeHeight: 3.0).previewLayout(.fixed(width: 360, height: 300))
    }
}
