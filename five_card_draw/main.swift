//
//  main.swift
//  five_card_draw
//
//  Created by Joshua Erasmus on 2021/02/07.
//

import Foundation

var display = false

setup()
gamePlay()

// initial setup. Used to set the player name, as well as amount of bots.
func setup() {
    print("Welcome to Command Line Poker.")
    print("Enter your name to begin : ")

    if let name = readLine() {
        print("\nhey, \(name)!")
        Group.singleton.addPlayer(newPlayer: Player(name: name, isUser: true))
    }

    print("\nHow many people will be playing today?")
    enterCount()

    print("the players are : ")
    print()
    Group.singleton.players.forEach { player in
        print(player.name)
    }
    print()

    print("View other players hands? y / n")
    viewOtherHands()
}

func enterCount() {
    if let playerCount = readLine() {
        if Int(playerCount) != nil {
            let count = Int(playerCount)!
            if count > 0 && count < 10 {
                for pCount in 1...count {
                    Group.singleton.addPlayer(newPlayer: Player(name: "Player-\(pCount)", isUser: false))
                }
                print("\nGreat, \(playerCount) players joined")
            } else {
                print("Only 1 - 9 players allowed (Excluding yourself)")
                enterCount()
            }
        } else {
            print("Please enter a numerical value")

            enterCount()
        }
    }
}

func viewOtherHands() {
    // This is just for fun
    if let debug = readLine() {
        if debug == "y" {
            display = true
        } else if debug != "n" {
            print("Please enter either \n y to View all hands or \n n to only view your hand")
            viewOtherHands()
        } else {
            display = false
        }
    }
}

func gamePlay() {

    print("shuffling...")
    Deck.singleton.shuffleCards()

    // by passing in the amount of cards per hand you can easily adjust it according to the game,
    // or amount of cards dealt at a time.
    print("Dealing...")
    Deck.singleton.dealCards(perHand: 5)

    // This is where we loop through the players, and evaluate their hands
    for player in Group.singleton.players{
        var holding = ""
        for card in player.hand {
            holding += "\(card.display) | "
        }

        let evaluation = Evaluate.checkStrength(cards: player.hand)
        player.handResult = Evaluation(
            handStrength: evaluation.strength,
            handHHighCard: evaluation.highCard,
            holding: holding
        )

        if player.isUser || display {
            print()
            print(holding)
            print(player.isUser ? "You have \(evaluation.handDesc.rawValue)" : "\(player.name) has \(evaluation.handDesc.rawValue)")
            print()
        }
    }

    // Once we have the evaluated hands we can compare them all.
    print(Evaluate.comparePlayerResults(players: Group.singleton.players))

    // Clear the payers hands and return the cards to the deck
    Deck.singleton.returnCardsToDeck()

    // Shift the dealer / big blind / small blind
    Group.singleton.changeBlinds()

    print("\nPlay again? y / n")
    playAgain()
}

func playAgain() {
    if let again = readLine() {
        if again == "y" {
            gamePlay()
        } else if again != "n" {
            print("Please enter either \n y to play again or \n n to quit")
            playAgain()
        } else {
            print("Thanks for playing")
        }
    }
}
