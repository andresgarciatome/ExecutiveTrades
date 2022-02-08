//
//  CurrencyService.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 8/2/22.
//

import Foundation

protocol CurrencyService: GNBService {
    // MARK: Method to call Services
    func callService(success: @escaping (Currencies) -> Void)
    func setCalculateCurrencies(currency:Currency)
}
