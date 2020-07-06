//
//  MemoryGame.swift
//  MindGame
//
//  Created by Sathish Kumar on 06/07/2020.
//  Copyright © 2020 Sathish Kumar. All rights reserved.
//

import Foundation

struct MindGame<CardType> {
    
    var cards: Array<Card>
    
    init(noOfPairs: Int, contentGenerator: (Int) -> CardType) {
        cards = Array<Card>()
        for index in 0..<noOfPairs {
            let content = contentGenerator(index)
            cards.append(Card(content: content, id: index * 2))
            cards.append(Card(content: content, id: (index * 2) + 1))
        }
    }
    
    func choose(card: Card) {
        print("Tapped on \(card)")
    }
    
    struct Card : Identifiable {
        var isFaceUp = true
        var isMatched = false
        var content: CardType
        var id: Int
    }
}

