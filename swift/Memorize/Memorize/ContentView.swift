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
    var emojis = ["🚕", "🚃", "🛵", "🚂", "🚄", "🚅", "🚆", "🚇", "🚈", "🚉", "🚊", "🚝", "🚞", "🚋", "🚌", "🚍", "🚎", "🚐", "🚑", "🚒", "🚓", "🚔", "🚕", "🚖", "🚗", "🚘", "🚙", "🛻", "🚚", "🚛", "🚜", "🏎️", "🏍️", "🛵", "🦽", "🦼", "🛺", "🚲"]
    @State var emojiCount = 4

    // 'some View' something that behaves like a View
    var body: some View {
        VStack {
            ScrollView {
                // LazyVGrid: lazy about accessing the body vars of all its views
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
                removeCard
                Spacer()
                addCard
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)

    }

    var removeCard: some View {
        Button {
            if emojiCount < emojis.count {
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
            emojiCount += 1
        } label: {
            Image(systemName: "plus.circle")
//            VStack {
//                Text("Add")
//                Text("Card")
//            }
        }
    }
}

struct CardView: View {
    // `@State` changes var, its now a pointer to a boolean
    // used for temp state or for state that only affects the way the view is displayed
    @State var isFaceUp = true
    var content: String

    var body: some View {
        ZStack { // stacks views on top of each other, from the device towards the user
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth:3)
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
