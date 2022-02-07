//
//  ProductCell.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 6/2/22.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet weak var productlLabel: UILabel!
    @IBOutlet weak var sellsLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(model: ProductCellModel) {
        //Config styling
        productlLabel.paragrafPrimaryText()
        sellsLabel.numbersText()
        
        //Setting text
        productlLabel.text = model.productText
        sellsLabel.text = model.sellsText
        
        selectionStyle = .none
    }
    
}

class ProductCellModel {
    var productText: String = Skeleton.labelText
    var sellsText: String = Skeleton.labelText
    
    init(product: String, sells: Float, currency: CurrencyType) {
        productText = product
        sellsText = String(format: "%.2f %@", sells, currency.rawValue)
    }
    
}
