//
//  MindGameModel.swift
//  MindGame
//
//  Created by Sathish Kumar on 06/07/2020.
//  Copyright © 2020 Sathish Kumar. All rights reserved.
//

import Foundation

struct MindGameModel<CardType> where CardType: Equatable {
    
    private(set) var cards: [Card]
    
    private var firstSelectedCardIndex: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(noOfPairs: Int, contentGenerator: (Int) -> CardType) {
        cards = [Card]()
        for index in 0..<noOfPairs {
            let content = contentGenerator(index)
            cards.append(Card(content: content, id: index * 2))
            cards.append(Card(content: content, id: (index * 2) + 1))
        }
    }
    
    mutating func choose(card: Card) {
        let chosenIndex = self.cards.firstIndex { $0.id == card.id }!
        if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
            if let potentialMatchedIndex = firstSelectedCardIndex {
                if cards[chosenIndex].content == cards[potentialMatchedIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchedIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                firstSelectedCardIndex = chosenIndex
            }
        }
    }
    
    struct Card : Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardType
        var id: Int
    }
}

