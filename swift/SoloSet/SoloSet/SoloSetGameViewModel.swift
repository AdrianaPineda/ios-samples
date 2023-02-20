//
//  SoloSetGame.swift
//  SoloSet
//
//  Created by Adriana Pineda on 2/20/23.
//

import SwiftUI

class SoloSetGameViewModel: ObservableObject {
    @Published private (set) var model: SoloSetGameModel

    init() {
        let card1 = SoloSetCard(type: SoloSetCard.CardType(shape: .diamond, shapeCount: 1, shading: .open, color: .purple), isFaceUp: false, isMatched: false, id: 1)
        let card2 = SoloSetCard(type: SoloSetCard.CardType(shape: .diamond, shapeCount: 1, shading: .open, color: .purple), isFaceUp: false, isMatched: false, id: 2)
        let card3 = SoloSetCard(type: SoloSetCard.CardType(shape: .diamond, shapeCount: 1, shading: .open, color: .purple), isFaceUp: false, isMatched: false, id: 3)
        self.model = SoloSetGameModel(cards: [card1, card2, card3])
    }

    var cards: Array<SoloSetCard> {
        model.cards
    }
}
