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
    // 'some View' something that behaves like a View
    var body: some View {

        HStack {
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .padding(.horizontal)
        .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)

    }
}

struct CardView: View {
    var body: some View {
        ZStack { // stacks views on top of each other, from the device towards the user
            RoundedRectangle(cornerRadius: 20)
                .fill()
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth:3)
            Text("✈️")
                .font(.largeTitle)
                .lineLimit(nil)
                .padding() // default padding, it might mean different things for different devices (watch, phone, ipad)
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
