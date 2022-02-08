//
//  CurrenciesConvertion.swift
//  ExecutiveTradesTests
//
//  Created by Andrés García on 8/2/22.
//

import XCTest
@testable import ExecutiveTrades

class CurrenciesConvertionTests: XCTestCase {
    var transaction: TransactionManager?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        transaction = TransactionManager(currency: CurrencyServiceMock(), transaction: TransactionServiceMock())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConvertion(){
        let quantity = TestValues.currencyConversionTestQuantity
        let result = TestValues.currencyConversionTestResult
        
        //Get Rate and apply roundHalfToEven to check to functions
        transaction?.getQuantity(quantity: quantity, fromCurrency: .UnitedStatesDollar, toCurrency: .Euro, success: { rate in
            let roundedRate = rate.roundHalfToEven()
            XCTAssertTrue(roundedRate == result)
        })
    }
}
