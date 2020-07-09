//
//  EmojiMindGameView.swift
//  MindGame
//
//  Created by Sathish Kumar on 06/07/2020.
//  Copyright © 2020 Sathish Kumar. All rights reserved.
//

import SwiftUI

struct EmojiMindGameView: View {
    
    @ObservedObject
    var mindGame: EmojiMindGame
    
    var body: some View {
        Grid(mindGame.cards) { card in
            CardView(card: card).onTapGesture {
                self.mindGame.choose(card: card)
            }
            .padding()
        }
        .padding()
        .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card : MindGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        return ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: cardBorderWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    func fontSize(for size: CGSize) -> CGFloat {
        return min(size.height, size.width) * fontScaleFactor
    }
    
    let fontScaleFactor: CGFloat = 0.75
    let cornerRadius: CGFloat = 10.0
    let cardBorderWidth: CGFloat = 3
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMindGameView(mindGame: EmojiMindGame())
    }
}
