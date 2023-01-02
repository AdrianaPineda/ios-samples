//
//  MemoryGame.swift
//  Memorize
//
//  Created by Adriana Pineda on 10/25/22.
//

import Foundation

// Model
struct MemoryGame<CardContent> where CardContent: Equatable {

    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var seen: Bool = false
        var content: CardContent

        var id: Int
    }

    private (set) var cards: Array<MemoryGame.Card>
    private (set) var score: Int = 0
    private (set) var lastCardChosenDate: Date?
    private var indexOfFaceUpCard: Int?

    mutating func choose(card: MemoryGame.Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id } ) else { return }
        guard !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched else { return }

        defer {
            lastCardChosenDate = Date()
        }

        let scoreMultiplier = max(10 - secondsSinceLastCardChosen(), 1)

        if let potentialMatchIndex = indexOfFaceUpCard {
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                score += 2 * scoreMultiplier
            }

            if cards[chosenIndex].seen {
                score -= 1 * scoreMultiplier
            }

            indexOfFaceUpCard = nil
        } else {
            for index in cards.indices {
                if cards[index].isFaceUp {
                    cards[index].seen = true
                }

                cards[index].isFaceUp = false
            }

            indexOfFaceUpCard = chosenIndex
        }

        cards[chosenIndex].isFaceUp.toggle()
        print("chosenCard = \(cards[chosenIndex])")
        print("cards = \n\(cards)")
    }

    func secondsSinceLastCardChosen() -> Int {
        guard let lastCardChosenDate else { return 0 }

        return Int(Date().timeIntervalSince(lastCardChosenDate))
    }

    // Custom implementation of `firstIndex`
    func index(of card: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }

        return nil
    }

    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }

        cards.shuffle()
    }
}
