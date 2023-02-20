//
//  ContentView.swift
//  SoloSet
//
//  Created by Adriana Pineda on 2/20/23.
//

import SwiftUI

struct SoloSetGameView: View {
    @ObservedObject var game: SoloSetGameViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(game.cards) { card in
                    CardView(card).aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
    }
}

struct CardView: View {
    private let card: SoloSetCard

    init(_ card: SoloSetCard) {
        self.card = card
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 10)
                shape.fill().foregroundColor(.white)
                Text("\(card.id)")
                    .font(.largeTitle)
                    .lineLimit(nil)
                    .padding()
            }
        }
    }
}

struct SoloSetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SoloSetGameViewModel()
        SoloSetGameView(game: game)
    }
}
