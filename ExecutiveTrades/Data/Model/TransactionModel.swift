//
//  TransactionModel.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 6/2/22.
//

import Foundation

// MARK: - Transaction
struct Transaction: Codable {
    let sku, amount, currency: String
}

typealias Transactions = [Transaction]
