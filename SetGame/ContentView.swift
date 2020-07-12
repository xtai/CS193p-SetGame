//
//  SetGameView.swift
//  SetGame
//
//  Created by Sean Tai on 7/10/20.
//

import SwiftUI

struct SetGameView: View {
    var body: some View {
        Text("Set Game").padding()
    }
}

struct CardView: View {
    var card: Card
    var body: some View {
        Text("Set Game").padding()
    }
}

struct Card {
    var number: CardNumber
    var color: CardColor
    var shape: CardShape
    var shading: CardShading
}

enum CardNumber: CaseIterable {
    case one
    case two
    case three
}

enum CardColor: CaseIterable {
    case green
    case red
    case blue
}

enum CardShape: CaseIterable {
    case dimond
    case squiggle
    case rounded
}

enum CardShading: CaseIterable {
    case solid
    case shadowy
    case empty
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}
