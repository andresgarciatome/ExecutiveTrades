//
//  TransactionManager.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 5/2/22.
//

import Foundation

// MARK: - Transaction

// TODO: Trasladar a propio fichero
struct Product {
    let name: String
    let quantity: Float
}

typealias UniqueProducts = [Product]
// end TODO

class TransactionManager: GNBManager {
    var userCurrency: CurrencyType = .Euro
    
    private let currencyService: CurrencyService?
    private let transactionService: TransactionService?
    private let queue = DispatchQueue(label: QueueTypes.service)
    
    private var uniqueProducts: UniqueProducts = []
    private var allTransactions: Transactions = []
    private var productTransaction: Transactions = []
    private var selectdProduct: Product?
    
    
    // MARK: - Instance method's
    
    #if TEST
    init(currency: CurrencyService , transaction: TransactionService) {
        currencyService = currency
        transactionService = transaction
        loadCurrencies()
    }
    #else
    static public let sharedTransactionManager = TransactionManager(currency: CurrencyServiceImpl(), transaction: TransactionServiceImpl())
    
    //instance to singletone
    private init(currency: CurrencyService , transaction: TransactionService) {
        currencyService = currency
        transactionService = transaction
        //All currencies are obtained in the Manager instance to optimize data loading.
        loadCurrencies()
    }
    #endif
    
    // MARK: - Products
    func callProducts(success: @escaping () -> Void) {
        // check it a cache
        if !self.uniqueProducts.isEmpty {
            success()
        }
        
        //Get a list of transactions
        self.transactionService?.callService(success: { transactions in
            self.queue.async {
                self.allTransactions = transactions
                //Get the Uniques products of list of transactions
                var seenBarValues = Set<String>()
                let filteredArray = transactions.filter {
                    seenBarValues.insert($0.sku).inserted
                }
                for element in filteredArray {
                    //Count All transaction of product
                    self.countTotalTransactionFromProductSku(sku: element.sku) { total in
                        self.queue.async {
                            //ApplyRoundHalf
                            let product = Product(name: element.sku, quantity: total.roundHalfToEven())
                            self.uniqueProducts.append(product)
                            success()
                        }
                    }
                }
            }
        })
    }
    
    func getProductFromIndex(index:Int) -> Product?{
        if !uniqueProducts.isEmpty || uniqueProducts.count > index {
            return uniqueProducts[index]
        }
        return nil
    }
    
    func setSelectedProduct(index:Int) {
        selectdProduct = getProductFromIndex(index: index)
    }
    
    func getSelectedProduct() -> Product?{
        return selectdProduct
    }
    
    func numOfProducts() -> Int {
        return uniqueProducts.count
    }
    
    //Count All transaction of product find by index
    func countTotalTransactionFromProductIndex(index: Int, success: @escaping (Float) -> Void){
        if !uniqueProducts.isEmpty || uniqueProducts.count > index {
            countTotalTransactionFromProductSku(sku: uniqueProducts[index].name, success: success)
        }
    }
    
    //Count All transaction of product find by identificator sku
    func countTotalTransactionFromProductSku(sku:String, success: @escaping (Float) -> Void) {
        var total = Float(0)
        transactionService?.callService(success: { transactions in
            self.queue.async {
                //Filtrer transactions with same sku
                self.productTransaction = transactions.filter { $0.sku == sku}
                let myGroup = DispatchGroup()
                
                for transaction in self.productTransaction {
                    myGroup.enter()
                    //Convert quantity to userCurrency constant define
                    self.getQuantity(quantity: Float(transaction.amount) ?? Float(0), fromCurrency: CurrencyType(rawValue: transaction.currency) ?? .Euro, toCurrency: self.userCurrency) { quantity in
                        total += quantity
                        myGroup.leave()
                    }
                    total += Float(transaction.amount) ?? Float(0)
                }
                
                myGroup.notify(queue: .main) {
                    //When dispatch group is ended call success
                    success(total)
                }
            }
        })
    }
    
    // MARK: - Transactions
    func getTransactionFromIndex(index: Int) -> Transaction {
        return productTransaction[index]
    }
    
    func countTransactions() -> Int {
        productTransaction.count
    }
    
    // MARK: - Currencies
    private func loadCurrencies(){
        //success not needed
        currencyService?.callService() { _ in
        }
    }
    
    func getQuantity(quantity: Float, fromCurrency: CurrencyType, toCurrency: CurrencyType, success: @escaping (Float) -> Void) {
        currencyService?.callService() { currencies in
            let rate = self.getRate(fromCurrency: fromCurrency, toCurrency: toCurrency, currencies: currencies)
            //The calculated conversion is stored so as not to have to make the recursive call again, the load is optimized
            self.currencyService?.setCalculateCurrencies(currency: Currency(from: fromCurrency.rawValue, to: toCurrency.rawValue, rate: String(rate)))
            success(rate)
        }
    }
    
    func getRate(fromCurrency: CurrencyType, toCurrency: CurrencyType, currencies: Currencies) -> Float {
        let fromValues = currencies.filter { $0.from == fromCurrency.rawValue}
        let toValues = fromValues.filter { $0.from == fromCurrency.rawValue && $0.to == toCurrency.rawValue }
        if toCurrency == fromCurrency {
            return 1
        }
        //Search if exist equivalence
        if let rate = toValues.first?.rate, let rateValue = Float(rate) {
            return rateValue
        }
        if let first = fromValues.first,  let rate = Float(first.rate) {
            //Call recursive to get the rate
            return getRate(fromCurrency: CurrencyType.init(rawValue: first.to) ?? .Euro, toCurrency: toCurrency, currencies: currencies) * rate
        } else {
            print("Have some error")
            return 0
        }
    }
}
