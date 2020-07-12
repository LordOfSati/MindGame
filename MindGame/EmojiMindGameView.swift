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
        VStack {
            Grid(mindGame.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 1)) {
                        self.mindGame.choose(card: card)
                    }
                }
                .padding(5)
            }
            Button(action: {
                withAnimation(.easeInOut) {
                    self.mindGame.resetGame()
                }
            }, label: { Text("NEW GAME") })
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
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(Animation.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0 - 90),
                        endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90),
                        clockwise: true).onAppear {
                            self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle.degrees(0 - 90),
                            endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90),
                        clockwise: true)
                    }
                }.padding(5).opacity(0.5)
                Text(card.content).font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
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
