//
//  players.swift
//  five_card_draw
//
//  Created by Joshua Erasmus on 2021/02/07.
//

class Player {
    var name: String
    var isUser: Bool
    var hand: [Card] = []
    var handResult: Evaluation = Evaluation(handStrength: .notSet, handHHighCard: 0, holding: "")
    init(name: String, isUser: Bool) {
        self.name = name
        self.isUser = isUser
    }
}

class Group {
    static let singleton = Group()

    var players: [Player] = []
    func addPlayer(newPlayer: Player) {
        players.append(newPlayer)
    }

    // As explained the extension, this is shifts all players up 1 spot to simulate changing blinds
    func changeBlinds() {
        players.shiftRight()
    }
}
