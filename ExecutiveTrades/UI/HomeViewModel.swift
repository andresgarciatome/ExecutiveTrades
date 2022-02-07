//
//  HomeViewModel.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 6/2/22.
//

import Foundation

class HomeViewModel {
    let manager = TransactionManager.sharedTransactionManager
    
    func loadData(success: @escaping () -> Void) {
        manager.callProducts(success: success)
    }
    
    func getProducts(indexPath: IndexPath) -> ProductCellModel {
        if let product = manager.getProductFromIndex(index: indexPath.row) {
            return ProductCellModel(product: product.name, sells:product.quantity, currency: .Euro)
        }
        return ProductCellModel(product: Skeleton.labelText, sells: 0, currency: .Euro)
    }
    
    func getNumProducts() -> Int {
        return manager.numOfProducts()
    }
    
    func setSelectedProduct(index: Int) {
        manager.setSelectedProduct(index: index)
    }
    
}
