//
//  Constants.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 7/2/22.
//

import Foundation

struct QueueTypes {
    static let service = "service-call"
}

struct EndPoints {
    static let rates = "http://quiet-stone-2094.herokuapp.com/rates"
    static let transactions = "http://quiet-stone-2094.herokuapp.com/transactions"
    static let httpHeaderJson = "application/json"
}

struct Errors {
    static let notFoundUrl = "Not URL founded"
    static let conectionError = "It remains to implement connection error system"
}

struct CellID {
    static let product = "productCell"
    static let transaction = "transactionCell"
}

struct FileName {
    static let productCell = "ProductCell"
    static let transactionCell = "TransactionCell"
    static let gifLoading = "loading"
    static let mainStoryboard = "Main"
}

struct AssetName {
    static let GNB = "Logo"
}

struct ViewControllerID {
    static let product = "productViewController"
}

struct Skeleton {
    static let labelText = "-"
}

struct Number {
    static let hundred = Float(100)
}


