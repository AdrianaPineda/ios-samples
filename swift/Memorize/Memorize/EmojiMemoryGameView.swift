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
        Spacer() // always takes all the space offered to it. Draws nothing. The minLength defaults to the most likely spacing you'd want on a given platform
//        Divider() // draws a dividing line cross-wise to the way the stack is laying out. Takes the minimum space needed to fit the line in the direction the stack is going

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

        // LazyHStack & LazyVStack => "lazy" versions of the stack, they don't build any of their Views that are not visible, they size themselves to fir their Views
        // ZStack => sizes itself to fit its children

        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            cardView(for: card)
        })
        .foregroundColor(game.themeColor)
        .padding(.horizontal)

    }

    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        }
    }

    func previousBody() {
        Text("Memorize!").font(.largeTitle)

        Spacer()
        Spacer() // always takes all the space offered to it. Draws nothing. The minLength defaults to the most likely spacing you'd want on a given platform
//        Divider() // draws a dividing line cross-wise to the way the stack is laying out. Takes the minimum space needed to fit the line in the direction the stack is going

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

        // LazyHStack & LazyVStack => "lazy" versions of the stack, they don't build any of their Views that are not visible, they size themselves to fir their Views
        // ZStack => sizes itself to fit its children

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

    var bodyOld: some View {
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

    var body: some View {
        // GeometryReader will use all of the space that was offered to it
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth) // strokeBorder does it on the inside
                    Circle().padding(4).opacity(0.5)
                    Text(card.content).font(font(in: geometry.size))
                        .lineLimit(nil)
                } else if card.isMatched {
                    shape.opacity(DrawingConstants.opacity)
                } else {
                    shape.fill()
                }
            }
        }
    }

    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }

    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let opacity: CGFloat = 0.5
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

// @ViewBuilder: combines list of views. The contents is just a list of Views
