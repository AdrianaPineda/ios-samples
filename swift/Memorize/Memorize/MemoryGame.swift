//
//  MemoryGame.swift
//  Memorize
//
//  Created by Adriana Pineda on 10/25/22.
//

import Foundation

// Model
struct MemoryGame<CardContent> {

    struct Card {
        let isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }

    private (set) var cards: Array<MemoryGame.Card>

    func choose(card: MemoryGame.Card) {

    }

    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
}
