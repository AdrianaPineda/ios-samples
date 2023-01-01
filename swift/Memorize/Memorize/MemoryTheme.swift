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

    init(name: String, emojis: Set<String>, numOfCards: Int, color: String) {
        self.name = name
        self.numOfCards = min(numOfCards, emojis.count)
        self.emojis = emojis.shuffled()
        self.color = color
    }
}
