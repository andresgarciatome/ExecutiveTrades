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
        
        let headers: HTTPHeaders = [
            .accept(EndPoints.httpHeaderJson)
        ]
        
        let request = AF.request(aUrl,headers: headers)
        request.responseDecodable { (response: DataResponse<Currencies, AFError>) in
            guard let currencies = response.value else {
                //It remains to implement connection error system
                print(Errors.conectionError)
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



