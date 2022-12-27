//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Adriana Pineda on 10/25/22.
//

import SwiftUI

// ViewModel
// ObservableObject: can publish that something changed. The class gets an `objectWillChange` property
class EmojiMemoryGame: ObservableObject {
    static let emojis = ["🚕", "🚃", "🛵", "🚂", "🚄", "🚅", "🚆", "🚇", "🚈", "🚉", "🚊", "🚝", "🚞", "🚋", "🚌", "🚍", "🚎", "🚐", "🚑", "🚒", "🚓", "🚔", "🚖", "🚗", "🚘", "🚙", "🛻", "🚚", "🚛", "🚜"]

    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }

    @Published private var model: MemoryGame<String> = createMemoryGame() // anytime the model changes, it will call `objectWillChange.send()`

    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }

    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
//        objectWillChange.send()
        model.choose(card: card)
    }
}
