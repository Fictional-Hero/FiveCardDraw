//
//  calculations.swift
//  five_card_draw
//
//  Created by Joshua Erasmus on 2021/02/07.
//

enum Result: Int {
    case notSet
    case highCard
    case onePair
    case twoPair
    case threeOfAKind
    case straight
    case flush
    case fullHouse
    case fourOfAKind
    case straightFlush
    case royalFlush
}
enum ResultDescription: String {
    case notSet = "Not Set"
    case highCard = "High Card"
    case onePair = "One Pair"
    case twoPair = "Two Pairs"
    case threeOfAKind = "Three of a Kind"
    case fourOfAKind = "Four of a Kind"
    case straight = "Straight"
    case flush = "Flush"
    case fullHouse = "Full House"
    case straightFlush = "Straight Flush"
    case royalFlush = "Royal Flush"
}

class Evaluation {
    var strength: Result
    var highCard: Int
    var hand: String
    init(handStrength: Result, handHHighCard: Int, holding: String) {
        strength = handStrength
        highCard = handHHighCard
        hand = holding
    }
}

class Evaluate{
    static func checkStrength(cards : [Card]) -> (strength : Result, highCard : Int, handDesc : ResultDescription) {

        // This is not the most streamlined way to check the hand strength, but I was interested to try it out.

        // Setting up control vars
        var highCard = 0
        var pairCount = 0
        var pairsHigh = 0
        var three = 0
        var four = 0
        var straightHigh = 0
        var flushHigh = 0
        var fullHouseHigh = 0
        var straightFlushHigh = 0
        var royalFlush = 0

        // Creates an empty array which will store the card values
        // This is only focusing on the card number, and not the suite.
        // This will be used to check for straights, and pairs / threes / fours
        var values: [Int] = []
        for card in cards {
            let val = card.value
            values.append(val.rawValue)
        }
        // The sort is to simplify the straight checking.
        values.sort()

        // Get the highest value card in the players hand.
        highCard = values[values.endIndex - 1]

        // In order to check for pairs I create a key value array.
        // I use the card value as the key,
        // that way I just add the value related to the key every time that key is already used.
        // its a simple way to add for duplicates.
        var pairs: [Int : Int] = [:]
        for val in values {
            if pairs[val] != nil {
                pairs[val]! += 1
            } else {
                pairs[val] = 1
            }
        }

        // Loop through the array created above and determine if there were any duplicate values
        for pair in pairs {
            switch pair.value {
            case 2:
                pairCount += 1
                if pairsHigh < pair.key {
                    pairsHigh = pair.key
                }
            case 3:
                three = pair.key
            case 4: four = pair.key
            default:
                break
            }
        }

        // Setting up the control vars to check for a straight
        // Loop through the values array, and check if the current card in the loop,
        // is greater than the previous card by 1.
        // For the first loop we automatically add 1 to the count and add it to the last card var
        // Every loop therafter we only add to the count if its 1 greater than the last card.
        // if it is we also replace the lastCard var with it
        // In the last iteration if the straight count is == to 5 we have a straight.
        // And we add the highest card in the straight
        // If the straightHigh var has a value, there is a straight
        var lastCard = 0
        var straightCount = 0
        var firstRun = true
        for val in values {
            if firstRun {
                lastCard = val
                straightCount += 1
                firstRun = false
            }
            if val == (lastCard + 1) {
                lastCard = val
                straightCount += 1
            }
            if straightCount == 5 {
                straightHigh = values[values.endIndex - 1]
            }
        }

        // Check for a full house by checking if there is 1 pair and a 3 of a kind.
        if pairCount == 1 && three != 0 {
            fullHouseHigh = three
        }

        // Check for flush
        // This is a similar concept to the straight.
        // on first iteration we store the cards suit.
        // we then loop through checking that each card after that has the same suit, if so we add to the count.
        // If the flushHigh var has a value there was a flush
        var controlFlush = 0
        var flushCount = 0
        var flushFirst = true
        for card in cards {
            if flushFirst {
                controlFlush = card.suit.rawValue
                flushFirst = false;
            }
            if controlFlush == card.suit.rawValue {
                flushCount += 1
            }
            if flushCount == 5 {
                flushHigh = values[4]
            }
        }

        // If there was a flush and a straight, we set the straight flush
        if straightHigh != 0 && flushHigh != 0 {
            straightFlushHigh = values[4]
        }

        // And if the straight flush has a high card of 14 (Ace) then it's a Royal Flush
        if straightFlushHigh == 14 {
            royalFlush = 1
        }

        // Setting up the return vars
        var returnStrength: Result = Result.notSet
        var returnHigh = 0
        var handDesc: ResultDescription = ResultDescription.notSet

        // To check the final result, we check from the strogest hand down.
        // once a hand has been determined there is no need to keep checking.
        // In a case of nothing relevant, the player has a high card
        if royalFlush != 0 {
            handDesc = .royalFlush
            returnStrength = .royalFlush
            returnHigh = 14
        } else if straightFlushHigh != 0 {
            handDesc = .straightFlush
            returnStrength = .straightFlush
            returnHigh = straightFlushHigh
        } else if four != 0 {
            handDesc = .fourOfAKind
            returnStrength = .fourOfAKind
            returnHigh = four
        } else if fullHouseHigh != 0 {
            handDesc = .fullHouse
            returnStrength = .fullHouse
            returnHigh = fullHouseHigh
        } else if flushHigh != 0 {
            handDesc = .flush
            returnStrength = .flush
            returnHigh = flushHigh
        } else if straightHigh != 0 {
            handDesc = .straight
            returnStrength = .straight
            returnHigh = straightHigh
        } else if three != 0 {
            handDesc = .threeOfAKind
            returnStrength = .threeOfAKind
            returnHigh = three
        } else if pairCount != 0 {
            handDesc = pairCount == 2 ? .twoPair : .onePair
            returnStrength = pairCount == 2 ? .twoPair : .onePair
            returnHigh = pairsHigh
        } else if highCard != 0 {
            handDesc = .highCard
            returnStrength = .highCard
            returnHigh = highCard
        }

        return (returnStrength, returnHigh, handDesc)
    }

    static func comparePlayerResults(players: [Player]) -> String {
        var control = 0
        var control2 = 0
        var winner = ""

        // To determine the winner we loop through all their hands
        // First we check the hand strength, if there are 2 people 1 pair for example, or a straight,
        // we then compare the high card in a straight or the highest pair in a pair.
        for player in players {
            if player.handResult.strength.rawValue > control {
                control = player.handResult.strength.rawValue
                control2 = player.handResult.highCard
                winner = "\(player.name) won with \(player.handResult.hand)"
            } else if player.handResult.strength.rawValue == control {
                if player.handResult.highCard > control2 {
                    control = player.handResult.strength.rawValue
                    control2 = player.handResult.highCard
                    winner = "\(player.name) won with \(player.handResult.hand)"
                }
            }
        }

        return winner
    }
}
