//
//  ContentView.swift
//  MindGame
//
//  Created by Sathish Kumar on 06/07/2020.
//  Copyright © 2020 Sathish Kumar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var mindGame: EmojiMindGame
    
    var body: some View {
        HStack {
            ForEach(mindGame.cards) { card in
                CardView(card: card).onTapGesture {
                    self.mindGame.choose(card: card)
                }
            }
        }
        .padding()
        .font(Font.largeTitle)
        .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card : MindGame<String>.Card
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(mindGame: EmojiMindGame())
    }
}
