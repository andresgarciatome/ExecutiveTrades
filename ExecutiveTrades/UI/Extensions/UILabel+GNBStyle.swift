//
//  UILabel+GNBStyle.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 6/2/22.
//

import UIKit

extension UILabel {
    
    func titlePrimaryText() {
        self.textColor = UIColor.init(named: Color.primary)
        self.font = self.font.withSize(Sizes.titleSize)
    }
    
    func titleSecondaryText() {
        self.textColor = UIColor.init(named: Color.secondary)
        self.font = self.font.withSize(Sizes.titleSize)
    }
    
    func paragrafPrimaryText() {
        self.textColor = UIColor.init(named: Color.primary)
        self.font = self.font.withSize(Sizes.paragrafSize)
    }
    
    func numbersText() {
        self.textColor = UIColor.init(named: Color.numbers)
        self.font = self.font.withSize(Sizes.paragrafSize)
    }
    
    func idText() {
        self.textColor = UIColor.init(named: Color.numbers)
        self.font = self.font.withSize(Sizes.legalSize)
    }
    
}
