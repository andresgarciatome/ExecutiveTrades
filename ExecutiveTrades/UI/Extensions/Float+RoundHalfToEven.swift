//
//  Float+RoundHalfToEven.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 7/2/22.
//

import Foundation

extension Float{
    func roundHalfToEven() -> Float {
        let changedQuantity = Double(self * Number.hundred)
        return Float(lrint(changedQuantity)) / Number.hundred
    }
}
