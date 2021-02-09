//
//  extensions.swift
//  five_card_draw
//
//  Created by Joshua Erasmus on 2021/02/07.
//

// This is used to "Change the blinds" This changes the position of the players in the array.
// This way we always start on index 0
extension Array {
    mutating func shiftRight() {
        if let obj = self.popLast(){
            self.insert(obj, at: 0)
        }
    }
}
