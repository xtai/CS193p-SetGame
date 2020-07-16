//
//  SetGameApp.swift
//  SetGame
//
//  Created by Sean Tai on 7/10/20.
//

import SwiftUI

@main
struct SetGameApp: App {
    @StateObject private var game = SetGameViewModel()

    var body: some Scene {
        WindowGroup {
            SetGameHome(game: game)
        }
    }
}
