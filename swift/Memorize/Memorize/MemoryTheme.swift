//
//  MemoryTheme.swift
//  Memorize
//
//  Created by Adriana Pineda on 12/31/22.
//

import Foundation

// Model
struct MemoryTheme {

    let name: String
    let emojis: [String]
    let numOfCards: Int
    let color: String

    init(name: String, emojis: Set<String>, numOfCards: Int = Int.max, color: String) {
        self.name = name
        self.numOfCards = min(numOfCards, emojis.count)
        self.emojis = emojis.shuffled()
        self.color = color
    }

    init(name: String, emojis: Set<String>, color: String) {
        self.name = name
        self.numOfCards = Int.random(in: 1...emojis.count)
        self.emojis = emojis.shuffled()
        self.color = color
    }
}
