//
//  ProductViewController.swift
//  ExecutiveTrades
//
//  Created by Andrés García on 6/2/22.
//

import UIKit

class ProductViewController: GNBViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var product: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    private let defaultSize = Sizes.cellDefault
    private let model = ProductViewModel()
    
    // MARK: lifeCycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        //Load service
        model.loadData {
            self.product.text = self.model.getProductsName()
            self.quantity.text = self.model.getQuantity()
        }
        
        configTableView()
        product.titlePrimaryText()
        quantity.numbersText()
    }
    
    func configTableView() {
        tableView.register(UINib(nibName: FileName.transactionCell, bundle: nil), forCellReuseIdentifier: CellID.transaction)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - DataSource and Delegate of TableView method's
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberRows = model.countTransactions()
        tableViewHeight.constant = CGFloat(numberRows * defaultSize)
        return numberRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellID.transaction, for: indexPath) as? TransactionCell {
            cell.configCell(model: model.getTransactions(indexPath: indexPath))
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - Show VC Method's
    static func pushViewController(nvc: UINavigationController?){
        let storyboard = UIStoryboard(name: FileName.mainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerID.product)
        nvc?.pushViewController(vc, animated: true)
    }
}
