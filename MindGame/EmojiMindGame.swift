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
    private var mindGame: MindGame<String> = createEmojiMindGame()
    
    static func createEmojiMindGame() -> MindGame<String> {
        let emojis = ["🤪", "😳"]
        return MindGame<String>(noOfPairs: emojis.count) { index in
            return emojis[index]
        }
    }
    
    // MARK: Accessors
    
    var cards: Array<MindGame<String>.Card> {
        mindGame.cards
    }
    
    // MARK: Actions
    
    func choose(card: MindGame<String>.Card) {
        mindGame.choose(card: card)
    }
}
