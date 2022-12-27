//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Adriana Pineda on 10/6/21.
//

import SwiftUI

@main // main program
struct MemorizeApp: App {
    let game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
