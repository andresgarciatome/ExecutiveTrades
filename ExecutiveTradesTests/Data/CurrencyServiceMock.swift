//
//  CurrencyServiceMock.swift
//  ExecutiveTradesTests
//
//  Created by Andrés García on 8/2/22.
//

import Foundation

class CurrencyServiceMock: GNBService, CurrencyService {
    
    //Return the currencies to test functionality
    /*Example
        USD -> AUD is 1.40
        AUD -> EUR is 0.63
        USD -> EUR is 1.40 x 0.63 ≈ 0.88
     */
    func callService(success: @escaping (Currencies) -> Void) {
        //Control not found URL
        var currencies: Currencies = []
        currencies.append(Currency(from: CurrencyType.UnitedStatesDollar.rawValue, to: CurrencyType.AustralianDollar.rawValue, rate: String(1.40)))
        currencies.append(Currency(from: CurrencyType.AustralianDollar.rawValue, to: CurrencyType.Euro.rawValue, rate: String(0.63)))
        success(currencies)
    }
    
    func setCalculateCurrencies(currency:Currency){
    }
}

