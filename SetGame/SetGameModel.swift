//
//  SetGameModel.swift
//  SetGame
//
//  Created by Sean Tai on 7/11/20.
//

import Foundation

struct SetGameModel {
    private(set) var cards: [Card]
    private(set) var matchedIndices: [[Int]] = [[]]
    private(set) var nextCardIndex: Int
    
    var remainingCards: Int {
        get {
            81 - nextCardIndex
        }
    }
    
    // TODO: find a better solution here for matched card and in view cards
    private var allCards: [Card]
    private var choosenCards: [Card]
    private var hintedCardSetIndex: Int?
    
    // choose a card
    mutating func choose(card: Card) {
        // if we have 3 choosen cards before, deselect all cards before choose the new card
        unhintAllCards()
        if choosenCards.count == 3 {
            for card in choosenCards {
                cards[cards.firstIndex(matching: card)!].isSelected = false
            }
            choosenCards = Array<Card>()
        }
        
        // find the choosen card index in current cards
        let indexOfSelectedCard = cards.firstIndex(matching: card)!
        
        // if the choosen card is not selected
        if !cards[indexOfSelectedCard].isSelected {
            // mark the card selected
            choosenCards.append(card)
            
            // toggle the card select state
            cards[indexOfSelectedCard].isSelected.toggle()
            
            // if the choosen card is the third choosen card
            if choosenCards.count == 3 {
                print("Is it a match? \(isMatch(cardA: choosenCards[0], cardB: choosenCards[1], cardC: choosenCards[2]))")
                if isMatch(cardA: choosenCards[0], cardB: choosenCards[1], cardC: choosenCards[2]) {
                    saveMatchedCard(matchedCards: choosenCards)
                    choosenCards = Array<Card>()
                }
            }
        } else {
            choosenCards.remove(at: choosenCards.firstIndex(matching: card)!)
            // toggle the card select state
            cards[indexOfSelectedCard].isSelected.toggle()
        }
    }
    
    // TODO: mark instead of remove matched cards
    private mutating func saveMatchedCard(matchedCards: [Card]) {
        if (cards.count == 3) {
            print("Finished Game")
        }
        for card in matchedCards {
            if cards[cards.firstIndex(matching: card)!].isHinted {
                cards[cards.firstIndex(matching: card)!].isHinted = false
            }
            // if more cards to deal and current deck will be less than 12 cards, replace matched card with new card
            if nextCardIndex < allCards.count && cards.count == 12 {
                cards[cards.firstIndex(matching: card)!] = allCards[nextCardIndex]
                nextCardIndex += 1
            } else {
                cards.remove(at: cards.firstIndex(matching: card)!)
            }
        }
        matchedIndices = findMatchIndices()
        print("matched \(cards.count)")
    }
    
    mutating func dealNewCards() {
        if nextCardIndex + 2 < allCards.count {
            for index in (nextCardIndex..<nextCardIndex+3) {
                cards.append(allCards[index])
            }
            nextCardIndex += 3
        }
        matchedIndices = findMatchIndices()
        print("deal \(cards.count)")
    }
    
    private func isMatch(cardA: Card, cardB: Card, cardC: Card) -> Bool {
        if !isASet(a: cardA.number, b: cardB.number, c: cardC.number) {
            return false
        } else if !isASet(a: cardA.color, b: cardB.color, c: cardC.color) {
            return false
        } else if !isASet(a: cardA.shape, b: cardB.shape, c: cardC.shape) {
            return false
        } else if !isASet(a: cardA.fill, b: cardB.fill, c: cardC.fill) {
            return false
        } else {
            return true
        }
    }
    
    mutating func unhintAllCards() {
        for set in matchedIndices {
            for cardIndex in set {
                cards[cardIndex].isHinted = false
            }
        }
    }
    
    // FIXME: to have better hints iterator, using a closure?
    mutating func hint() {
        if matchedIndices.count > 0 {
            unhintAllCards()
            switch hintedCardSetIndex {
            case .none: hintedCardSetIndex = 0
            case .some(let data):
                if (data + 1 >= matchedIndices.count){
                    hintedCardSetIndex = 0
                } else {
                    hintedCardSetIndex = data + 1
                }
            }
            let hintPairs = matchedIndices[hintedCardSetIndex!]
            for cardIndex in hintPairs {
                cards[cardIndex].isHinted = true
            }
        } else {
            hintedCardSetIndex = nil
        }
    }
    
    // FIXME: find a more effiectent algorithm here
    private mutating func findMatchIndices() -> Array<Array<Int>> {
        hintedCardSetIndex = nil
        var matchSets = Array<Array<Int>>()
        let count = cards.count
        // TODO: read more what's guard?
        guard count >= 3 else { return matchSets }
        for indexA in (0..<(count - 2)) {
            for indexB in ((indexA + 1)..<(count - 1)) {
                for indexC in ((indexB + 1)..<count) {
                    if (isMatch(cardA: cards[indexA], cardB: cards[indexB], cardC: cards[indexC])) {
                        matchSets.append([indexA, indexB, indexC])
                    }
                }
            }
        }
        while matchSets.count == 0 {
            dealNewCards()
            if (nextCardIndex >= allCards.count) {
                break
            }
        }
        return matchSets
    }
    
    private func isASet(a: CardFeature, b: CardFeature, c: CardFeature) -> Bool {
        let types = [a, b, c]
        var a = 0, b = 0, c = 0
        for type in types {
            switch type {
            case .featureA: a += 1
            case .featureB: b += 1
            case .featureC: c += 1
            }
        }
        if (a == 2 || b == 2 || c == 2) {
            return false
        } else {
            return true
        }
    }
    
    init() {
        cards = Array<Card>()
        allCards = Array<Card>()
        choosenCards = Array<Card>()
        nextCardIndex = 12
        for number in CardFeature.allCases {
            for color in CardFeature.allCases {
                for shape in CardFeature.allCases {
                    for fill in CardFeature.allCases {
                        allCards.append(Card(number: number, color: color, shape: shape, fill: fill))
                    }
                }
            }
        }
        allCards.shuffle()
        cards = Array(allCards[0..<nextCardIndex])
        matchedIndices = findMatchIndices()
        print("new \(cards.count)")
    }
    
    struct Card: Identifiable {
        var number: CardFeature
        var color: CardFeature
        var shape: CardFeature
        var fill: CardFeature
        var id = UUID()
        var isMatched: Bool = false
        var isSelected: Bool = false
        var isHinted: Bool = false
        var isFaceUp: Bool = true
    }
    
    enum CardFeature: CaseIterable {
        case featureA, featureB, featureC
    }
}
