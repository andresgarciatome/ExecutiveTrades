//
//  ProductCell.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 6/2/22.
//

import UIKit

class TransactionCell: UITableViewCell {
    @IBOutlet weak var skuLabel: UILabel!
    @IBOutlet weak var productlLabel: UILabel!
    @IBOutlet weak var sellsLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(model: TransactionCellModel) {
        //Config styling
        productlLabel.paragrafPrimaryText()
        sellsLabel.numbersText()
        skuLabel.idText()
        
        //Setting text
        productlLabel.text = model.productText
        sellsLabel.text = model.sellsText
        skuLabel.text = model.transactionIDText
        
        selectionStyle = .none
        
    }
    
}

class TransactionCellModel {
    var transactionIDText: String = Skeleton.labelText
    var productText: String = Skeleton.labelText
    var sellsText: String = Skeleton.labelText
    
    init(transactionID: Int, product: String, sells: Float, currency: CurrencyType) {
        productText = product
        sellsText = String(format: "%.2f %@", sells, currency.rawValue)
        transactionIDText = String(format: "%05d", transactionID + 1)
    }
    
}
