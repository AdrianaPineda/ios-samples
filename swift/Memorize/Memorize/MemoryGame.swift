//
//  MemoryGame.swift
//  Memorize
//
//  Created by Adriana Pineda on 10/25/22.
//

import Foundation

// Model
struct MemoryGame<CardContent> {

    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = true
        var content: CardContent

        var id: Int
    }

    private (set) var cards: Array<MemoryGame.Card>

    mutating func choose(card: MemoryGame.Card) {
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
        print("chosenCard = \(cards[chosenIndex])")
        print("cards = \(cards)")
    }

    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }

        return 0
    }

    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
}
