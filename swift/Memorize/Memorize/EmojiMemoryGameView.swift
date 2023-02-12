//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Adriana Pineda on 10/6/21.
//

/**
 body is a function (first class citizen)
 body is calculated everytime is needed, its not stored in memory
 */

import SwiftUI

struct EmojiMemoryGameView: View {
    /// With @ObservedObject, when this changes, body will be rebuilt
    @ObservedObject var game: EmojiMemoryGame

    var body: some View {
        Text("Memorize!").font(.largeTitle)

        Spacer()
        Spacer()

        HStack {
            Button {
                game.newGame()
            } label: {
                Label("New Game", systemImage: "plus.circle")
            }
            .font(.title3)

            Spacer()

            Text("Score \(game.score)")
        }
        .padding(.horizontal)

        Spacer()
        Spacer()

        Text("Current Theme: \(game.themeName)")

        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(game.cards) { card in
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }

        }
        .foregroundColor(game.themeColor)
        .padding(.horizontal)

    }

    var carsTheme: some View {
        ThemeView(imageName: "car", text: "Cars") {
//            emojis = ["🚕", "🚃", "🛵", "🚂", "🚄", "🚅", "🚆", "🚇", "🚈", "🚉", "🚊", "🚝", "🚞", "🚋", "🚌", "🚍", "🚎", "🚐", "🚑", "🚒", "🚓", "🚔", "🚖", "🚗", "🚘", "🚙", "🛻", "🚚", "🚛", "🚜"].shuffled()
        }
    }

    var foodTheme: some View {
        ThemeView(imageName: "applelogo", text: "Food") {
//            emojis = ["🍔", "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍑", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄", "🥜", "🫘", "🌰", "🍞"].shuffled()
        }
    }

    var animalsTheme: some View {
        ThemeView(imageName: "ant", text: "Animals") {
//            emojis = ["🦍", "🦧", "🐶", "🐕", "🦮", "🐕‍🦺", "🐩", "🐺", "🦊", "🦝", "🐱", "🐈", "🐈‍⬛", "🦁", "🐯", "🐅", "🐆", "🐴", "🐎", "🦄", "🦓", "🦌", "🦬", "🐮", "🐂", "🐃", "🐄", "🐷", "🐖", "🐗", "🐏", "🐑", "🐐", "🐪", "🐫", "🐓", "🦉", "🐥", "🦩", "🦃", "🦜", "🦆", "🕊", "🦅", "🦢"].shuffled()
        }
    }

    var flagsTheme: some View {
        ThemeView(imageName: "flag.2.crossed", text: "Flags") {
//            emojis = ["🏳️‍🌈", "🏳️‍⚧️", "🏴‍☠️", "🇦🇨", "🇦🇩", "🇦🇪", "🇦🇫", "🇦🇬", "🇦🇮", "🇦🇱", "🇦🇲", "🇦🇴", "🇦🇶", "🇦🇷", "🇦🇸", "🇦🇹", "🇦🇺", "🇦🇼", "🇦🇽", "🇦🇿", "🇧🇦", "🇧🇧", "🇧🇩", "🇧🇪", "🇧🇫", "🇧🇬", "🇧🇭", "🇧🇮", "🇧🇯", "🇧🇱", "🇧🇲", "🇧🇳", "🇧🇴", "🇧🇶", "🇧🇷", "🇧🇸", "🇧🇹", "🇧🇻", "🇧🇼", "🇧🇾", "🇧🇿", "🇨🇦", "🇨🇨", "🇨🇩", "🇨🇫", "🇨🇬", "🇨🇭", "🇨🇮", "🇨🇰", "🇨🇱", "🇨🇲", "🇨🇳", "🇨🇴", "🇨🇵", "🇨🇷", "🇨🇺", "🇨🇻", "🇨🇼", "🇨🇽", "🇨🇾", "🇨🇿", "🇩🇪", "🇬🇬", "🇬🇭", "🇬🇮", "🇬🇱", "🇬🇲", "🇬🇳", "🇬🇵", "🇬🇶", "🇬🇷", "🇬🇸", "🇬🇹", "🇬🇺", "🇬🇼", "🇬🇾", "🇭🇰", "🇭🇲", "🇭🇳", "🇭🇷", "🇭🇹", "🇭🇺", "🇮🇨", "🇮🇩", "🇮🇪", "🇮🇱", "🇮🇲", "🇮🇳", "🇮🇴", "🇮🇶", "🇮🇷", "🇮🇸", "🇮🇹", "🇯🇪", "🇯🇲"].shuffled()
        }
    }
}

struct ThemeView: View {
    var imageName: String
    var text: String
    var action: () -> Void

    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                Image(systemName: imageName)
            }
            .font(.title)
            Text(text).font(.caption).foregroundColor(.blue)
        }
    }
}

// Views are immutable
struct CardView: View {
    private let card: EmojiMemoryGame.Card

    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth:3) // strokeBorder does it on the inside
                Text(card.content)
                    .font(.largeTitle)
                    .lineLimit(nil)
                    .padding() // default padding, it might mean different things for different devices (watch, phone, ipad)
            } else if card.isMatched {
                shape.opacity(0.5)
            } else {
                shape.fill()
            }
        }
    }
}

// Glues the preview to the EmojiMemoryGameView:
// No need to modify it
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
