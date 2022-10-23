//
//  ContentView.swift
//  Memorize
//
//  Created by Adriana Pineda on 10/6/21.
//

/**
 body is a function (first class citizen)
 body is calculated everytime is needed, its not stored in memory
 */

import SwiftUI

struct ContentView: View {
    var emojis = ["🚕", "🚃", "🛵", "🚂", "🚄", "🚅", "🚆", "🚇", "🚈", "🚉", "🚊", "🚝", "🚞", "🚋", "🚌", "🚍", "🚎", "🚐", "🚑", "🚒", "🚓", "🚔", "🚖", "🚗", "🚘", "🚙", "🛻", "🚚", "🚛", "🚜", "🏎️", "🏍️", "🦽", "🦼", "🛺", "🚲"]
    @State var emojiCount = 4

    // 'some View': something that behaves like a View
    var body: some View {
//        RoundedRectangle(cornerRadius: 25)
//            .stroke(lineWidth: 3)
//            .padding(.horizontal)
//            .foregroundColor(.red)
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                // LazyVGrid: lazy about accessing the body vars of all its views
                // We only get the value of a body var of views that actually appear on screen
                // Only accesing body var when its absolutely necessary
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    // we cannot do for loops here, but we can:
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }

            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                carsTheme
                Spacer()
                foodTheme
                Spacer()
                animalsTheme
                Spacer()
                flagsTheme
//                removeCard
//                Spacer()
//                addCard
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)

    }

    var removeCard: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
//            VStack {
//                Text("Remove")
//                Text("Card")
//            }
        }
    }

    var addCard: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
//            VStack {
//                Text("Add")
//                Text("Card")
//            }
        }
    }

    var carsTheme: some View {
        Button {

        } label: {
            Image(systemName: "car")
        }
    }

    var foodTheme: some View {
        Button {

        } label: {
            Image(systemName: "applelogo")
        }
    }

    var animalsTheme: some View {
        Button {

        } label: {
            Image(systemName: "ant")
        }
    }

    var flagsTheme: some View {
        Button {

        } label: {
            Image(systemName: "flag.2.crossed")
        }
    }
}

// Views are immutable
struct CardView: View {
    // `@State` changes var, its now a pointer to a boolean
    // used for temp state or for state that only affects the way the view is displayed
    // without it, we couldn't modify the var
    @State var isFaceUp = true
    var content: String

    var body: some View {
        ZStack { // stacks views on top of each other, from the device towards the user
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth:3) // strokeBorder does it on the inside
                Text(content)
                    .font(.largeTitle)
                    .lineLimit(nil)
                    .padding() // default padding, it might mean different things for different devices (watch, phone, ipad)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

// Glues the preview to the ContentView:
// No need to modify it
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
