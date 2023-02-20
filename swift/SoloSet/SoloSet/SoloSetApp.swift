//
//  SoloSetApp.swift
//  SoloSet
//
//  Created by Adriana Pineda on 2/20/23.
//

import SwiftUI

@main
struct SoloSetApp: App {
    private let game = SoloSetGameViewModel()
    var body: some Scene {
        WindowGroup {
            SoloSetGameView(game: game)
        }
    }
}
