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

    typealias Card = MemoryGame<String>.Card

    private static var carsTheme: MemoryTheme {
        let emojis = ["🚕", "🚃", "🛵", "🚂", "🚄", "🚅", "🚆", "🚇", "🚈", "🚉", "🚊", "🚝", "🚞", "🚋", "🚌", "🚍", "🚎", "🚐", "🚑", "🚒", "🚓", "🚔", "🚖", "🚗", "🚘", "🚙", "🛻", "🚚", "🚛", "🚜"]
        return MemoryTheme(name: "cars", emojis: Set(emojis), numOfCards: 15, color: "green")
    }

    private static var foodTheme: MemoryTheme {
        let emojis = ["🍔", "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍑", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄", "🥜", "🫘", "🌰", "🍞"]
        return MemoryTheme(name: "food", emojis: Set(emojis), numOfCards: 15, color: "purple")
    }

    private static var animalsTheme: MemoryTheme {
        let emojis = ["🦍", "🦧", "🐶", "🐕", "🦮", "🐕‍🦺", "🐩", "🐺", "🦊", "🦝", "🐱", "🐈", "🐈‍⬛", "🦁", "🐯", "🐅", "🐆", "🐴", "🐎", "🦄", "🦓", "🦌", "🦬", "🐮", "🐂", "🐃", "🐄", "🐷", "🐖", "🐗", "🐏", "🐑"]
//        "🐐", "🐪", "🐫", "🐓", "🦉", "🐥", "🦩", "🦃", "🦜", "🦆", "🕊", "🦅", "🦢"]
        return MemoryTheme(name: "animals", emojis: Set(emojis), numOfCards: 15, color: "orange")
    }

    private static var flagsTheme: MemoryTheme {
        let emojis = ["🏳️‍🌈", "🏳️‍⚧️", "🏴‍☠️", "🇦🇨", "🇦🇩", "🇦🇪", "🇦🇫", "🇦🇬", "🇦🇮", "🇦🇱", "🇦🇲", "🇦🇴", "🇦🇶", "🇦🇷", "🇦🇸", "🇦🇹", "🇦🇺", "🇦🇼", "🇦🇽", "🇦🇿", "🇧🇦", "🇧🇧", "🇧🇩", "🇧🇪", "🇧🇫", "🇧🇬", "🇧🇭", "🇧🇮", "🇧🇯", "🇧🇱", "🇧🇲", "🇧🇳"]
//        "🇧🇴", "🇧🇶", "🇧🇷", "🇧🇸", "🇧🇹", "🇧🇻", "🇧🇼", "🇧🇾", "🇧🇿", "🇨🇦", "🇨🇨", "🇨🇩", "🇨🇫", "🇨🇬", "🇨🇭", "🇨🇮", "🇨🇰", "🇨🇱", "🇨🇲", "🇨🇳", "🇨🇴", "🇨🇵", "🇨🇷", "🇨🇺", "🇨🇻", "🇨🇼", "🇨🇽", "🇨🇾", "🇨🇿", "🇩🇪", "🇬🇬", "🇬🇭", "🇬🇮", "🇬🇱", "🇬🇲", "🇬🇳", "🇬🇵", "🇬🇶", "🇬🇷", "🇬🇸", "🇬🇹", "🇬🇺", "🇬🇼", "🇬🇾", "🇭🇰", "🇭🇲", "🇭🇳", "🇭🇷", "🇭🇹", "🇭🇺", "🇮🇨", "🇮🇩", "🇮🇪", "🇮🇱", "🇮🇲", "🇮🇳", "🇮🇴", "🇮🇶", "🇮🇷", "🇮🇸", "🇮🇹", "🇯🇪", "🇯🇲"]
        return MemoryTheme(name: "flags", emojis: Set(emojis), numOfCards: 15, color: "yellow")
    }

    static func createMemoryGame(theme: MemoryTheme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numOfCards) { pairIndex in
            theme.emojis[pairIndex]
        }
    }

    static func createMemoryTheme() -> MemoryTheme {
        let themes = [carsTheme, foodTheme, animalsTheme, flagsTheme]
        return themes.randomElement() ?? carsTheme
    }

    /// With @Published, anytime the model changes, it will call `objectWillChange.send()`
    /// We are able to detect changes in the model because swift can detect changes in structs, can't do it in classes
    @Published private (set) var gameModel: MemoryGame<String>

    @Published private (set) var themeModel: MemoryTheme

    init() {
        (self.themeModel, self.gameModel) = EmojiMemoryGame.buildModels()
    }

    var cards: Array<Card> {
        return gameModel.cards
    }

    var themeColor: Color {
        return themeModel.color.uiColor
    }

    var themeName: String {
        return themeModel.name
    }

    var score: Int {
        return gameModel.score
    }

    // MARK: - Intent(s)
    func choose(_ card: Card) {
//        objectWillChange.send()
        gameModel.choose(card: card)
    }

    func newGame() {
        (self.themeModel, self.gameModel) = EmojiMemoryGame.buildModels()
    }

    static func buildModels() -> (MemoryTheme, MemoryGame<String>) {
        let themeModel = EmojiMemoryGame.createMemoryTheme()
        let gameModel = EmojiMemoryGame.createMemoryGame(theme: themeModel)
        return (themeModel, gameModel)
    }
}

extension String {
    var uiColor: Color {
        switch self {
            case "pink":
                return .pink
            case "green":
                return .green
            case "purple":
                return .purple
            case "orange":
                return .orange
            case "yellow":
                return .yellow
            default:
                return .red
        }
    }
}
