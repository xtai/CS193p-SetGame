//
//  SetGameModel.swift
//  SetGame
//
//  Created by Sean Tai on 7/11/20.
//

import Foundation

struct SetGameModel {
    var cards: [Card]
    private var allCards: [Card]
    private var nextCardIndex: Int
    
    mutating func choose(card: Card) {
        print(card)
    }
    
    mutating func deal() {
        if nextCardIndex + 3 < allCards.count {
            for index in (nextCardIndex..<nextCardIndex+3) {
                cards.append(allCards[index])
            }
            nextCardIndex += 3
        }
    }
    
    init() {
        cards = Array<Card>()
        allCards = Array<Card>()
        nextCardIndex = 12
        for number in CardNumber.allCases {
            for color in CardColor.allCases {
                for shape in CardShape.allCases {
                    for shading in CardShading.allCases {
                        allCards.append(Card(number: number, color: color, shape: shape, shading: shading))
                    }
                }
            }
        }
        allCards.shuffle()
        cards = Array(allCards[0..<nextCardIndex])
    }
    
    struct Card: Identifiable {
        var number: CardNumber
        var color: CardColor
        var shape: CardShape
        var shading: CardShading
        var id = UUID()
    }
    
    enum CardNumber: CaseIterable {
        case one, two, three
    }
    
    enum CardColor: CaseIterable {
        case green, red, blue
    }
    
    enum CardShape: CaseIterable {
        case dimond, squiggle, capsule
    }
    
    enum CardShading: CaseIterable {
        case solid, striped, open
    }
}
