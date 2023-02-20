//
//  File.swift
//  SoloSet
//
//  Created by Adriana Pineda on 2/20/23.
//

import Foundation

struct SoloSetCard: Identifiable {
    enum Shape {
        case diamond, squiggle, oval
    }

    enum Shading {
        case solid, stripped, open
    }

    enum Color {
        case red, green, purple
    }

    struct CardType {
        let shape: Shape
        let shapeCount: Int
        let shading: Shading
        let color: Color
    }

    let type: CardType
    let isFaceUp: Bool
    let isMatched: Bool

    let id: Int
}
