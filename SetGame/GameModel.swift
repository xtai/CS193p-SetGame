//
//  GameModel.swift
//  SetGame
//
//  Created by Sean Tai on 7/14/20.
//

import Foundation

struct GameModel {
    // MARK: - User Accessible Variables
    // playing cards
    private(set) var cards: [Card] = Array<Card>()
    var remainingCardCount: Int {
        get { allCards.count - nextPlayingCardIndex }
    }
    
    private var allCards: [Card] = []
    
    private var nextPlayingCardIndex: Int = 0
    private var freshCardIndices: [Int] = []
    private var playingCardIndices: [Int] = []
    private var matchedCardIndices: [Int] = []
    
    private var chosenCardIndices: [Int] = []
    private var wrongSetCardIndices: [Int] = []
    private var hintedCardIndices: [Int] = []
    
    var potentialSetIndices: [[Int]]  = [[]]
    
    // MARK: - New Game
    init() {
        for number in CardFeature.allCases {
            for color in CardFeature.allCases {
                for shape in CardFeature.allCases {
                    for fill in CardFeature.allCases {
                        allCards.append(Card(number: number, color: color, shape: shape, fill: fill))
                    }
                }
            }
        }
        cards.shuffle()
        for i in (0..<allCards.count) {
            freshCardIndices.append(i)
        }
    }
    
    // MARK: - User Intents
    mutating func choose(card: Card) {
        // reset wrong sets upon any interaction
        resetWrongSet()
        
        let chosenCardIndex = cards.firstIndex(matching: card)!
        cards[chosenCardIndex].isChosen.toggle()
        
        // if the card is now chosen
        if (cards[chosenCardIndex].isChosen) {
            // matching card state
            chosenCardIndices.append(chosenCardIndex)
            
            // See if it is a match
            if (chosenCardIndices.count == 3) {
                
                // reset the hint upon 3 chosen cards regardless of match
                resetHintedSet()

                if (isMatch(cardA: cards[chosenCardIndices[0]], cardB: cards[chosenCardIndices[1]], cardC: cards[chosenCardIndices[2]])) {
                    // is a match
                    for index in chosenCardIndices {
                        cards[index].state = .matched
                        playingCardIndices.remove(at: playingCardIndices.firstIndex(of: index)!)
                        matchedCardIndices.append(index)
                    }
                } else {
                    // not a match
                    for index in chosenCardIndices {
                        cards[index].isChosen = false
                        cards[index].isWrongSet = true
                    }
                    wrongSetCardIndices = chosenCardIndices
                    chosenCardIndices.removeAll()
                }
            }
        } else {
            // matching card state
            chosenCardIndices.remove(at: chosenCardIndex)
        }
    }
    
    // TODO: deal
    mutating func deal() {
        
    }
    
    // TODO: hint
    mutating func hint() {
        
    }
    
    // MARK: - Supporting Funcs - Reset Card States
    
    mutating func resetWrongSet() {
        for index in wrongSetCardIndices {
            cards[index].isWrongSet = false
        }
        wrongSetCardIndices.removeAll()
    }
    
    mutating func resetHintedSet() {
        for index in hintedCardIndices {
            cards[index].isHinted = false
        }
        hintedCardIndices.removeAll()
    }
    
    // MARK: - Supporting Funcs - Hints
    
    // Find all potential sets in view
    // Complexity O(n^3)
    private func findAllSetIndices() -> Array<Array<Int>> {
        print("findAllSetIndices")
        var matchSets = Array<Array<Int>>()
        let count = playingCardIndices.count
        guard count >= 3 else { return matchSets }
        for a in (0..<(count - 2)) {
            for b in ((a + 1)..<(count - 1)) {
                for c in ((b + 1)..<count) {
                    if (isMatch(cardA: cards[a], cardB: cards[b], cardC: cards[c])) {
                        matchSets.append([a, b, c])
                    }
                }
            }
        }
        return matchSets
    }
    
    // MARK: - Supporting Funcs - Matching Set
    
    // Return true if given three cards are a set
    private func isMatch(cardA: Card, cardB: Card, cardC: Card) -> Bool {
        if !isSet([cardA.number, cardB.number, cardC.number]) { return false }
        if !isSet([cardA.color, cardB.color, cardC.color]) { return false }
        if !isSet([cardA.shape, cardB.shape, cardC.shape]) { return false }
        if !isSet([cardA.fill, cardB.fill, cardC.fill]) { return false }
        return true
    }
    
    // Return true if given three features are a set
    private func isSet(_ features: Array<CardFeature>) -> Bool {
        var a = 0, b = 0, c = 0
        for feature in features {
            switch feature {
            case .featureA: a += 1
            case .featureB: b += 1
            case .featureC: c += 1
            }
        }
        return !(a == 2 || b == 2 || c == 2)
    }
    
    // MARK: - Struct and Enum
    
    struct Card: Identifiable {
        var id = UUID()
        
        var number: CardFeature
        var color: CardFeature
        var shape: CardFeature
        var fill: CardFeature
        
        // Source of truth
        var state: CardState = .fresh
        
        // In the view highlights
        var isWrongSet: Bool = false
        var isChosen: Bool = false
        var isHinted: Bool = false
    }
    
    // Card lifecycle fresh -> playing -> matched
    enum CardState: Equatable {
        case fresh, playing, matched
    }

    // Three card features for each category: number, color, shape, or fill style
    enum CardFeature: CaseIterable {
        case featureA, featureB, featureC
    }
}
