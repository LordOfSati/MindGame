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
            .padding(5)
        }
        .padding()
        .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card : MindGameModel<String>.Card
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0 - 90),
                    endAngle: Angle.degrees(110 - 90),
                    clockwise: true).padding(5).opacity(0.5)
                Text(card.content).font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.height, size.width) * fontScaleFactor
    }
    
    private let fontScaleFactor: CGFloat = 0.70
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMindGame()
        game.choose(card: game.cards.first!)
        return EmojiMindGameView(mindGame: game)
    }
}
