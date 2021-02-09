//
//  cards.swift
//  five_card_draw
//
//  Created by Joshua Erasmus on 2021/02/07.
//

enum CardValues: Int {
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case jack = 11
    case queen = 12
    case king = 13
    case ace = 14
}

enum CardSuit: Int {
    case diamonds = 1
    case spades = 2
    case clubs = 3
    case hearts = 4
}

class Card {

    // Creating the card object
    let display: String
    let value: CardValues
    let suit: CardSuit
    init(display: String, value: CardValues, suit: CardSuit) {
        self.display = display
        self.value = value
        self.suit = suit
    }
}

class Deck {
    static let singleton = Deck()
    var cards = [
        Card(display: "A♦", value: .ace, suit: .diamonds),
        Card(display: "2♦", value: .two, suit: .diamonds),
        Card(display: "3♦", value: .three, suit: .diamonds),
        Card(display: "4♦", value: .four, suit: .diamonds),
        Card(display: "5♦", value: .five, suit: .diamonds),
        Card(display: "6♦", value: .six, suit: .diamonds),
        Card(display: "7♦", value: .seven, suit: .diamonds),
        Card(display: "8♦", value: .eight, suit: .diamonds),
        Card(display: "9♦", value: .nine, suit: .diamonds),
        Card(display: "10♦", value: .ten, suit: .diamonds),
        Card(display: "J♦", value: .jack, suit: .diamonds),
        Card(display: "Q♦", value: .queen, suit: .diamonds),
        Card(display: "K♦", value: .king, suit: .diamonds),
        Card(display: "A♠", value: .ace, suit: .spades),
        Card(display: "2♠", value: .two, suit: .spades),
        Card(display: "3♠", value: .three, suit: .spades),
        Card(display: "4♠", value: .four, suit: .spades),
        Card(display: "5♠", value: .five, suit: .spades),
        Card(display: "6♠", value: .six, suit: .spades),
        Card(display: "7♠", value: .seven, suit: .spades),
        Card(display: "8♠", value: .eight, suit: .spades),
        Card(display: "9♠", value: .nine, suit: .spades),
        Card(display: "10♠", value: .ten, suit: .spades),
        Card(display: "J♠", value: .jack, suit: .spades),
        Card(display: "Q♠", value: .queen, suit: .spades),
        Card(display: "K♠", value: .king, suit: .spades),
        Card(display: "A♣", value: .ace, suit: .clubs),
        Card(display: "2♣", value: .two, suit: .clubs),
        Card(display: "3♣", value: .three, suit: .clubs),
        Card(display: "4♣", value: .four, suit: .clubs),
        Card(display: "5♣", value: .five, suit: .clubs),
        Card(display: "6♣", value: .six, suit: .clubs),
        Card(display: "7♣", value: .seven, suit: .clubs),
        Card(display: "8♣", value: .eight, suit: .clubs),
        Card(display: "9♣", value: .nine, suit: .clubs),
        Card(display: "10♣", value: .ten, suit: .clubs),
        Card(display: "J♣", value: .jack, suit: .clubs),
        Card(display: "Q♣", value: .queen, suit: .clubs),
        Card(display: "K♣", value: .king, suit: .clubs),
        Card(display: "A♥", value: .ace, suit: .hearts),
        Card(display: "2♥", value: .two, suit: .hearts),
        Card(display: "3♥", value: .three, suit: .hearts),
        Card(display: "4♥", value: .four, suit: .hearts),
        Card(display: "5♥", value: .five, suit: .hearts),
        Card(display: "6♥", value: .six, suit: .hearts),
        Card(display: "7♥", value: .seven, suit: .hearts),
        Card(display: "8♥", value: .eight, suit: .hearts),
        Card(display: "9♥", value: .nine, suit: .hearts),
        Card(display: "10♥", value: .ten, suit: .hearts),
        Card(display: "J♥", value: .jack, suit: .hearts),
        Card(display: "Q♥", value: .queen, suit: .hearts),
        Card(display: "K♥", value: .king, suit: .hearts)
    ]

    // This is a simple shuffle, however a more complex shuffle could be added easily without breaking anything
    func shuffleCards() {
        cards.shuffle()
    }

    // The deal function takes a card from the top of the deck (Index 0) and adds it to a players hand.
    // The card is removed from the deck when it is in the hand of the player.
    // The deal is designed to simulate a real deal by handing one card at a time to a player.
    func dealCards(perHand: Int) {
        for _ in 1...perHand {
            Group.singleton.players.forEach { player in
                player.hand.append(cards[0])
                cards.remove(at: 0)
            }
        }
    }

    // This simply adds the cards back to the deck and clears the players hand
    // Fun fact, this adds to the shuffling.
    func returnCardsToDeck() {
        Group.singleton.players.forEach { player in
            cards.append(contentsOf: player.hand)
            player.hand = []
        }
    }
}
