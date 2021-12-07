//
//  Concentration.swift
//  MemoryGame
//
//  Created by Joseph Kim on 2021/12/03.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    
//    var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
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
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            print("cards[index] = \(cards[index].isMatched)")
            print("indexOfOneAndOnlyFaceUpCard : \(indexOfTheOneAndOnlyFaceUpCard)")
            if let matchIndex = indexOfTheOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                print("in matchIndex !!! : \(matchIndex), index : \(index)")
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
//                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                print("in else index = \(index)")
                // indexOfTheOneAndOnlyFaceUpCard 를 computed property로 바꾸면서 아래 주석을 삭제해도 됨
//                for flipDownIndex in cards.indices {
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfTheOneAndOnlyFaceUpCard = index
            }
        }
//        if cards[index].isFaceUp {
//            cards[index].isFaceUp = false
//        } else {
//            cards[index].isFaceUp = true
//        }
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
        print("In init of Concentration Class cards.count : \(cards.count)")
    }
}
