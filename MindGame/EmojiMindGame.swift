//
//  EmojiMindGame.swift
//  MindGame
//
//  Created by Sathish Kumar on 06/07/2020.
//  Copyright © 2020 Sathish Kumar. All rights reserved.
//

import Foundation

class EmojiMindGame: ObservableObject {
    
    @Published
    private var mindGame: MindGameModel<String> = createEmojiMindGame()
    
    private static func createEmojiMindGame() -> MindGameModel<String> {
        let emojis = ["🤪", "😳", "🤡", "👻", "🤖"]
        return MindGameModel<String>(noOfPairs: emojis.count) { index in
            return emojis[index]
        }
    }
    
    // MARK: Accessors
    
    var cards: [MindGameModel<String>.Card] {
        mindGame.cards
    }
    
    // MARK: Actions
    
    func choose(card: MindGameModel<String>.Card) {
        mindGame.choose(card: card)
    }
    
    func resetGame() {
        mindGame = EmojiMindGame.createEmojiMindGame()
    }
}
