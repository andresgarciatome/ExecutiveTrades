//
//  TransactionService.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 4/2/22.
//

import Foundation
import Alamofire


class TransactionServiceImpl: GNBService, TransactionService {
    
    private var transactionCache: Transactions?
    
    override init(){
        super.init()
        url = EndPoints.transactions
    }
    
    func callService(success: @escaping (Transactions) -> Void) {
        //Control not found URL
        guard let aUrl = url else{
            print(Errors.notFoundUrl)
            return
        }
        
        //If have cache show a cache
        if let cache = transactionCache {
            success(cache)
            return
        }
        
        let headers: HTTPHeaders = [
            .accept(EndPoints.httpHeaderJson)
        ]
        let request = AF.request(aUrl,headers: headers)
        
        request.responseDecodable { (response: DataResponse<Transactions, AFError>) in
            guard let transactions = response.value else {
                //It remains to implement connection error system
                print(Errors.conectionError)
                return
            }
            //save currencies cache
            self.transactionCache = transactions
            success(transactions)
        }
    }
}

