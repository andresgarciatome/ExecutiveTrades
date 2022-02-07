//
//  CurrenciesModel.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 4/2/22.
//

import Foundation

// MARK: - Currency
struct Currency: Codable {
    let from, to, rate: String
}

typealias Currencies = [Currency]
