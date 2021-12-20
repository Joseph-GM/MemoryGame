//
//  Concentration.swift
//  MemoryGame
//
//  Created by Joseph Kim on 2021/12/03.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    
//    var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
//            return cards.indices.filter { cards[$0].isFaceUp}.oneAndOnly
            var foundIndex: Int?
            print("card.indices = \(cards.indices), type = \(type(of: cards.indices))")
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
                print("cards[\(index)] :  \(cards[index].isFaceUp)")
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            print("indexOfTheOneAndOnly: \(indexOfTheOneAndOnlyFaceUpCard)")
            if let matchIndex = indexOfTheOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                print("in matchIndex !!! : \(matchIndex), index : \(index)")
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = index
            }
        }

    }
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concetration.init(\(numberOfPairsOfCards)): you must have at least one pair of card")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        for i in 0..<numberOfPairsOfCards {
            let randomNumber : Int = Int.random(in: 0..<cards.count)
            let temp = cards[i]
            cards[i] = cards[randomNumber]
            cards[randomNumber] = temp
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
