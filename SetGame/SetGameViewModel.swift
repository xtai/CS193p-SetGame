//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Sean Tai on 7/11/20.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published private var game = createGame()
    
    private static func createGame() -> SetGameModel {
        return SetGameModel()
    }
    
    // MARK: - Access to model
    
    var cards: Array<SetGameModel.Card> {
        return game.cards
    }
    
    var matchesInView: Int {
        return game.matchedIndices.count
    }
    
    // TODO: do not hardcoding
    var remainingCards: Int {
        return game.remainingCards
    }
    
    // MARK: - Intent(s)
    
    func new() {
        game = SetGameViewModel.createGame()
    }
    
    func deal() {
        game.dealNewCards()
    }
    
    func choose(card: SetGameModel.Card) {
        game.choose(card: card)
    }
    
    func hint() {
        game.hint()
    }
}
