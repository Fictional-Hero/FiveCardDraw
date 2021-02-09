//
//  five_card_draw_tests.swift
//  five_card_draw_tests
//
//  Created by Joshua Erasmus on 2021/02/08.
//

import XCTest
@testable import five_card_draw

class FiveCardDrawTests: XCTestCase {

    func testHandHighCard() {
        let result = Evaluate.checkStrength(cards: [
            Card(display: "", value: .two, suit: .clubs),
            Card(display: "", value: .four, suit: .diamonds),
            Card(display: "", value: .five, suit: .clubs),
            Card(display: "", value: .six, suit: .hearts),
            Card(display: "", value: .seven, suit: .clubs)
        ])
        XCTAssertEqual(.highCard, result.handDesc)
        XCTAssertEqual(.highCard, result.strength)
        XCTAssertEqual(CardValues.seven.rawValue, result.highCard)
    }
    func testHandOnePair() {
        let result = Evaluate.checkStrength(cards: [
            Card(display: "", value: .two, suit: .clubs),
            Card(display: "", value: .three, suit: .hearts),
            Card(display: "", value: .two, suit: .clubs),
            Card(display: "", value: .five, suit: .diamonds),
            Card(display: "", value: .six, suit: .clubs)
        ])
        XCTAssertEqual(.onePair, result.handDesc)
        XCTAssertEqual(.onePair, result.strength)
        XCTAssertEqual(CardValues.two.rawValue, result.highCard)
    }
    func testHandTwoPair() {
        let result = Evaluate.checkStrength(cards: [
            Card(display: "", value: .two, suit: .clubs),
            Card(display: "", value: .three, suit: .hearts),
            Card(display: "", value: .two, suit: .clubs),
            Card(display: "", value: .three, suit: .spades),
            Card(display: "", value: .six, suit: .clubs)
        ])
        XCTAssertEqual(.twoPair, result.handDesc)
        XCTAssertEqual(.twoPair, result.strength)
        XCTAssertEqual(CardValues.three.rawValue, result.highCard)
    }
    func testHandThreeOfAKind() {
        let result = Evaluate.checkStrength(cards: [
            Card(display: "", value: .two, suit: .clubs),
            Card(display: "", value: .three, suit: .diamonds),
            Card(display: "", value: .two, suit: .clubs),
            Card(display: "", value: .five, suit: .hearts),
            Card(display: "", value: .two, suit: .clubs)
        ])
        XCTAssertEqual(.threeOfAKind, result.handDesc)
        XCTAssertEqual(.threeOfAKind, result.strength)
        XCTAssertEqual(CardValues.two.rawValue, result.highCard)
    }
    func testHandStraight() {
        let result = Evaluate.checkStrength(cards: [
            Card(display: "", value: .ten, suit: .clubs),
            Card(display: "", value: .jack, suit: .diamonds),
            Card(display: "", value: .queen, suit: .clubs),
            Card(display: "", value: .king, suit: .hearts),
            Card(display: "", value: .ace, suit: .clubs)
        ])
        XCTAssertEqual(.straight, result.handDesc)
        XCTAssertEqual(.straight, result.strength)
        XCTAssertEqual(CardValues.ace.rawValue, result.highCard)
    }
    func testHandFlush() {
        let result = Evaluate.checkStrength(cards: [
            Card(display: "", value: .two, suit: .clubs),
            Card(display: "", value: .three, suit: .clubs),
            Card(display: "", value: .two, suit: .clubs),
            Card(display: "", value: .five, suit: .clubs),
            Card(display: "", value: .six, suit: .clubs)
        ])
        XCTAssertEqual(.flush, result.handDesc)
        XCTAssertEqual(.flush, result.strength)
        XCTAssertEqual(CardValues.six.rawValue, result.highCard)
    }
    func testHandFullHouse() {
        let result = Evaluate.checkStrength(cards: [
            Card(display: "", value: .two, suit: .clubs),
            Card(display: "", value: .three, suit: .spades),
            Card(display: "", value: .two, suit: .clubs),
            Card(display: "", value: .three, suit: .diamonds),
            Card(display: "", value: .three, suit: .clubs)
        ])
        XCTAssertEqual(.fullHouse, result.handDesc)
        XCTAssertEqual(.fullHouse, result.strength)
        XCTAssertEqual(CardValues.three.rawValue, result.highCard)
    }
    func testHandFourOfAKind() {
        let result = Evaluate.checkStrength(cards: [
            Card(display: "", value: .two, suit: .clubs),
            Card(display: "", value: .two, suit: .spades),
            Card(display: "", value: .two, suit: .clubs),
            Card(display: "", value: .five, suit: .diamonds),
            Card(display: "", value: .two, suit: .clubs)
        ])
        XCTAssertEqual(.fourOfAKind, result.handDesc)
        XCTAssertEqual(.fourOfAKind, result.strength)
        XCTAssertEqual(CardValues.two.rawValue, result.highCard)
    }
    func testHandFourOfAKindBeatsFlush() {
        let result = Evaluate.checkStrength(cards: [
            Card(display: "", value: .two, suit: .diamonds),
            Card(display: "", value: .two, suit: .diamonds),
            Card(display: "", value: .two, suit: .diamonds),
            Card(display: "", value: .five, suit: .diamonds),
            Card(display: "", value: .two, suit: .diamonds)
        ])
        XCTAssertEqual(.fourOfAKind, result.handDesc)
        XCTAssertEqual(.fourOfAKind, result.strength)
        XCTAssertEqual(CardValues.two.rawValue, result.highCard)
    }
    func testHandStraightFlush() {
        let result = Evaluate.checkStrength(cards: [
            Card(display: "2", value: .two, suit: .clubs),
            Card(display: "3", value: .three, suit: .clubs),
            Card(display: "4", value: .four, suit: .clubs),
            Card(display: "5", value: .five, suit: .clubs),
            Card(display: "6", value: .six, suit: .clubs)
        ])
        XCTAssertEqual(.straightFlush, result.handDesc)
        XCTAssertEqual(.straightFlush, result.strength)
        XCTAssertEqual(CardValues.six.rawValue, result.highCard)
    }
    func testHandRoyalFlush() {
        let result = Evaluate.checkStrength(cards: [
            Card(display: "", value: .ten, suit: .hearts),
            Card(display: "", value: .jack, suit: .hearts),
            Card(display: "", value: .queen, suit: .hearts),
            Card(display: "", value: .king, suit: .hearts),
            Card(display: "", value: .ace, suit: .hearts)
        ])
        XCTAssertEqual(.royalFlush, result.handDesc)
        XCTAssertEqual(.royalFlush, result.strength)
        XCTAssertEqual(CardValues.ace.rawValue, result.highCard)
    }

    func testShuffle() {
        let deckBeforeShuffle = Deck.singleton.cards
        Deck.singleton.shuffleCards()
        let deckAfterShuffle = Deck.singleton.cards
        XCTAssertNotEqual(deckBeforeShuffle[0].display, deckAfterShuffle[0].display)
        XCTAssertNotEqual(deckBeforeShuffle[51].display, deckAfterShuffle[51].display)
    }

    func testDeal() {
        Group.singleton.addPlayer(newPlayer: Player(name: "John", isUser: true))
        Group.singleton.addPlayer(newPlayer: Player(name: "Doe", isUser: false))
        Deck.singleton.dealCards(perHand: 5)
        XCTAssertEqual(Deck.singleton.cards.count, 42)
        XCTAssertEqual(Group.singleton.players[0].hand.count, 5)
        XCTAssertEqual(Group.singleton.players[1].hand.count, 5)

        Deck.singleton.returnCardsToDeck()
        XCTAssertEqual(Deck.singleton.cards.count, 52)
        XCTAssertEqual(Group.singleton.players[0].hand.count, 0)
        XCTAssertEqual(Group.singleton.players[1].hand.count, 0)
    }

}
