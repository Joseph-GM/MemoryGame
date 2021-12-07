//
//  ViewController.swift
//  MemoryGame
//
//  Created by Joseph Kim on 2021/12/02.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    // 강의에서는 (cardButtons.count+1) / 2라 했음
    // private으로 하는 것이 좋음 --> 처음에 private을 지정안해도 동작하지만, numberOfPairsOfCards에 종속적이니 ViewController에서만 쓰이는 것이 좋음
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1) / 2
    }
    private(set) var flipCount: Int = 0 {  // user가 볼수 있게 하는 것은 괜찮으나 set하면 문제가 있기에 private(set)
        didSet{
            flipCountLabel.text = "Flip : \(flipCount)"
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
//    var emojiArray : Array<String> = ["👻", "🎃", "👻", "🎃"]
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in viewDidLoad game.cards.count : \(game.cards.count)")
        print("in viewDidLoad game.indexOfThe... : \(game.indexOfTheOneAndOnlyFaceUpCard)")
        // Do any additional setup after loading the view.
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
//        for i in 0..<cardButtons.count {
//            print("game.cards[\(i)] = \(game.cards[i].identifier)")
//        }
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            print("cardNumber : \(cardNumber)")
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
//            flipCard(withEmoji: emojiArray[cardNumber], on: sender)
        } else {
            print("choose proper card")
        }
        print("number of CardButton \(cardButtons.count)")
        
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for:.normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : .orange
            }
        }
    }
    
    private var emojiChoices = ["👻", "🎃", "🤡", "☠️","👽","👹","👺","💀","👁"]
    
//    var emoji =  Dictionary<Int, String>()
    private var emoji = [Int:String]() //Same as above statement of Dictionary
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            //extention 추가후 아래 let 부분 지움
//            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)) )
            //extention 추가후 아래 주석이 바뀜
//            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        } else {return "?"}
        return emoji[card.identifier] ?? "?" //위에 주석이랑 정확히 같은 표현
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}

