//
//  SetGameApp.swift
//  SetGame
//
//  Created by Sean Tai on 7/10/20.
//

import SwiftUI

@main
struct SetGameApp: App {
    var body: some Scene {
        WindowGroup {
            Home(game: SetGameViewModel())
        }
    }
}
