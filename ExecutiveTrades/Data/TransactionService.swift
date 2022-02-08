//
//  TransactionService.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 8/2/22.
//

import Foundation

protocol TransactionService: GNBService {
    // MARK: Method to call Services
    func callService(success: @escaping (Transactions) -> Void)
}
