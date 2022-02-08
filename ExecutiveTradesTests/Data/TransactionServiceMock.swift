//
//  TransactionServiceMock.swift
//  ExecutiveTradesTests
//
//  Created by Andrés García on 8/2/22.
//

import Foundation

class TransactionServiceMock: GNBService, TransactionService {
    
    override init(){
        super.init()
    }
    
    func callService(success: @escaping (Transactions) -> Void) {
        
    }
}
