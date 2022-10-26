//
//  MemoryGame.swift
//  Memorize
//
//  Created by Adriana Pineda on 10/25/22.
//

import Foundation

struct MemoryGame<CardContent> {

    struct Card {
        let isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }

    var cards: Array<MemoryGame.Card>

    func choose(card: MemoryGame.Card) {

    }
}
