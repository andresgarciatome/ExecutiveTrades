//
//  CurrencyService.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 4/2/22.
//

import Foundation
import Alamofire

class CurrencyServiceImpl: GNBService, CurrencyService {
    
    private var currenciesCache: Currencies?
    
    override init(){
        super.init()
        url = EndPoints.rates
    }
    
    func callService(success: @escaping (Currencies) -> Void) {
        //Control not found URL
        guard let aUrl = url else{
            print(Errors.notFoundUrl)
            return
        }
        
        //If have cache show a cache
        if let cache = currenciesCache {
            success(cache)
            return
        }
        
        let request = AF.request(aUrl)
        request.responseDecodable { (response: DataResponse<Currencies, AFError>) in
            guard let currencies = response.value else {
                return
            }
            //save currencies cache
            self.currenciesCache = currencies
            success(currencies)
        }
    }
    
    func setCalculateCurrencies(currency:Currency){
        self.currenciesCache?.append(currency)
    }
}

protocol CurrencyService: GNBService {
    // MARK: Method to call Services
    func callService(success: @escaping (Currencies) -> Void)
    func setCalculateCurrencies(currency:Currency)
}

