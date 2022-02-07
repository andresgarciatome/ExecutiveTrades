//
//  ProductViewModel.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 6/2/22.
//

import Foundation

struct Products {
    let name, quantity: String
}

class ProductViewModel {
    private let manager = TransactionManager.sharedTransactionManager
    private var productSells = Skeleton.labelText
    
    func loadData(success: @escaping () -> Void) {
        if let product = manager.getSelectedProduct() {
            manager.countTotalTransactionFromProductSku(sku: product.name) { quantity in
                self.productSells = String(format: "%.2f %@", quantity, self.manager.userCurrency.rawValue)
                success()
            }
        }
    }
    
    func getProductsName() -> String {
        if let product = manager.getSelectedProduct() {
            return product.name
        }
        return Skeleton.labelText
    }
    
    func getQuantity() -> String  {
        return productSells
    }
    
    //Create a cellModel from transaction index
    func getTransactions(indexPath: IndexPath) -> TransactionCellModel {
        let transaction = manager.getTransactionFromIndex(index: indexPath.row)
        let amount = Float(transaction.amount) ?? Float(0)
        return TransactionCellModel(transactionID: indexPath.row, product: transaction.sku, sells: amount, currency: .Euro)
    }
    
    func countTransactions() -> Int {
        return manager.countTransactions()
    }
}
